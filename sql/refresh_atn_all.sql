
CREATE OR REPLACE FUNCTION refresh_wc_atn_all()
RETURNS integer AS $$

DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v7 FROM biologging.wc_zip_all;

    v_wc_id          text;
    v_deployid       text;
    v_platform_id    integer;
    v_program_id     integer;
    v_location_date  text;
    v_data_sensor    integer[];

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_platform_id, v_program_id, v_location_date;
        exit when not found; 

        if not exists (
            select 1
              from biologging.atn_all
             where wc_id            = v_wc_id
               and deployid         = v_deployid::integer
               and platform_id      = v_platform_id
               and program_id       = v_program_id
               and location_date    = v_location_date)
        then
            select array["v31"::integer, "v32"::integer, "v33"::integer, "v34"::integer, "v35"::integer, "v36"::integer,
                         "v37"::integer, "v38"::integer, "v39"::integer, "v40"::integer, "v41"::integer, "v42"::integer,
                         "v43"::integer, "v44"::integer, "v45"::integer, "v46"::integer, "v47"::integer, "v48"::integer,
                         "v49"::integer, "v50"::integer, "v51"::integer, "v52"::integer, "v53"::integer, "v54"::integer,
                         "v55"::integer, "v56"::integer, "v57"::integer, "v58"::integer, "v59"::integer, "v60"::integer,
                         "v61"::integer, "v62"::integer
                        ]
              into v_data_sensor
              from biologging.wc_zip_all
             where wc_id  = v_wc_id
               and v1     = v_deployid
               and v2     = v_platform_id
               and v3     = v_program_id
               and v7     = v_location_date
             limit 1;

            insert into biologging.atn_all (depoyid, platform_id, program_id, latitude, longitude, location_quality, location_date,
                   location_type, altitude, data_pass, satellite, mote_id, frequency, message_date, comp, message, greater_120db,
                   best_level, delta_frequency, longitude1, latitude_sol1, longitude2, latitude_sol2, location_index, nopc, 
                   error_radius, error_semi_major_axis, error_semi_minor_axis, error_ellipse_orient, gdop, data_sensor, wc_id)

            select v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,v20,v21,v22,v23,v24,v25,
                   v26,v27,v28,v29,v30, v_data_sensor, wc_id
              from biologging.wc_zip_all
             where wc_id  = v_wc_id
               and v1     = v_deployid
               and v2     = v_platform_id
               and v3     = v_program_id
               and v7     = v_location_date
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

