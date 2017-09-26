
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_locations()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v4, v5, v6 FROM biologging.wc_zip_locations;

    v_wc_id          text;
    v_deployid       integer;
    v_ptt            integer;
    v_instrument     text;
    v_data_date      text;
    v_data_type      text;
    v_date_quality   text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_data_date, v_data_type, v_date_quality;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_locations a
            where a.wc_id        = v_wc_id
              and a.deployid     = v_deployid
              and a.ptt          = v_ptt
              and a.instrument   = v_instrument
              and a.data_date    = v_data_date
              and a.data_type    = v_data_type
              and a.data_quality = v_date_quality)
        then
            insert into biologging.atn_all_locations (wc_id, deployid, ptt, instrument, data_date, data_type,
                   date_quality, latitude, longitude, error_radius, error_semi_major_axis, error_semi_minor_axis,
                   error_ellipse_orient, data_offset, offset_orient, gpe_msd, gpe_u, data_count, data_comment)

            select wc_id,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,nullif(v17,'')::integer,v18

              from biologging.wc_zip_locations a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_instrument
               and a.v4     = v_data_date
               and a.v5     = v_data_type
               and a.v6     = v_date_quality
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

  Table "biologging.wc_zip_locations"
 Column |       Type       | Modifiers 
--------+------------------+-----------
 v1     | integer          | 
 v2     | integer          | 
 v3     | text             | 
 v4     | text             | 
 v5     | text             | 
 v6     | text             | 
 v7     | double precision | 
 v8     | double precision | 
 v9     | text             | 
 v10    | text             | 
 v11    | text             | 
 v12    | text             | 
 v13    | text             | 
 v14    | text             | 
 v15    | text             | 
 v16    | text             | 
 v17    | text             | 
 v18    | text             | 
 wc_id  | text             | 

 deployid              | integer               | 
 ptt                   | integer               | 
 instrument            | character varying(16) | 
 data_date             | character varying(32) | 
 data_type             | character varying(16) | 
 date_quality          | character varying(4)  | 
 latitude              | double precision      | 
 longitude             | double precision      | 
 error_radius          | character varying(32) | 
 error_semi_major_axis | character varying(32) | 
 error_semi_minor_axis | character varying(32) | 
 error_ellipse_orient  | character varying(32) | 
 data_offset           | character varying(32) | 
 offset_orient         | character varying(32) | 
 gpe_msd               | character varying(32) | 
 gpe_u                 | character varying(32) | 
 data_count            | integer               | 
 data_comment          | text                  | 

