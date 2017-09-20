
# options(error=recover)
library(data.table)
library(plyr)
library(RPostgreSQL)

source ('wc_functions.R')

wc_spreadsheet = function(id, db_connection) {

  request <- paste0('action=download_deployment&id=', id)
  response <- fetch_wc_raw(request)
  zip_contents  <- response$content

  # zip_temp_dir <- tempdir()
  zip_temp_dir = paste0('/home/dougt/wc/wc/data.all.20170920/')
  ## system (paste0('cd ', zip_temp_dir))
  system (paste0('cd ', zip_temp_dir, '; mkdir ', id, '; cd ', id))

  # new lower nested temp directory (the wc_id)
  zip_temp_dir <- paste0(zip_temp_dir, id, '/')
  zip_file_name <- paste0(zip_temp_dir, id, '.zip')

  zip_fd <- file(zip_file_name, 'wb')
  writeBin (zip_contents, zip_fd)
  close(zip_fd)

  system (paste0('cd ', zip_temp_dir, '; unzip -o ', zip_file_name))
  csv_filename <- dir(zip_temp_dir, '*.csv', full.names=T)

  # also *.kmz and .prv files

  table_names <- tolower(sub('.csv','',sub('.*-','',csv_filename)))
  df_list <- alply(.data=as.array(csv_filename), .margins=1, .fun=function(csv_filename) {
    command <- (paste("sed '/^[,\\cM]*\\$/d'", csv_filename))
    data    <- fread(command)
    data[is.na(data)] <- ''
    names(data)       <- tolower(names(data))
    cbind(data, id)
  })

  names(df_list) <- c(table_names)

  # if the table already exists, insert into it, otherwise write a new table
  for (name in table_names)  {
    print (paste(id, name))
    df <- df_list[[name]]
    # dbWriteTable (conn=db_connection, name=paste0('wc_zip_', name), append=T, row.names=F, value=df)
  }
}

