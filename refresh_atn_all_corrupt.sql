
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_corrupt()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v4, v6, v10 FROM biologging.wc_zip_corrupt;

    v_wc_id       text;
    v_deployid    integer;
    v_ptt         integer;
    v_instrument  text;
    v_date        text;
    v_satellite   text;
    v_reason      text;

BEGIN

    open curs1;
    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_date, v_satellite, v_reason;
          exit when not found;

        if not exists (
            select 1
              from biologging.atn_all_corrupt a
             where a.wc_id       = v_wc_id
               and a.deployid    = v_deployid
               and a.ptt         = v_ptt
               and a.instrument  = v_instrument
               and a.date        = v_date
               and a.satellite   = v_satellite
               and a.reason      = v_reason)
        then
            select array[
                   nullif(v13,'')::integer, nullif(v14,'')::integer, nullif(v15,'')::integer, nullif(v16,'')::integer, 
                   nullif(v17,'')::integer, nullif(v18,'')::integer, nullif(v19,'')::integer, nullif(v20,'')::integer, 
                   nullif(v21,'')::integer, nullif(v22,'')::integer, nullif(v23,'')::integer, nullif(v24,'')::integer, 
                   nullif(v25,'')::integer, nullif(v26,'')::integer, nullif(v27,'')::integer, nullif(v28,'')::integer, 
                   nullif(v29,'')::integer, nullif(v30,'')::integer, nullif(v31,'')::integer, nullif(v32,'')::integer, 
                   nullif(v33,'')::integer, nullif(v34,'')::integer, nullif(v35,'')::integer, nullif(v36,'')::integer, 
                   nullif(v37,'')::integer, nullif(v38,'')::integer, nullif(v39,'')::integer, nullif(v40,'')::integer, 
                   nullif(v41,'')::integer, nullif(v42,'')::integer, nullif(v43,'')::integer, nullif(v44,'')::integer ]
              into v_bytes
              from biologging.wc_zip_corrupt a
             where a.wc_id  = v_wc_id
               and a.deployid    = v_deployid
               and a.ptt         = v_ptt
               and a.instrument  = v_instrument
               and a.date        = v_date
               and a.satellite   = v_satellite
               and a.reason      = v_reason
             limit 1;

            insert into biologging.atn_all_corrupt ( wc_id, deployid, ptt, instrument, date, duplicates, satellite,
                   location_quality, latitude, longitude, reason, possible_timestamp, possible_type, bytes)

            select wc_id, 
                   v1, v2, v3, v4, nullif(v5,'')::integer, v6, v7, nullif(v8,'')::double precision, v9,
                   v10, v11, v12, v_bytes
              from biologging.wc_zip_corrupt a
             where a.wc_id  = v_wc_id
                   a.v1     = v_deployid
                   a.v2     = v_ptt
                   a.v3     = v_instrument
                   a.v4     = v_date
                   a.v6     = v_satellite
                   a.v10    = v_reason
             limit 1;

        end if;

    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

Table "biologging.wc_zip_corrupt"
 Column |  Type   | Modifiers 
--------+---------+-----------
 v1     | integer | 
 v2     | integer | 
 v3     | text    | 
 v4     | text    | 
 v5     | text    | 
 v6     | text    | 
 v7     | text    | 
 v8     | text    | 
 v9     | text    | 
 v10    | text    | 
 v11    | text    | 
 v12    | text    | 
 v13    | integer | 
 v14    | integer | 
 v15    | integer | 
 v16    | text    | 

 v44    | text    | 
 wc_id  | text    | 

                                     Table "biologging.atn_all_corrupt"
       Column       |         Type          |                           Modifiers                           
--------------------+-----------------------+---------------------------------------------------------------
 idx                | integer               | not null default nextval('atn_all_corrupt_idx_seq'::regclass)
 wc_id              | character varying(64) | 

 deployid           | integer               | 
 ptt                | integer               | 
 instrument         | character varying(8)  | 
 date               | character varying(32) | 

 duplicates         | integer               | 
 satellite          | character varying(8)  | 
 location_quality   | character varying(4)  | 
 latitude           | double precision      | 

 longitude          | double precision      | 
 reason             | character varying(32) | 
 possible_timestamp | character varying(32) | 
 possible_type      | character varying(32) | 

 bytes              | integer[]             | 

