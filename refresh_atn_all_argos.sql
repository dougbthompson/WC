
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_argos()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v10, v11 FROM biologging.wc_zip_argos;

    v_wc_id         text;
    v_deployid      integer;
    v_ptt           integer;
    v_instrument    text;
    v_date          text;
    v_satellite     text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_date, v_satellite;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_argos a
            where a.wc_id      = v_wc_id
              and a.deployid   = v_deployid
              and a.ptt        = v_ptt
              and a.instrument = v_instrument
              and a.date       = v_date
              and a.satellite  = v_satellite)
        then
            insert into biologging.atn_all_argos (wc_id, deployid, ptt, instrument, record_type, message_count,
                   duplicates, corrupt, interval_avg, interval_min, date, satellite, location_quality, latitude1,
                   longitude1, latitude2, longitude2, iq, duration, frequency, power)

            select wc_id, v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,
                   nullif(v13,'')::double precision,nullif(v14,'')::double precision,
                   nullif(v15,'')::double precision,nullif(v16,'')::double precision,
                   nullif(v17,'')::integer,v18,v19,nullif(v20,'')::double precision

              from biologging.wc_zip_argos a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_instrument
               and a.v10    = v_date
               and a.v11    = v_satellite
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

o v1 |   v2   |  v3  | v4 | v5 | v6 | v7 | v8  | v9  |         v10          | v11 | v12 |   v13   |   v14    |   v15   |   v16    | v17 | v18 |    v19    | v20  |          wc_id           
----+--------+------+----+----+----+----+-----+-----+----------------------+-----+-----+---------+----------+---------+----------+-----+-----+-----------+------+--------------------------
  8 | 171361 | Mk10 | DS |  5 |  2 |  1 |     |     | 20:45:34 19-Jul-2017 | NP  | 3   | 28.5764 | -80.6533 | 28.5764 | -80.6533 | 50  |     | 401677374 | -122 | 596fcbcfefec720e04424f61

Table "biologging.wc_zip_argos"
 Column |  Type   | Modifiers 
--------+---------+-----------
 v1     | integer | 
 v2     | integer | 
 v3     | text    | 
 v4     | text    | 
 v5     | integer | 
 v6     | integer | 
 v7     | integer | 
 v8     | text    | 
 v9     | text    | 
 v10    | text    | 
 v11    | text    | 
 v12    | text    | 
 v13    | text    | 
 v14    | text    | 
 v15    | text    | 
 v16    | text    | 
 v17    | text    | 
 v18    | text    | 
 v19    | integer | 
 v20    | text    | 
 wc_id  | text    | 

atndb=# \d atn_all_argos
                                    Table "biologging.atn_all_argos"
      Column      |         Type          |                          Modifiers                          
------------------+-----------------------+-------------------------------------------------------------
 idx              | integer               | not null default nextval('atn_all_argos_idx_seq'::regclass)
 wc_id            | character varying(64) | 
 deployid         | integer               | 
 ptt              | integer               | 
 instrument       | character varying(8)  | 
 record_type      | character varying(8)  | 
 message_count    | integer               | 
 duplicates       | integer               | 
 corrupt          | integer               | 
 interval_avg     | character varying(32) | 
 interval_min     | character varying(32) | 
 date             | character varying(32) | 
 satellite        | character varying(8)  | 
 location_quality | character varying(4)  | 
 latitude1        | double precision      | 
 longitude1       | double precision      | 
 latitude2        | double precision      | 
 longitude2       | double precision      | 
 iq               | integer               | 
 duration         | character varying(16) | 
 frequency        | integer               | 
 power            | double precision      | 

v1,v2,v3,v10,v11

(deployid, ptt, instrument, date, satellite);

