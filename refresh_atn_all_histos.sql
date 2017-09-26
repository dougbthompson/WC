
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_histos()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3 FROM biologging.wc_zip_histos;

BEGIN
    open curs1;
    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_data_id, v_date_start;
        exit when not found;

        if not exists (
            select 1
              from biologging.atn_all_histos a
             where a.wc_id       = v_wc_id
               and a.deployid    = v_deployid
               and a.ptt         = v_ptt
               and a.instrument  = v_instrument
               and a.data_id     = v_data_id
               and a.date_start  = v_date_start)
        then

            insert into biologging.atn_all_histos (wc_id, deployid, ptt, instrument, data_id,
                   date_start, date_end, duration, location_quality, latitude, longitude)

            select wc_id, v1, v2, v3, v4, v5, v6, v7, v8,
                   nullif(v9,'')::double precision, nullif(v10,'')::double precision

              from biologging.wc_zip_histos a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_instrument
               and a.v4     = v_data_id
               and a.v5     = v_date_start
             limit 1;


        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

