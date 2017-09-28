
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_behavior()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v5, v7, v8 FROM biologging.wc_zip_behavior;

    v_wc_id         text;
    v_deployid      text;
    v_ptt           integer;
    v_instrument    text;
    v_date_start    text;
    v_date_ends     text;

BEGIN
    open curs1;
    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_date_start, v_date_ends;
        exit when not found;

        if not exists (
            select 1
              from biologging.atn_all_behavior a
             where a.wc_id         = v_wc_id
               and a.deployid      = v_deployid
               and a.ptt           = v_ptt
               and a.instrument    = v_instrument
               and a.date_start    = v_date_start
               and a.date_end      = v_date_end)
        then

            insert into biologging.atn_all_behavior (wc_id, deployid, ptt, depth_sensor, source,
                   instrument, count, date_start, date_end, what, number, shape, depth_min, depth_max,
                   duration_min, duration_max, shallow, deep)

            select wc_id, v1, v2, nullif(v3,'')::double precision, v4, v5, v6, v7, v8, v9,
                   nullif(v10,'')::integer, v11, nullif(v12,'')::integer, nullif(v13,'')::integer,
                   v14, v15, nullif(v16,'')::double precision, nullif(v17,'')::double precision

              from biologging.wc_zip_behavior a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v5     = v_instrument
               and a.v7     = v_date_start
               and a.v8     = v_date_ends
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

