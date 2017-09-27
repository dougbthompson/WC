
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_argos()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v10, v11 FROM biologging.wc_zip_argos;

    v_wc_id         text;
    v_deployid      text;
    v_ptt           integer;
    v_instrument    text;
    v_date          text;
    v_satellite     text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_date, v_satellite;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_argos a
            where a.wc_id      = v_wc_id
              and a.deployid   = v_deployid
              and a.ptt        = v_ptt
              and a.instrument = v_instrument
              and a.date       = v_date
              and a.satellite  = v_satellite)
        then
            insert into biologging.atn_all_argos (wc_id, deployid, ptt, instrument, record_type, message_count,
                   duplicates, corrupt, interval_avg, interval_min, date, satellite, location_quality, latitude1,
                   longitude1, latitude2, longitude2, iq, duration, frequency, power)

            select wc_id, v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,
                   nullif(v13,'')::double precision,nullif(v14,'')::double precision,
                   nullif(v15,'')::double precision,nullif(v16,'')::double precision,
                   nullif(v17,'')::integer,v18,v19,nullif(v20,'')::double precision

              from biologging.wc_zip_argos a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_instrument
               and a.v10    = v_date
               and a.v11    = v_satellite
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

