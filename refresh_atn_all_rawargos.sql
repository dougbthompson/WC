
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_rawargos()
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
                   ]
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

                                      Table "biologging.atn_all_rawargos"
        Column         |         Type          |                           Modifiers                            
-----------------------+-----------------------+----------------------------------------------------------------
 idx                   | integer               | not null default nextval('atn_all_rawargos_idx_seq'::regclass)
 wc_id                 | character varying(64) | 
 program               | integer               | 
 ptt                   | integer               | 
 length                | integer               | 
 satellite             | character varying(16) | 
 data_class            | integer               | 
 pass                  | integer               | 
 pass_date             | character varying(32) | 
 pass_time             | character varying(32) | 
 latitude1             | double precision      | 
 longitude1            | double precision      | 
 comment               | text                  | 
 frequency             | integer               | 
 power                 | double precision      | 
 iq                    | integer               | 
 duplicates            | integer               | 
 message_date          | character varying(32) | 
 message_time          | character varying(32) | 
 latitude2             | double precision      | 
 longitude2            | double precision      | 
 duration              | integer               | 
 error_radius          | integer               | 
 error_semi_major_axis | integer               | 
 error_semi_minor_axis | integer               | 
 error_ellipse_orient  | integer               | 
 data_offset           | integer               | 
 offset_orient         | integer               | 
 data_sensor           | integer[]             | 

Table "biologging.wc_zip_rawargos"
 Column | Type | Modifiers 
--------+------+-----------
 v1     | text | 
 v2     | text | 
 v3     | text | 
 v4     | text | 
 v5     | text | 
 v6     | text | 
 v7     | text | 
 v8     | text | 
 v9     | text | 
 v10    | text | 
 v11    | text | 
 v12    | text | 
 v13    | text | 
 v14    | text | 
 v15    | text | 
 v16    | text | 
 v17    | text | 
 v18    | text | 

 v58    | text | 
 wc_id  | text |

