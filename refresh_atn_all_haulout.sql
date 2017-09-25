
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_haulout()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v4, v5 FROM biologging.wc_zip_haulout;

    v_wc_id       text;
    v_deployid    integer;
    v_ptt         integer;
    v_instrument  text;
    v_data_id     integer;
    v_date_start  text;

BEGIN
    open curs1;
    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_data_id, v_date_start;
        exit when not found;

        if not exists (
            select 1
              from biologging.atn_all_haulout a
             where a.wc_id       = v_wc_id
               and a.deployid    = v_deployid
               and a.ptt         = v_ptt
               and a.instrument  = v_instrument
               and a.data_id     = v_data_id
               and a.date_start  = v_date_start)
        then

            insert into biologging.atn_all_haulout (wc_id, deployid, ptt, instrument, data_id,
                   date_start, date_end, duration, location_quality, latitude, longitude)

            select wc_id, v1, v2, v3, v4, v5, v6, v7, v8,
                   nullif(v9,'')::double precision, nullif(v10,'')::double precision

              from biologging.wc_zip_haulout a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_instrument
               and a.v4     = v_data_id
               and a.v5     = v_date_start
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

Table "biologging.wc_zip_haulout"
 Column |  Type   | Modifiers 
--------+---------+-----------
 v1     | integer | 
 v2     | integer | 
 v3     | text    | 
 v4     | integer | 
 v5     | text    | 
 v6     | text    | 
 v7     | text    | 
 v8     | text    | 
 v9     | text    | 
 v10    | text    | 
 wc_id  | text    | 

atndb=# \d atn_all_haulout;
                                    Table "biologging.atn_all_haulout"
      Column      |         Type          |                           Modifiers                           
------------------+-----------------------+---------------------------------------------------------------
 idx              | integer               | not null default nextval('atn_all_haulout_idx_seq'::regclass)
 wc_id            | character varying(64) | 
 deployid         | integer               | 
 ptt              | integer               | 
 instrument       | character varying(16) | 
 data_id          | integer               | 
 date_start       | character varying(32) | 
 date_end         | character varying(32) | 
 duration         | character varying(32) | 
 location_quality | character varying(4)  | 
 latitude         | double precision      | default 0.0
 longitude        | double precision      | default 0.0

