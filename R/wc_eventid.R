
select e.embargountil,e.eventid
  from topp.deployment d
       join eventid_combined_with_ownerid e on (d.ptt_decimal = e.ptt)
 where d.owner !~ 'Skomal'
   and d.wc_id  = v_wc_id



harvest_data = function(wc_id) {
  query = paste0("select e.embargountil,e.eventid from ", schema, ".deployment d join eventid_combined_with_ownerid e
                        on (d.ptt_decimal = e.ptt)
                        where owner !~ 'Skomal' and d.wc_id = '"
  , wc_id
  , "'"
  )
  eventid_and_embargountil= dbGetQuery(
    con
  , query
  )

  if (prod(dim(eventid_and_embargountil))<2) { return(NULL) }

  eventid=eventid_and_embargountil$eventid
  embargountil=eventid_and_embargountil$embargountil

  query=paste0(
    "select * from "
  , schema
  , ".locations where wc_id = '"
  , wc_id
  , "'"
  )
  location= dbGetQuery(
    con
  , query
  )

  location_filename=paste0(data_dir, '/',eventid,'SSM.txt')

  if (nrow(location)) {
    dplyr::transmute(
             location
            ,datesec=format( date ,'%m/%d/%Y %H:%M')
            ,lon= ((as.numeric(as.character(longitude))+180) %% 360) - 180 # ensure lon range -180 to +180 for argos filters
            ,lat=as.numeric(as.character(latitude))
            ,lon025=-999
            ,lat025=-999
            ,lon5=-999
            ,lat5=-999
            ,lon975=-999
            ,lat975=-999
            ,mplon=-999
            ,mplat=-999
            ,id=eventid
           ) %>%
      write.csv(file=location_filename,quote=F,row.names=F)
    system(paste('chmod ugo+rwx', location_filename))
    system(
      paste(
        'scp'
      , location_filename
      , if (is.null(embargountil)){
          'vmuser@mola:/var/www/html/atnupload/uploads/'
        } else {
          'vmuser@mola:/var/www/html/atnupload/embargos/'
        }
      )
    )
  }
}

