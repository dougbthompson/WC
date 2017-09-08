#!/usr/bin/R

###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
###

### define the postgres database connectivity by placing connectivity
### information into this file, and call app_db_init

app_db_init = function() {

  setClass ("app_db_class", representation(host_name="character", port_number="numeric",
            database_name="character", user_name="character", password="character"))

  app_db <- new("app_db_class",
            database_name = "",
            host_name     = ".stanford.edu",
            port_number   = -1,
            password      = "",
            user_name     = "")

  return (app_db)
}

# or read the connectivity parameters from the users environment
# using environment variables, could also be extended to use ~/.pgpass

app_db_params = function() {

  env <- Sys.getenv()

  setClass ("app_db_class", representation(host_name="character", port_number="character",
            database_name="character", user_name="character", password="character"))

  app_db <- new("app_db_class",
            database_name = env[["PG_DATABASE_NAME"]],
            host_name     = env[["PG_HOST_NAME"]],
            port_number   = env[["PG_PORT_NUMBER"]],
            password      = env[["PG_PASSWORD"]],
            user_name     = env[["PG_USER_NAME"]])

  return (app_db)
}

