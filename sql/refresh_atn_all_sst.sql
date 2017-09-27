
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_sst()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v4, v5 FROM biologging.wc_zip_sst;

    v_wc_id       text;
    v_deployid    text;
    v_ptt         integer;
    v_instrument  text;
    v_data_date   text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_data_date;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_sst a
            where a.wc_id       = v_wc_id
              and a.deployid    = v_deployid
              and a.ptt         = v_ptt
              and a.instrument  = v_instrument
              and a.data_date   = v_data_date)
        then
            insert into biologging.atn_all_sst (wc_id, deployid, ptt, depth_sensor, instrument,
                   data_date, location_quality, latitude, longitude, depth, temperature)

            select wc_id,v1,v2,v3,v4,v5,v6,nullif(v7,'')::double precision,nullif(v8,'')::double precision
                   v9,v10,v11
              from biologging.wc_zip_sst a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_instrument
               and a.v4     = v_data_date
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

