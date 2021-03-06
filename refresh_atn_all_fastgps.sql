
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_fastgps()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v12 FROM biologging.wc_zip_fastgps;

    v_wc_id         text;
    v_name          integer;
    v_day           text;
    v_time          text;
    v_inittime      text;

    v_data_id       integer[];
    v_data_range    integer[];
    v_data_signal   integer[];
    v_data_doppler  integer[];
    v_data_cnr      integer[];

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_name, v_day, v_time, v_inittime;
        exit when not found; 

        if not exists (
            select 1
              from biologging.atn_all_fastgps a
             where a.wc_id     = v_wc_id
               and a.name      = v_name::text
               and a.day       = v_day
               and a.time      = v_time
               and a.inittime  = v_inittime)
        then
            select array[
                   v24, v29, v34, v39,
                   nullif(v44,'')::integer, nullif(v49,'')::integer, nullif(v54,'')::integer, nullif(v59,'')::integer,
                   nullif(v64,'')::integer, nullif(v69,'')::integer, nullif(v74,'')::integer, nullif(v79,'')::integer,
                   nullif(v84,'')::integer, nullif(v89,'')::integer, nullif(v94,'')::integer ]
              into v_data_id
              from biologging.wc_zip_fastgps a
             where a.wc_id  = v_wc_id
               and a.v1     = v_name
               and a.v2     = v_day
               and a.v3     = v_time
               and a.v12    = v_inittime
             limit 1;

            select array[
                   v25, v30, v35, v40,
                   nullif(v45,'')::integer, nullif(v50,'')::integer, nullif(v55,'')::integer, nullif(v60,'')::integer,
                   nullif(v65,'')::integer, nullif(v70,'')::integer, nullif(v75,'')::integer, nullif(v80,'')::integer,
                   nullif(v85,'')::integer, nullif(v90,'')::integer, nullif(v95,'')::integer ]
              into v_data_range
              from biologging.wc_zip_fastgps a
             where a.wc_id  = v_wc_id
               and a.v1     = v_name
               and a.v2     = v_day
               and a.v3     = v_time
               and a.v12    = v_inittime
             limit 1;

            select array[
                   nullif(v26,'')::integer, nullif(v31,'')::integer, nullif(v36,'')::integer, nullif(v41,'')::integer,
                   nullif(v46,'')::integer, nullif(v51,'')::integer, nullif(v56,'')::integer, nullif(v61,'')::integer,
                   nullif(v66,'')::integer, nullif(v71,'')::integer, nullif(v76,'')::integer, nullif(v81,'')::integer,
                   nullif(v86,'')::integer, nullif(v91,'')::integer, nullif(v96,'')::integer ]
              into v_data_signal
              from biologging.wc_zip_fastgps a
             where a.wc_id  = v_wc_id
               and a.v1     = v_name
               and a.v2     = v_day
               and a.v3     = v_time
               and a.v12    = v_inittime
             limit 1;

            select array[
                   nullif(v27,'')::integer, nullif(v32,'')::integer, nullif(v37,'')::integer, nullif(v42,'')::integer,
                   nullif(v47,'')::integer, nullif(v52,'')::integer, nullif(v57,'')::integer, nullif(v62,'')::integer,
                   nullif(v67,'')::integer, nullif(v72,'')::integer, nullif(v77,'')::integer, nullif(v82,'')::integer,
                   nullif(v87,'')::integer, nullif(v92,'')::integer, nullif(v97,'')::integer ]
              into v_data_doppler
              from biologging.wc_zip_fastgps a
             where a.wc_id  = v_wc_id
               and a.v1     = v_name
               and a.v2     = v_day
               and a.v3     = v_time
               and a.v12    = v_inittime
             limit 1;

            select array[
                   nullif(v28,'')::integer, nullif(v33,'')::integer, nullif(v38,'')::integer, nullif(v43,'')::integer,
                   nullif(v48,'')::integer, nullif(v53,'')::integer, nullif(v58,'')::integer, nullif(v63,'')::integer,
                   nullif(v68,'')::integer, nullif(v73,'')::integer, nullif(v78,'')::integer, nullif(v83,'')::integer,
                   nullif(v88,'')::integer, nullif(v93,'')::integer, nullif(v98,'')::integer ]
              into v_data_cnr
              from biologging.wc_zip_fastgps a
             where a.wc_id  = v_wc_id
               and a.v1     = v_name
               and a.v2     = v_day
               and a.v3     = v_time
               and a.v12    = v_inittime
             limit 1;

            /*
             * if the column is in the atn_all.ix01_atn_all, then it needs to be inserted as blanks
             * not null, since the data from wc is in blanks, hate empty dates
             */
            insert into biologging.atn_all_fastgps (wc_id, name, day, time, count, time_offset, locnumber, failures, hauled_out,
                   satellites, initlat, initlon, inittime, inittype, latitude, longitude, height, bad_sats, residual, time_error,
                   twic_power, fastloc_power, noise, range_bits, data_id, data_range, data_signal, data_doppler, data_cnr)

            select wc_id, v1::text,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12,v13,nullif(v14,'')::double precision,
                   nullif(v15,'')::double precision,nullif(v16,'')::double precision,v17,
                   nullif(v18,'')::double precision,nullif(v19,'')::double precision,v20,v21,v22,v23,
                   v_data_id,v_data_range,v_data_signal,v_data_doppler,v_data_cnr
              from biologging.wc_zip_fastgps a
             where a.wc_id  = v_wc_id
               and a.v1     = v_name
               and a.v2     = v_day
               and a.v3     = v_time
               and a.v12    = v_inittime
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

    name           varchar(32)          null, int
    day            varchar(16)          null,
    time           varchar(16)          null,
 4  count          integer              null,

    time_offset    double precision     null,
    locnumber      integer              null,
    failures       integer              null,
 8  hauled_out     integer              null,

    satellites     integer              null,
    initlat        double precision     null,
    initlon        double precision     null,
12  inittime       varchar(64)          null, text

    inittype       varchar(16)          null, text
    latitude       double precision     null, text
    longitude      double precision     null, text
16  height         double precision     null, text

    bad_sats       varchar(8)           null, text
    residual       double precision     null, text
    time_error     double precision     null, text
20  twic_power     varchar(32)          null, text

    fastloc_power  varchar(32)          null, text
    noise          varchar(32)          null, text
23  range_bits     integer              null,

24  data_id        integer[]            null, int
    data_range     integer[]            null, int
    data_signal    integer[]            null, text
    data_doppler   integer[]            null, text
    data_cnr       integer[]            null, text


 v1     | integer          | 
 v2     | text             | 
 v3     | text             | 
 v4     | integer          | 
 v5     | double precision | 
 v6     | integer          | 
 v7     | integer          | 
 v8     | integer          | 
 v9     | integer          | 
 v10    | double precision | 
 v11    | double precision | 
 v12    | text             | 
 v13    | text             | 
 v14    | text             | 
 v15    | text             | 
 v16    | text             | 
 v17    | text             | 
 v18    | text             | 
 v19    | text             | 
 v20    | text             | 
 v21    | text             | 
 v22    | text             | 
 v23    | integer          | 
 v24    | integer          | 
 v25    | integer          | 
 v26    | text             | 
 v27    | text             | 
 v28    | text             | 
 v29    | integer          | 
 v30    | integer          | 
 v31    | text             | 
 v32    | text             | 
 v33    | text             | 
 v34    | integer          | 
 v35    | integer          | 
 v36    | text             | 
 v37    | text             | 
 v38    | text             | 
 v39    | integer          | 
 v40    | integer          | 
 ...
 v98    | text             | 
 wc_id  | text             | 

