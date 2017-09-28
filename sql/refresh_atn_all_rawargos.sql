
CREATE OR REPLACE FUNCTION refresh_atn_all_rawargos()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v4, v16, v17 FROM biologging.wc_zip_rawargos;

    v_wc_id          text;
    v_program        integer;
    v_ptt            integer;
    v_satellite      text;
    v_message_date   text;
    v_message_time   text;
    v_data_sensor    integer[];

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_program, v_ptt, v_satellite, v_message_date, v_message_time;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_rawargos a
            where a.wc_id        = v_wc_id
              and a.program      = v_program
              and a.ptt          = v_ptt
              and a.satellite    = v_satellite
              and a.message_date = v_message_date
              and a.message_time = v_message_time)
        then
            select array[
                   nullif(v27,'')::integer, nullif(v28,'')::integer, nullif(v29,'')::integer, nullif(v30,'')::integer,
                   nullif(v31,'')::integer, nullif(v32,'')::integer, nullif(v33,'')::integer, nullif(v34,'')::integer,
                   nullif(v35,'')::integer, nullif(v36,'')::integer, nullif(v37,'')::integer, nullif(v38,'')::integer,
                   nullif(v39,'')::integer, nullif(v40,'')::integer, nullif(v41,'')::integer, nullif(v42,'')::integer,
                   nullif(v43,'')::integer, nullif(v44,'')::integer, nullif(v45,'')::integer, nullif(v46,'')::integer,
                   nullif(v47,'')::integer, nullif(v48,'')::integer, nullif(v49,'')::integer, nullif(v50,'')::integer,
                   nullif(v51,'')::integer, nullif(v52,'')::integer, nullif(v53,'')::integer, nullif(v54,'')::integer,
                   nullif(v55,'')::integer, nullif(v56,'')::integer, nullif(v57,'')::integer, nullif(v58,'')::integer ]
              into v_data_sensor
              from biologging.wc_zip_rawargos a
             where a.wc_id  = v_wc_id
               and a.v1     = v_program
               and a.v2     = v_ptt
               and a.v4     = v_satellite
               and a.v16    = v_message_date
               and a.v17    = v_message_time
             limit 1;

            insert into biologging.atn_all_rawargos (wc_id, program, ptt, length, satellite, data_class, pass,
                   pass_date, pass_time, latitude1, longitude1, comment, frequency, power, iq, duplicates,
                   message_date, message_time, latitude2, longitude2, duration, error_radius, error_semi_major_axis,
                   error_semi_minor_axis, error_ellipse_orient, data_offset, offset_orient, data_sensor)

            select wc_id, nullif(v1,'')::integer, nullif(v2,'')::integer, nullif(v3,'')::integer, v4,
                   nullif(v5,'')::integer, nullif(v6,'')::integer, v7, v8, nullif(v9,'')::double precision,
                   nullif(v10,'')::double precision, v11, nullif(v12,'')::integer, nullif(v13,'')::double precision,
                   nullif(v14,'')::integer, nullif(v15,'')::integer, v16, v17, nullif(v18,'')::double precision,
                   nullif(v19,'')::double precision, nullif(v20,'')::integer, nullif(v21,'')::integer, nullif(v22,'')::integer,
                   nullif(v23,'')::integer, nullif(v24,'')::integer, nullif(v25,'')::integer, nullif(v26,'')::integer, v_data_sensor

              from biologging.wc_zip_rawargos a
             where a.wc_id  = v_wc_id
               and a.v1     = v_program
               and a.v2     = v_ptt
               and a.v4     = v_satellite
               and a.v16    = v_message_date
               and a.v17    = v_message_time
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

