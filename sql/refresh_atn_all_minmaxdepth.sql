
CREATE OR REPLACE FUNCTION refresh_atn_all_minmaxdepth()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v4, v5 FROM biologging.wc_zip_minmaxdepth;

    v_wc_id          text;
    v_deployid       integer;
    v_ptt            integer;
    v_depth_sensor   text;
    v_instrument     text;
    v_data_date      text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_depth_sensor, v_instrument, v_data_date;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_minmaxdepth a
            where a.wc_id        = v_wc_id
              and a.deployid     = v_deployid
              and a.ptt          = v_ptt
              and a.depth_sensor = v_depth_sensor
              and a.instrument   = v_instrument
              and a.data_date    = v_date_date)
        then
            insert into biologging.atn_all_minmaxdepth (wc_id, deployid, ptt, depthsensor, instrument, data_date,
                   location_quality, latitude, longitude, min_depth, min_accuracy, min_source, max_depth,
                   max_accuracy, max_source)

            select wc_id,v1,v2,v3,v4,v5,v6,nullif(v7,'')::double precision,nullif(v8,'')::double precision,
                   v9,v10,v11,nullif(v12,'')::double precision,nullif(v13,'')::double precision,v14

              from biologging.wc_zip_minmaxdepth a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_depth_sensor
               and a.v4     = v_instrument
               and a.v5     = v_data_type
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

