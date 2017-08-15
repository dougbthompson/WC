#!/usr/bin/R

###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
###

  coalesce.as.numeric = function(x,y){coalesce(as.numeric(x),as.numeric(y))}
  lacking_eventid <<- anti_join(all_deployments, wc, 'wc_id')
  having_eventid  <<- inner_join(all_deployments, wc, 'wc_id')
  added_eventid   <<- adply(lacking_eventid,1,function(r){
    query = sprintf('
            with rows as (
                INSERT INTO atn.deployment(species_code,two_digit_year)
                VALUES (%d,%d) RETURNING deployment_id
            )
            INSERT INTO atn.event(deployment_id, multi_tag_serial,pttnumber)
            SELECT deployment_id,0 as multi_tag_serial, %s
            FROM rows returning event_id as eventid
            '
           ,r$speciescode
           ,r$two_digit_year
           ,r$argos.ptt_decimal)
  
      eventid= dbGetQuery(con, query)$eventid
      query = sprintf( '
              INSERT INTO atn.wc(eventid,wc_id) VALUES (%d,\'%s\')
              '
             ,eventid
             ,r$wc_id)
  
      chatter = dbGetQuery(con,query)
      data.frame(eventid= eventid)
    })

  all_metadata = rbind.fill(having_eventid, added_eventid)

  if (file.exists(old_metadata_path)) {
    load(file=old_metadata_path)
  } else {
    previous_metadata = all_metadata[F,]
  }

  new_metadata = anti_join(all_metadata,previous_metadata,by=intersect(names(all_metadata),names(previous_metadata)))
  previous_metadata = all_metadata
  save(file=old_metadata_path, previous_metadata)

  anti_join(all_metadata, atn_track_qc, by=c("eventid")) %>%
      mutate(
       priority=0
      ,ssm_tr=0
      ,vis_prob=0
      ,rerun=0
      ,atn_replaced= 0
      ,embargountil=today()+365
      ,embargolon=NA
      ,embargolat=NA
      ,vis_filter=0
      ,plot_points=1
      ) -> new_atn_track_qc_row

    insert_into_orig_table(
     connection=con
    ,new_df_name='new_atn_track_qc_row'
    ,orig_table_name='atn_track_qc'
    )

  ### format & filter the deployments that have new locations into SSM style files.
  ### the deployments that have no new data will already have SSM files.
  a_ply(new_metadata, 1, function(r) {

    ### all the stuff to filter locations is not needed because alans just uses the gps
    location_filename=paste0(data_dir, '/',r$eventid,'SSM.txt')
    profile_filename=paste0(data_dir, '/',r$eventid,'SSM.profile.txt')
    readRDS(file=paste0(data_dir, '/',r$wc_id,'.rds')) -> raw_data

    if (nrow(raw_data)) {
      julian_unix_day_0 = 2440587.500000
      seconds_per_day = 24 * 60 * 60

      raw_data %>%
        transmute(
          lat1        = latitude
         ,lat2        = latitude
         ,long1       = longitude
         ,long2       = longitude
         ,lc          = location_class
         ,decimal_day = (date/seconds_per_day) + julian_unix_day_0) -> filter_input

      csv = paste0(data_dir,'/',r$eventid,'.csv')
      write.table(file=csv, filter_input, row.names=F, quote=F,sep='\t')

      fread(paste('ssh argos@mola "nosql repair | bin/tab2tabFilter filterLand" <',csv)) %>%
        filter(passed==1) -> filter_output

      if (nrow(filter_output)) {
        filter_output %>%
        transmute(
           date = (decimal_day - julian_unix_day_0) * seconds_per_day 
          ,latitude = lat
          ,longitude = long
          ,location_class = lc
        ) -> filtered_argos 
  
        transmute(
           filtered_argos 
          ,datesec = format(anytime(as.numeric(as.character(date))+0), '%m/%d/%Y %H:%M')
          ,lon= ((as.numeric(as.character(longitude))+180) %% 360) - 180 # ensure lon range -180 to +180 for argos filters
          ,lat=as.numeric(as.character(latitude))
  
          ,lon025=-999 ,lat025=-999 ,lon5=-999 ,lat5=-999
          ,lon975=-999 ,lat975=-999 ,mplon=-999 ,mplat=-999
          ,id=r$eventid
        ) ->.;
  
        write.csv(.,file=location_filename,quote=F,row.names=F)
        system(paste('chmod ugo+rwx', location_filename))
        system(paste('scp', location_filename, 'vmuser@mola:/var/www/html/atnupload/embargos/'))
      }
    }
  })

} ### end of old main

