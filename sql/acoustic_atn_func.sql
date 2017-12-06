
CREATE OR REPLACE FUNCTION acoustic_atn_func (p_start_date text, p_end_date text)
RETURNS SETOF acoustic_atn_station AS $$

    select ad.code           as code,
           count(ad.code)    as detections,
           ast.station_site  as site,
           ast.station_name  as station,
           round(cast(avg(ast.longitude) as numeric),4) as longitude,
           round(cast(avg(ast.latitude)  as numeric),4) as latitude,
           am.commonname     as commonname
      from atn_acoustic_data ad,
           atn_acoustic_station ast,
           atn_acoustic_meta am
     where ad.receiver        = ast.receiver
       and ad.receiver_dnum   = ast.receiver_dnum
       and ad.ping_detection  > $1::date
       and ad.ping_detection <= $2::date
       and ad.false_hit       = 0
       and am.ptt             = ad.code
       and am.commonname     <> ''
       and ast.station_site in ('Ano Nuevo','Palmyra','Tomales')
     group by 1,3,4,7
     order by 3,4,1;

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION acoustic_atn_func_all (p_start_date text, p_end_date text)
RETURNS SETOF acoustic_atn_station AS $$

    select ad.code           as code,
           count(ad.code)    as detections,
           ast.station_site  as site,
           ast.station_name  as station,
           round(cast(avg(ast.longitude) as numeric),4) as longitude,
           round(cast(avg(ast.latitude)  as numeric),4) as latitude,
           am.commonname     as commonname
      from atn_acoustic_data ad,
           atn_acoustic_station ast,
           atn_acoustic_meta am
     where ad.receiver        = ast.receiver
       and ad.receiver_dnum   = ast.receiver_dnum
       and ad.ping_detection  > $1::date
       and ad.ping_detection <= $2::date
       and ad.false_hit       = 0
       and am.ptt             = ad.code
       and am.commonname     <> ''
     group by 1,3,4,7
     order by 3,4,1;

$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION acoustic_atn_func_which (p_start_date text, p_end_date text,
                  commonname text default '%', station_project text default '%', station_region text default '%')
RETURNS SETOF acoustic_atn_station AS $$

    select ad.code           as code,
           count(ad.code)    as detections,
           ast.station_site  as site,
           ast.station_name  as station,
           round(cast(avg(ast.longitude) as numeric),4) as longitude,
           round(cast(avg(ast.latitude)  as numeric),4) as latitude,
           am.commonname     as commonname
      from atn_acoustic_data ad,
           atn_acoustic_station ast,
           atn_acoustic_meta am
     where ad.receiver          = ast.receiver
       and ad.receiver_dnum     = ast.receiver_dnum
       and ad.ping_detection    > $1::date
       and ad.ping_detection   <= $2::date
       and ad.false_hit         = 0
       and am.ptt               = ad.code
       and am.commonname       <> ''
       and am.commonname       like $3::text
       and ast.station_project like $4::text
       and ast.station_region  like $5::text
     group by 1,3,4,7
     order by 3,4,1;

$$ LANGUAGE sql;

  eventid  |  site   |        date         | code  | commonname  
-----------+---------+---------------------+-------+-------------
 191201700 | Tomales | 2016-12-05 00:23:55 | 33546 | White Shark
 191201700 | Tomales | 2016-12-05 01:45:27 | 33546 | White Shark
 191600100 | Tomales | 2016-12-05 01:46:19 |  6168 | White Shark
 191600100 | Tomales | 2016-12-05 01:49:38 |  6168 | White Shark
 191201700 | Tomales | 2016-12-05 02:16:13 | 33546 | White Shark
 191201700 | Tomales | 2016-12-05 02:18:19 | 33546 | White Shark

 code  |  site   |        date         |   commonname    
-------+---------+---------------------+-----------------
  6346 | Palmyra | 2017-01-22 20:18:42 | Manta Ray
  6346 | Palmyra | 2017-03-24 23:25:15 | Manta Ray
  6346 | Palmyra | 2016-12-26 23:57:54 | Manta Ray
  6346 | Palmyra | 2017-02-05 20:12:04 | Manta Ray
  6346 | Palmyra | 2017-02-05 20:14:47 | Manta Ray
  6346 | Palmyra | 2017-02-05 20:27:32 | Manta Ray
  6346 | Palmyra | 2017-02-05 20:41:39 | Manta Ray

select ad.code            as code,
       ast.station_region as site,
       ad.ping_detection  as date,
       am.commonname      as commonname

  from atn_acoustic_data ad,
       atn_acoustic_station ast,
       atn_acoustic_meta am

 where ast.station_site     = 'Palmyra'
   and ad.receiver          = ast.receiver
   and ad.receiver_dnum     = ast.receiver_dnum
   and ad.ping_detection    > '2017-06-01'::date
   and ad.ping_detection   <= '2018-01-01'::date
   and ad.false_hit         = 0
   and am.ptt               = ad.code
   and am.commonname       <> ''




















