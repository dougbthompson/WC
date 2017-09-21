#!/usr/bin/R

###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
### 

wc_db_truncate = function(db_connection) {
}

wc_db_refresh = function(db_connection) {
    rs <- dbSendQuery(db_connection, "select refresh_wc_zip_locations();")
    dbClearResult(rs)
}

