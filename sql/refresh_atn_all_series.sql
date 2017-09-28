
CREATE OR REPLACE FUNCTION refresh_atn_all_series()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v5, v6, v7 FROM biologging.wc_zip_series;

    v_wc_id         text;
    v_deployid      text;
    v_ptt           integer;
    v_instrument    text;
    v_date_start    text;
    v_date_end      text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_date_start, v_date_end;
        exit when not found;

        if not exists (
            select 1
              from biologging.atn_all_series a
             where a.wc_id         = v_wc_id
               and a.deployid      = v_deployid
               and a.ptt           = v_ptt
               and a.instrument    = v_instrument
               and a.date_start    = v_date_start
               and a.date_end      = v_date_end)
        then

            insert into biologging.atn_all_series (wc_id, deployid, ptt, depth_sensor,
                   source, instrument, date_start, date_end, location_quality, latitude,
                   longitude, depth, depth_range, temperature, temperature_range)

            select wc_id, v1, v2, nullif(v3,'')::double precision, v4, v5, v6, v7, v8, 
                   nullif(v9,'')::double precision, nullif(v10,'')::double precision,
                   v11, v12, v13, v14

              from biologging.wc_zip_series a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v5     = v_instrument
               and a.v6     = v_date_start
               and a.v7     = v_date_ends
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

