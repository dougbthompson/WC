#!/usr/bin/R

###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
### 

wc_db_truncate = function(db_connection) {
    zip_table_names <- dbGetQuery(db_connection,
      "select table_name from information_schema.tables where table_schema = 'biologging' and table_name like 'wc_zip%';");

    dbExecute(db_connection, "set search_path = biologging, public, aatams, postgis")

  # for (table_name in zip_table_names) {
  #     truncate_sql <- paste0('delete from biologging.',table_name,';');
  #     print (truncate_sql)
  #     dbExecute(db_connection, truncate_sql)
  # }

    dbExecute (db_connection, "delete from wc_zip_all;")
    dbExecute (db_connection, "delete from wc_zip_argos;")
    dbExecute (db_connection, "delete from wc_zip_behavior;")
    dbExecute (db_connection, "delete from wc_zip_corrupt;")
    dbExecute (db_connection, "delete from wc_zip_fastgps;")
    dbExecute (db_connection, "delete from wc_zip_haulout;")
    dbExecute (db_connection, "delete from wc_zip_histos;")
    dbExecute (db_connection, "delete from wc_zip_labels;")
    dbExecute (db_connection, "delete from wc_zip_locations;")
    dbExecute (db_connection, "delete from wc_zip_minmaxdepth;")
    dbExecute (db_connection, "delete from wc_zip_rawargos;")
    dbExecute (db_connection, "delete from wc_zip_rtc;")
    dbExecute (db_connection, "delete from wc_zip_series;")
    dbExecute (db_connection, "delete from wc_zip_seriesrange;")
    dbExecute (db_connection, "delete from wc_zip_sst;")
    dbExecute (db_connection, "delete from wc_zip_status;")
    dbExecute (db_connection, "delete from wc_zip_summary;")
}

wc_db_refresh = function(db_connection) {
    rs <- dbGetQuery(db_connection, "select refresh_atn_all_locations();")
}

