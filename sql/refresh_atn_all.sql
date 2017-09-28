
CREATE OR REPLACE FUNCTION refresh_atn_all()
RETURNS integer AS $$

DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v7, v11, v14 FROM biologging.wc_zip_all;

    v_wc_id          text;
    v_deployid       text;
    v_platform_id    integer;
    v_program_id     integer;
    v_location_date  text;
    v_satellite      text;
    v_message_date   text;
    v_data_sensor    integer[];

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_platform_id, v_program_id, v_location_date, v_satellite, v_message_date;
        exit when not found; 

        if not exists (
            select 1
              from biologging.atn_all a
             where a.wc_id            = v_wc_id
               and a.deployid         = v_deployid
               and a.platform_id      = v_platform_id
               and a.program_id       = v_program_id
               and a.location_date    = v_location_date
               and a.satellite        = v_satellite
               and a.message_date     = v_message_date)
        then
            select array[       v31             ,        v32             ,        v33             ,
                   nullif(v34,'')::integer, nullif(v35,'')::integer, nullif(v36,'')::integer, nullif(v37,'')::integer,
                   nullif(v38,'')::integer, nullif(v39,'')::integer, nullif(v40,'')::integer, nullif(v41,'')::integer,
                   nullif(v42,'')::integer, nullif(v43,'')::integer, nullif(v44,'')::integer, nullif(v45,'')::integer,
                   nullif(v46,'')::integer, nullif(v47,'')::integer, nullif(v48,'')::integer, nullif(v49,'')::integer,
                   nullif(v50,'')::integer, nullif(v51,'')::integer, nullif(v52,'')::integer, nullif(v53,'')::integer,
                   nullif(v54,'')::integer, nullif(v55,'')::integer, nullif(v56,'')::integer, nullif(v57,'')::integer,
                   nullif(v58,'')::integer, nullif(v59,'')::integer, nullif(v60,'')::integer, nullif(v61,'')::integer,
                   nullif(v62,'')::integer
                   ]
              into v_data_sensor
              from biologging.wc_zip_all a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_platform_id
               and a.v3     = v_program_id
               and a.v7     = v_location_date
               and a.v11    = v_satellite
               and a.v14    = v_message_date
             limit 1;

            /*
             * if the column is in the atn_all.ix01_atn_all, then it needs to be inserted as blanks
             * not null, since the data from wc is in blanks, hate empty dates
             */
            insert into biologging.atn_all (deployid, platform_id, program_id, latitude, longitude, location_quality, location_date,
                   location_type, altitude, data_pass, satellite, mote_id, frequency, message_date, comp, message, greater_120db,
                   best_level, delta_frequency, longitude1, latitude_sol1, longitude2, latitude_sol2, location_index, nopc, 
                   error_radius, error_semi_major_axis, error_semi_minor_axis, error_ellipse_orient, gdop, data_sensor, wc_id)

            select nullif(v1,''),v2,v3,nullif(v4,'')::double precision,nullif(v5,'')::double precision,nullif(v6,''),
                   v7,nullif(v8,''),nullif(v9,'')::integer,v10,nullif(v11,''),nullif(v12,''),v13,nullif(v14,''),v15,
                   v16,nullif(v17,''),nullif(v18,'')::double precision,v19,nullif(v20,'')::double precision,nullif(v21,'')::double precision,
                   nullif(v22,'')::double precision,nullif(v23,'')::double precision,nullif(v24,'')::integer,nullif(v25,'')::integer,
                   nullif(v26,'')::integer,nullif(v27,'')::integer,nullif(v28,'')::integer,nullif(v29,'')::integer,nullif(v30,'')::integer,
                   v_data_sensor, wc_id
              from biologging.wc_zip_all a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_platform_id
               and a.v3     = v_program_id
               and a.v7     = v_location_date
               and a.v11    = v_satellite
               and a.v14    = v_message_date
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

