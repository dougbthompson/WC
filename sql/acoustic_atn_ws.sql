
CREATE OR REPLACE FUNCTION acoustic_atn_plot_ws (p_start_date text, p_end_date text,
                  commonname text default '%', station_site text default '%', which_dt_period text default '30')
RETURNS SETOF atn_plots AS $$

    select am.commonname            as species,
           now()                    as date_value,
           which_dt_period          as time_period,
           am.eventid::varchar(64)  as eventid,
           ast.station_site         as site,
           ad.ping_detection        as date_value,
           ad.code                  as code,
           am.commonname            as commonname
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
       and ast.station_site    like $4::text
     order by ad.code, ad.ping_detection;

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

select 'White Shark',
       '2017-12-06',
       '30',
       am.eventid         as eventid,
       ast.station_region as site,
       ad.ping_detection  as date,
       ad.code            as code,
       am.commonname      as commonname
  from atn_acoustic_data ad,
       atn_acoustic_station ast,
       atn_acoustic_meta am
 where ast.station_site     = 'Palmyra'
   and ad.receiver          = ast.receiver
   and ad.receiver_dnum     = ast.receiver_dnum
   and ad.ping_detection    > 'now'::date - (30 * 1)
   and ad.ping_detection   <= 'now'::date
   and ad.false_hit         = 0
   and am.ptt               = ad.code
   and am.commonname       <> ''
 order by ad.code, ad.ping_detection;




















