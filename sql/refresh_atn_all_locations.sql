
CREATE OR REPLACE FUNCTION refresh_atn_all_locations()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v4, v5, v6 FROM biologging.wc_zip_locations;

    v_wc_id          text;
    v_deployid       text;
    v_ptt            integer;
    v_instrument     text;
    v_data_date      text;
    v_data_type      text;
    v_data_quality   text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_data_date, v_data_type, v_data_quality;
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
              and a.data_quality = v_data_quality)
        then
            insert into biologging.atn_all_locations (wc_id, deployid, ptt, instrument, data_date, data_type,
                   data_quality, latitude, longitude, error_radius, error_semi_major_axis, error_semi_minor_axis,
                   error_ellipse_orient, data_offset, offset_orient, gpe_msd, gpe_u, data_count, data_comment)

            select wc_id,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,v14,v15,v16,nullif(v17,'')::integer,v18

              from biologging.wc_zip_locations a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_instrument
               and a.v4     = v_data_date
               and a.v5     = v_data_type
               and a.v6     = v_data_quality
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

