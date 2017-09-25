
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_haulout()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3 FROM biologging.wc_zip_haulout;

BEGIN

    # v1,v2,v3,v4,v5

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

