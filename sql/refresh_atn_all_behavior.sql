
CREATE OR REPLACE FUNCTION wz_behavior(v_which integer)
RETURNS integer AS $$
BEGIN 

    if v_which = 17
    then
        drop table if exists biologging.wc_zip_behavior;

        create table biologging.wc_zip_behavior (
           v1 text,  v2 integer,  v3 text,  v4 text,  v5 text, v6 text,   v7 text,  v8 text, v9 text,
          v10 text, v11 text,    v12 text, v13 text, v14 text, v15 text, v16 text, v17 text,
        wc_id text);
    end if;

    if v_which = 23
    then
        drop table if exists biologging.wc_zip_behavior;

        create table biologging.wc_zip_behavior (
           v1 text,  v2 integer,  v3 text,  v4 text,  v5 text,   v6 text,   v7 text,  v8 text,  v9 text,
          v10 text, v11 text,    v12 text, v13 text, v14 text,   v15 text, v16 text, v17 text, v18 text,
          v19 text, v20 text,    v21 text, v22 text, v23 text,
        wc_id text);
    end if;

    if v_which = 29
    then
        drop table if exists biologging.wc_zip_behavior;

        create table biologging.wc_zip_behavior (
           v1 text,  v2 integer,  v3 text,  v4 text,  v5 text, v6 text,   v7 text,  v8 text,  v9 text,
          v10 text, v11 text,    v12 text, v13 text, v14 text, v15 text, v16 text, v17 text, v18 text,
          v19 text, v20 text,    v21 text, v22 text, v23 text, v24 text, v25 text, v26 text, v27 text,
          v28 text, v29 text,
        wc_id text);
    end if;

    if v_which = 35
    then
        drop table if exists biologging.wc_zip_behavior;

        create table biologging.wc_zip_behavior (
           v1 text,  v2 integer,  v3 text,  v4 text,  v5 text, v6 text,   v7 text,  v8 text,  v9 text,
          v10 text, v11 text,    v12 text, v13 text, v14 text, v15 text, v16 text, v17 text, v18 text,
          v19 text, v20 text,    v21 text, v22 text, v23 text, v24 text, v25 text, v26 text, v27 text,
          v28 text, v29 text,    v30 text, v31 text, v32 text, v33 text, v34 text, v35 text,
        wc_id text);
    end if;

    alter table biologging.wc_zip_behavior owner to postgres;
    return 1;
END;
$$ LANGUAGE plpgsql volatile;


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
    v_depth_min     double precision[];
    v_depth_max     double precision[];
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
            if v_which = 17
            then
              select array[ nullif(v10,'')::integer ], nullif(v16,'')::double precision, nullif(v17,'')::double precision
                into v_number, v_shallow, v_deep
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ v11 ] into v_shape
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v12,'')::double precision ] into v_depth_min
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v13,'')::double precision ] into v_depth_max
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
            end if;

            if v_which = 23
            then
              select array[ nullif(v10,'')::integer, nullif(v16,'')::integer ],
                     nullif(v22,'')::double precision, nullif(v23,'')::double precision
                into v_number, v_shallow, v_deep
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ v11, v17 ] into v_shape
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v12,'')::double precision, nullif(v18,'')::double precision ]
                     into v_depth_min
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v13,'')::double precision, nullif(v19,'')::double precision ]
                     into v_depth_max
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v14,'')::double precision, nullif(v20,'')::double precision ]
                     into v_duration_min
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v15,'')::double precision, nullif(v21,'')::double precision ]
                     into v_duration_max
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;
            end if;

            if v_which = 29
            then
              select array[ nullif(v10,'')::integer, nullif(v16,'')::integer, nullif(v22,'')::integer ],
                     nullif(v28,'')::double precision, nullif(v29,'')::double precision
                into v_number, v_shallow, v_deep
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ v11, v17, v23 ] into v_shape
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v12,'')::double precision, nullif(v18,'')::double precision,
                            nullif(v24,'')::double precision ] into v_depth_min
                from biologging.wc_zip_behavior a
               where a.wc_id = v_wc_id and a.v1 = v_deployid and a.v2 = v_ptt and a.v5 = v_instrument
                 and a.v7 = v_date_start and a.v8 = v_date_end
               limit 1;

              select array[ nullif(v13,'')::double precision, nullif(v19,'')::double precision,
                            nullif(v25,'')::double precision ] into v_depth_max
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

            if v_which = 35
            then
            end if;

            insert into biologging.atn_all_behavior (wc_id, deployid, ptt, depth_sensor, source,
                   instrument, count, date_start, date_end, what, shallow, deep,
                   number, shape, depth_min, depth_max, duration_min, duration_max)

            select wc_id, v1, v2, v3, v4, v5, nullif(v6,'')::integer, v7, v8, v9, v_shallow, v_deep,
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

