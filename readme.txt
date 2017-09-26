
drop index ix01_atn_all;
create unique index ix01_atn_all on biologging.atn_all (wc_id, deployid, platform_id, program_id, location_date, satellite, message_date);

select a.*
  from wc_zip_all a
 where not exists (
       select 1
         from atn_all b
        where b.wc_id         = a.wc_id
          and b.deployid      = a.v1::integer
          and b.platform_id   = a.v2 
          and b.program_id    = a.v3
          and b.location_date = a.v7
          and b.satellite     = a.v11
          and b.message_date  = a.v14)

drop index ix01_atn_all_fastgps;
create unique index ix01_atn_all_fastgps on biologging.atn_all_fastgps (wc_id, name, day, time, inittime);

drop index ix01_atn_all_argos;
create unique index ix01_atn_all_argos on biologging.atn_all_argos (deployid, ptt, instrument, date, satellite);

-------------------------------------------------------------------------------

refresh_atn_all_corrupt.sql:               and a.v10    = v_reason
refresh_atn_all_corrupt.sql:               and a.v1     = v_deployid
refresh_atn_all_corrupt.sql:               and a.v2     = v_ptt
refresh_atn_all_corrupt.sql:               and a.v3     = v_instrument
refresh_atn_all_corrupt.sql:               and a.v4     = v_date
refresh_atn_all_corrupt.sql:               and a.v6     = v_satellite

refresh_atn_all_haulout.sql:               and a.v1     = v_deployid
refresh_atn_all_haulout.sql:               and a.v2     = v_ptt
refresh_atn_all_haulout.sql:               and a.v3     = v_instrument
refresh_atn_all_haulout.sql:               and a.v4     = v_data_id
refresh_atn_all_haulout.sql:               and a.v5     = v_date_start

refresh_atn_all_histos.sql:               and a.v1     = v_deployid
refresh_atn_all_histos.sql:               and a.v2     = v_ptt
refresh_atn_all_histos.sql:               and a.v3     = v_depth_sensor
refresh_atn_all_histos.sql:               and a.v4     = v_source
refresh_atn_all_histos.sql:               and a.v5     = v_instrument
refresh_atn_all_histos.sql:               and a.v6     = v_histtype
refresh_atn_all_histos.sql:               and a.v7     = v_data_date

refresh_atn_all_locations.sql:               and a.v1     = v_deployid
refresh_atn_all_locations.sql:               and a.v2     = v_ptt
refresh_atn_all_locations.sql:               and a.v3     = v_instrument
refresh_atn_all_locations.sql:               and a.v4     = v_data_date
refresh_atn_all_locations.sql:               and a.v5     = v_data_type
refresh_atn_all_locations.sql:               and a.v6     = v_date_quality

refresh_atn_all_minmaxdepth.sql:               and a.v1     = v_deployid
refresh_atn_all_minmaxdepth.sql:               and a.v2     = v_ptt
refresh_atn_all_minmaxdepth.sql:               and a.v3     = v_depth_sensor
refresh_atn_all_minmaxdepth.sql:               and a.v4     = v_instrument
refresh_atn_all_minmaxdepth.sql:               and a.v5     = v_data_type

refresh_atn_all_rawargos.sql:               and a.v16    = v_message_date
refresh_atn_all_rawargos.sql:               and a.v17    = v_message_time
refresh_atn_all_rawargos.sql:               and a.v1     = v_program
refresh_atn_all_rawargos.sql:               and a.v2     = v_ptt
refresh_atn_all_rawargos.sql:               and a.v4     = v_satellite

