#!/usr/bin/R

###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
###

main = function() {
    source ('r_init.R')
    source ('wc_init.R')
    source ('app_init.R')

    source ('app_db_init.R')
    db_params <- app_db_params()

    source ('app_db_connectivity.R')
    db_connection <- app_db_connection_open(db_params)

    source ('wc_functions.R')
    source ('app_functions.R')

    source ('app_db_functions.R')
    app_db_truncate (db_connection)

    all_deployments <- fetch_all_deployments()
    pg_all_deployments <- sqldf("select * from all_deployments", drv="SQLite")
    dbWriteTable (db_connection, "tmp_all_deployments", value=pg_all_deployments, append=TRUE, row.names=FALSE);

    for (wc_id in all_deployments$wc_id) {
      # print (wc_id)
      all_locations <- fetch_all_locations (id=wc_id)
      if (nrow(all_locations) > 0) {
        pg_all_locations <- sqldf(paste0("select '",wc_id,"' as wc_id, z.* from all_locations z"), drv="SQLite")
        dbWriteTable (db_connection, "tmp_all_locations", value=pg_all_locations, append=TRUE, row.names=FALSE);

        data_dir = '/home/dougt/wc/wc/data/'
        saveRDS (file=paste0(data_dir, wc_id, '.rds'), object=all_locations)
        write.table (file=paste0(data_dir, wc_id, '.csv'), all_locations, row.names=F, quote=T, sep=',')
      }
    }

    all_deployment_profiles <- fetch_all_deployment_profiles()
    pg_all_deployment_profiles <- sqldf("select * from all_deployment_profiles", drv="SQLite")
    dbWriteTable (db_connection, "tmp_all_deployment_profiles", value=pg_all_deployment_profiles, append=TRUE, row.names=FALSE);

    for (wc_id in all_deployment_profiles$wc_id) {
      print (wc_id)
      all_profiles <- fetch_all_profiles (id=wc_id)
      if (nrow(all_profiles) > 0) {
        pg_all_profiles <- sqldf(paste0("select '",wc_id,"' as wc_id, z.* from all_profiles z"), drv="SQLite")
        dbWriteTable (db_connection, "tmp_all_profiles", value=pg_all_profiles, append=TRUE, row.names=FALSE);
      }
    }

    app_db_refresh (db_connection)
    app_db_connection_close (db_connection)
}

main()

