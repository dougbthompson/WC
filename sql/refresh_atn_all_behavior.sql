
CREATE OR REPLACE FUNCTION refresh_atn_all_behavior(v_which integer)
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v5, v7, v8 FROM biologging.wc_zip_behavior;

    v_wc_id         text;
    v_deployid      text;
    v_ptt           integer;
    v_instrument    text;
    v_date_start    text;
    v_date_end      text;

    v_shallow       double precision;
    v_deep          double precision;

    v_number        integer[];
    v_shape         text[];
    v_depth_min     integer[];
    v_depth_max     integer[];
    v_duration_min  double precision[];
    v_duration_max  double precision[];

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_date_start, v_date_end;
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
            if v_which == 17
            then
              select array[ nullif(v10,'')::integer ], nullif(v16,'')::double precision, nullif(v17,'')::double precision
                into v_number, v_shallow, v_deep
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v11,'')::integer ] into v_shape
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v12,'')::integer ] into v_depth_min
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v13,'')::integer ] into v_depth_max
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v14,'')::double precision ] into v_duration_min
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v15,'')::double precision ] into v_duration_max
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;
            else
              select array[ nullif(v10,'')::integer, nullif(v16,'')::integer, nullif(v22,'')::integer ],
                     nullif(v28,'')::double precision, nullif(v29,'')::double precision
                into v_number, v_shallow, v_deep
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v11,'')::integer, nullif(v17,'')::integer, nullif(v23,'')::integer ] into v_shape
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v12,'')::integer, nullif(v18,'')::integer, nullif(v24,'')::integer ] into v_depth_min
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v13,'')::integer, nullif(v19,'')::integer, nullif(v25,'')::integer ] into v_depth_max
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v14,'')::double precision, nullif(v20,'')::double precision,
                            nullif(v26,'')::double precision ] into v_duration_min
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v15,'')::double precision, nullif(v21,'')::double precision,
                            nullif(v27,'')::double precision ] into v_duration_max
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;
            end if;

            insert into biologging.atn_all_behavior (wc_id, deployid, ptt, depth_sensor, source,
                   instrument, count, date_start, date_end, what, shallow, deep,
                   number, shape, depth_min, depth_max, duration_min, duration_max)

            select wc_id, v1, v2, v3, v4, v5, v6, v7, v8, v9, v_shallow, v_deep,
                   v_number, v_shape, v_depth_min, v_depth_max, v_duration_min, v_duration_max

              from biologging.wc_zip_behavior a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v5     = v_instrument
               and a.v7     = v_date_start
               and a.v8     = v_date_end
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

