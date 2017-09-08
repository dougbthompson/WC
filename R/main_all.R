#!/usr/bin/R

###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
###

main_all = function() {
    source ('r_init.R')
    source ('wc_init.R')
    source ('app_init.R')

    source ('app_init.R')
    app_env <- app_env_params()

    source ('app_db_init.R')
    db_params <- app_db_params()

    source ('app_db_connectivity.R')
    db_connection <- app_db_connection_open(db_params)

    source ('wc_functions.R')
    source ('wc_spreadsheet.R')
    source ('app_functions.R')

    source ('app_db_functions.R')
    app_db_truncate (db_connection)

    all_deployments <- fetch_all_deployments()

    for (wc_id in all_deployments$wc_id) {
      print (wc_id)
      wc_spreadsheet (wc_id, db_connection)
    }
}

main_all()

