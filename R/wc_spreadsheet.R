
# options(error=recover)
library(data.table)
library(plyr)
library(RPostgreSQL)

source ('wc_functions.R')
source ('wc_db_functions.R')

wc_spreadsheet = function(wc_id, db_connection) {

  wc_db_truncate(db_connection)
  res <- dbGetQuery(db_connection, "set search_path = biologging, public, aatams, postgis")

  request <- paste0('action=download_deployment&id=', wc_id)
  response <- fetch_wc_raw(request)
  zip_contents  <- response$content

  # zip_temp_dir <- tempdir()
  zip_temp_dir = paste0('/home/dougt/wc/wc/data.all/')
  system (paste0('cd ', zip_temp_dir, '; mkdir ', wc_id, '; cd ', wc_id))

  # new lower nested temp directory (the wc_id)
  zip_temp_dir <- paste0(zip_temp_dir, wc_id)
  zip_file_name <- paste0(zip_temp_dir, '/', wc_id, '.zip')

  zip_fd <- file(zip_file_name, 'wb')
  writeBin (zip_contents, zip_fd)
  close(zip_fd)

  system (paste0('cd ', zip_temp_dir, '; unzip -o ', zip_file_name))
  csv_filename <- dir(zip_temp_dir, '*.csv', full.names=T)

  # do something with *.kmz and .prv files

  # RawArgos may have junk for the last 4 lines?
  raw <- dir(zip_temp_dir, '*RawArgos.csv', full.names=T)
  if (length(raw) > 0) {
    cmd1 <- paste0('mv ',raw[1],' tmp')
    system (cmd1)
    numlines <- length(readLines('tmp')) - 4
    cmd2 <- paste0('head -',numlines,' tmp > ',raw[1],'; rm tmp')
    system (cmd2)
  }

  # behavior csv can have multiple groups of columns ... leave for the time being
  beh <- dir(zip_temp_dir, '*Behavior.csv', full.names=T)
  if (length(beh) > 0) {
    idx <- match(beh[1], csv_filename)
    csv_filename[idx]=NA
  }

  # check for multiple *FastGPS.csv and *Locations.csv files
  # fastgps has blank lines at the top, eliminate them
  fas <- dir(zip_temp_dir, '*FastGPS.csv', full.names=T)
  # print (fas)
  if (length(fas) == 2) {
    cnt1 <- lengths(regmatches(fas[1], gregexpr("-", fas[1])))
    cnt2 <- lengths(regmatches(fas[2], gregexpr("-", fas[2])))

    if (cnt1 == 3) {
      which_fas <- fas[1]
      which_to_delete <- fas[2]
    } else {
      which_fas <- fas[2]
      which_to_delete <- fas[1]
    }

    idx <- match(which_to_delete, csv_filename) 
    system (paste0('rm -f ',csv_filename[idx]))
    csv_filename[idx]=NA

    # duplicate column names! so, strip off the first three ",,,"
    # down below we strip off the column names line...

    cmd <- paste0('mv ',which_fas,' tmp ; cat tmp | awk \'{if(NR>3)print}\' > ',which_fas)
    system (cmd)
  } 

  if (length(fas) == 0) {
    abc <- 'abc'
  } else { # length(fas) = 1
    cmd <- paste0('mv ',fas[1],' tmp ; cat tmp | awk \'{if(NR>3)print}\' > ',fas[1])
    system (cmd)
  }

  loc <- dir(zip_temp_dir, '*Locations.csv', full.names=T)
  if (length(loc) == 2) {
    idx <- match(loc[1], csv_filename)
    system (paste0('rm -f ',csv_filename[idx]))
    csv_filename[idx]=NA
  }

  # clear out any duplicates, if there are any
  csv_filename <- csv_filename[!is.na(csv_filename)]

  # remove the first line, the column names line, let R generate (v1, v2, v3, ..., v99)
  for (name in csv_filename) {
    cmd <- paste0('mv ',name,' tmp ; cat tmp | awk \'{if(NR>1)print}\' > ',name)
    system (cmd)
  }

  table_names <- tolower(sub('.csv','',sub('.*-','',csv_filename)))
  df_list <- alply(.data=as.array(csv_filename), .margins=1, .fun=function(csv_filename) {
    command <- (paste("sed '/^[,\\cM]*\\$/d'", csv_filename))
    data    <- fread(command)
    data[is.na(data)] <- ''
    names(data)       <- tolower(names(data))
    cbind(data, wc_id)
  })

  names(df_list) <- c(table_names)

  # if the table already exists, insert into it, otherwise write a new table
  for (name in table_names)  {
    print (paste(wc_id, name))
    df <- df_list[[name]]
    dbWriteTable (conn=db_connection, name=paste0('wc_zip_', name), append=T, row.names=F, value=df)
    dbGetQuery(db_connection, paste0('select refresh_atn_all_',name,'();'))
  }
}

