
# options(error=recover)
library(data.table)
library(plyr)
library(RPostgreSQL)

source ('wc_functions.R')

wc_spreadsheet = function(wc_id, db_connection) {

  res <- dbGetQuery(db_connection, "set search_path = biologging, public, aatams, postgis")

  request <- paste0('action=download_deployment&id=', wc_id)
  response <- fetch_wc_raw(request)
  zip_contents  <- response$content

  # zip_temp_dir <- tempdir()
  zip_temp_dir = paste0('/home/dougt/wc/wc/data.all.20170920/')
  ## system (paste0('cd ', zip_temp_dir))
  system (paste0('cd ', zip_temp_dir, '; mkdir ', wc_id, '; cd ', wc_id))

  # new lower nested temp directory (the wc_id)
  zip_temp_dir <- paste0(zip_temp_dir, wc_id, '/')
  zip_file_name <- paste0(zip_temp_dir, wc_id, '.zip')

  zip_fd <- file(zip_file_name, 'wb')
  writeBin (zip_contents, zip_fd)
  close(zip_fd)

  system (paste0('cd ', zip_temp_dir, '; unzip -o ', zip_file_name))
  csv_filename <- dir(zip_temp_dir, '*.csv', full.names=T)

  # do something with *.kmz and .prv files

  # check for multiple *FastGPS.csv and *Locations.csv files
  fas <- dir(zip_temp_dir, '*FastGPS.csv', full.names=T)
  if (length(fas) == 2) { idx <- match(fas[1], csv_filename) }
  csv_filename[idx]=NA
  loc <- dir(zip_temp_dir, '*Locations.csv', full.names=T)
  if (length(loc) == 2) { idx <- match(loc[1], csv_filename) }
  csv_filename[idx]=NA

  # fastgps has blank lines at the top, eliminate them
  # fas <- dir(zip_temp_dir, '*FastGPS.csv', full.names=T)
  # system (paste0(''))

  csv_filename <- csv_filename[!is.na(csv_filename)]

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
    dbWriteTable (conn=db_connection, name=paste0('wc_zip_', name), append=F, row.names=F, value=df)
  }
}

