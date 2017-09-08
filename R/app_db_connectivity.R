#!/usr/bin/R

###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
###

app_db_connection_open = function(app_db) {

  app_db_connection <<- dbConnect(drv = PostgreSQL(),
                    ### host_name = app_db@host_name,
                        port      = app_db@port_number,
                        dbname    = app_db@database_name, 
                        user      = app_db@user_name,
                        password  = app_db@password)

  return (app_db_connection)
}

app_db_connection_close = function(app_db) {

    dbDisconnect(app_db)

}

