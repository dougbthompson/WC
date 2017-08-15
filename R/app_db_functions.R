
###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
###

app_db_truncate = function(db_connection) {

    dbSendQuery(db_connection, "truncate tmp_all_deployments;")
    dbSendQuery(db_connection, "truncate tmp_all_locations;")
    dbSendQuery(db_connection, "truncate tmp_all_deployment_profiles;")
    dbSendQuery(db_connection, "truncate tmp_all_profiles;")
}

app_db_refresh = function(db_connection) {

    rs <- dbSendQuery(db_connection, "select refresh_wc_all_deployments();")
    dbClearResult(rs)
    rs <- dbSendQuery(db_connection, "select refresh_wc_all_locations();")
    dbClearResult(rs)
    rs <- dbSendQuery(db_connection, "select refresh_wc_all_deployment_profiles();")
    dbClearResult(rs)
    rs <- dbSendQuery(db_connection, "select refresh_wc_all_profiles();")
    dbClearResult(rs)

}

