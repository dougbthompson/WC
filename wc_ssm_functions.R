
# 596e891eefec720e04422e7d
wc_gen_ssm_track = function(wc_id, db_connection) {

  embargountil = NA

  query = paste0("select e.event_id,e.ptt,t.embargountil from biologging.event e, atn_all_locations l, atn_track t where l.wc_id = '",
                 wc_id,"' and e.ptt = l.ptt and e.event_id = t.eventid limit 1;")
  event_data <- dbGetQuery (db_connection, query)

  if (nrow(event_data) > 0) {

  embargountil <- event_data$embargountil

  query <- paste0("select data_date,longitude,latitude from atn_all_locations where wc_id = '",wc_id,"' and ptt = ",event_data$ptt,";")
  location_data <- dbGetQuery (db_connection, query)

  data_dir <- '/home/dougt/wc/wc/data/'
  location_filename <- paste0(data_dir, event_data$event_id, 'ssm.txt')
  the_event_id <- event_data$event_id

  if (nrow(location_data)) {
    csv_data <- dplyr::transmute(
             location_data
            ,datesec = as.character(strptime(data_date, format = "%H:%M:%OS %d-%b-%Y"))
            ,lon     = ((as.numeric(as.character(longitude))+180) %% 360) - 180
            ,lat     = as.numeric(as.character(latitude))
            ,lon025  = -999
            ,lat025  = -999
            ,lon5    = -999
            ,lat5    = -999
            ,lon975  = -999
            ,lat975  = -999
            ,mplon   = -999
            ,mplat   = -999
            ,id      = the_event_id
           )

      write.table (csv_data, file = '/tmp/tmpr', quote=F, col.names=F, row.names=F, sep=',')
      system (paste0('sort /tmp/tmpr > /tmp/tmps'))

      csv_sorted <- read.table (file = '/tmp/tmps', header=F, sep=',')
      # names(csv_sorted) <- c('datesec', 'lon', 'lat')
      names(csv_sorted) <- c('datesec','lon','lat','lon025','lat025','lon5','lat5','lon975','lat975','mplon','mplat','id')

      new_csv_sorted <- dplyr::transmute(
        csv_sorted,datesec = as.character(format(strptime(datesec,'%Y-%m-%d %H:%M:%S'), '%m/%d/%Y %H:%M:%S'))
       ,lon     = ((as.numeric(as.character(lon))+180) %% 360) - 180
       ,lat     = as.numeric(as.character(lat))
       ,lon025  = -999
       ,lat025  = -999
       ,lon5    = -999
       ,lat5    = -999
       ,lon975  = -999
       ,lat975  = -999
       ,mplon   = -999
       ,mplat   = -999
       ,id      = id
       )

      write.csv (new_csv_sorted, file = location_filename, quote=F, row.names=F)
      system (paste0('chmod ugo+rwx ', location_filename))

      # system (paste('scp', location_filename,
      #   if (is.null(embargountil)) {
      #            'vmuser@mola:/var/www/html/atnupload/uploads/'
      #   } else { 'vmuser@mola:/var/www/html/atnupload/embargos/' }
      # )
  }
  }
}

