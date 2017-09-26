
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_histos()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v4, v5, v6, v7 FROM biologging.wc_zip_histos;

    v_wc_id         text;
    v_deployid      integer;
    v_ptt           integer;
    v_depth_sensor  text;
    v_source        text;
    v_instrument    text;
    v_histtype      text;
    v_data_date     text;
    v_data_bins     integer[];

BEGIN
    open curs1;
    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_depth_sensor, v_source, v_instrument, v_histtype, v_data_date;
        exit when not found;

        if not exists (
            select 1
              from biologging.atn_all_histos a
             where a.wc_id         = v_wc_id
               and a.deployid      = v_deployid
               and a.ptt           = v_ptt
               and a.depth_sensor  = v_depth_sensor
               and a.source        = v_source
               and a.instrument    = v_instrument
               and a.histtype      = v_histtype
               and a.data_date     = v_data_date)
        then

            select array[
                   v16::double precision, v17::double precision, v18::double precision, v19::double precision,
                   v20::double precision, v21::double precision, v22::double precision, v23::double precision,
                   v24::double precision, v25::double precision, v26::double precision, v27::double precision,

                   nullif(v28,'')::double precision, nullif(v29,'')::double precision, nullif(v30,'')::double precision,
                   nullif(v31,'')::double precision, nullif(v32,'')::double precision, nullif(v33,'')::double precision,
                   nullif(v34,'')::double precision, nullif(v35,'')::double precision, nullif(v36,'')::double precision,
                   nullif(v37,'')::double precision, nullif(v38,'')::double precision, nullif(v39,'')::double precision,
                   nullif(v40,'')::double precision, nullif(v41,'')::double precision, nullif(v42,'')::double precision,
                   nullif(v43,'')::double precision, nullif(v44,'')::double precision, nullif(v45,'')::double precision,
                   nullif(v46,'')::double precision, nullif(v47,'')::double precision, nullif(v48,'')::double precision,
                   nullif(v49,'')::double precision, nullif(v50,'')::double precision, nullif(v51,'')::double precision,
                   nullif(v52,'')::double precision, nullif(v53,'')::double precision, nullif(v54,'')::double precision,
                   nullif(v55,'')::double precision, nullif(v56,'')::double precision, nullif(v57,'')::double precision,
                   nullif(v58,'')::double precision, nullif(v59,'')::double precision, nullif(v60,'')::double precision,
                   nullif(v61,'')::double precision, nullif(v62,'')::double precision, nullif(v63,'')::double precision,
                   nullif(v64,'')::double precision, nullif(v65,'')::double precision, nullif(v66,'')::double precision,
                   nullif(v67,'')::double precision, nullif(v68,'')::double precision, nullif(v69,'')::double precision,
                   nullif(v70,'')::double precision, nullif(v71,'')::double precision, nullif(v72,'')::double precision,
                   nullif(v73,'')::double precision, nullif(v74,'')::double precision, nullif(v75,'')::double precision,
                   nullif(v76,'')::double precision, nullif(v77,'')::double precision, nullif(v78,'')::double precision,
                   nullif(v79,'')::double precision, nullif(v80,'')::double precision, nullif(v81,'')::double precision,
                   nullif(v82,'')::double precision, nullif(v83,'')::double precision, nullif(v84,'')::double precision,
                   nullif(v85,'')::double precision, nullif(v86,'')::double precision, nullif(v87,'')::double precision ]
              into v_data_bins
              from biologging.atn_all_histos a
             where a.wc_id         = v_wc_id
               and a.deployid      = v_deployid
               and a.ptt           = v_ptt
               and a.depth_sensor  = v_depth_sensor
               and a.source        = v_source
               and a.instrument    = v_instrument
               and a.histtype      = v_histtype
               and a.data_date     = v_data_date)
             limit 1;

            insert into biologging.atn_all_histos (wc_id, deployid, ptt, depth_sensor, source, instrument, 
                   histtype, data_date, time_offset, data_count, bad_therm, location_quality, latitude,
                   longitude, numbins, data_sum, data_bin)

            select wc_id, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, 
                   nullif(v12,,'')::double precision, nullif(v13,'')::double precision,
                   v14, v15, v_data_bins

              from biologging.wc_zip_histos a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_depth_sensor
               and a.v4     = v_source
               and a.v5     = v_instrument
               and a.v6     = v_histtype
               and a.v7     = v_data_date
             limit 1;


        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

 deployid         | integer               | 
 ptt              | integer               | 
 depth_sensor     | character varying(32) | 
 source           | character varying(32) | 
4
 instrument       | character varying(16) | 
 histtype         | character varying(16) | 
 data_date        | character varying(32) | 
 time_offset      | double precision      | 
8
 data_count       | integer               | 
 bad_therm        | integer               | 
 location_quality | character varying(4)  | 
 latitude         | double precision      | 
12
 longitude        | double precision      | 
 numbins          | integer               | 
 data_sum         | double precision      | 
 data_bin         | double precision[]    | 

atndb=# \d wc_zip_histos
   Table "biologging.wc_zip_histos"
 Column |       Type       | Modifiers 
--------+------------------+-----------
 v1     | integer          | 
 v2     | integer          | 
 v3     | text             | 
 v4     | text             | 
 v5     | text             | 
 v6     | text             | 
 v7     | text             | 
 v8     | double precision | 
 v9     | integer          | 
 v10    | integer          | 
 v11    | text             | 
 v12    | text             | 
 v13    | text             | 
 v14    | integer          | 
 v15    | double precision | 

 v16    | integer          | 
 v17    | integer          | 
 v18    | integer          | 
 v19    | integer          | 
 v20    | double precision | 
 v21    | double precision | 
 v22    | double precision | 
 v23    | double precision | 
 v24    | double precision | 
 v25    | double precision | 
 v26    | double precision | 
 v27    | double precision | 
 v28    | text             | 
 v29    | text             | 
 v30    | text             | 

 v86    | text             | 
 v87    | text             | 
 wc_id  | text             | 

