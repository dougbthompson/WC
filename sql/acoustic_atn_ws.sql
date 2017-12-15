
CREATE OR REPLACE FUNCTION acoustic_atn_site_list()
RETURNS integer AS $$

DECLARE
    v_value integer;

BEGIN

    truncate table aatams.atn_acoustic_sites_step1;

    insert into aatams.atn_acoustic_sites_step1 
    select ast.station_site   as site
          ,ast.station_name   as station
          ,ast.station_region as region
          ,count(ad.code)     as detections
          ,round(cast(avg(ast.longitude) as numeric),6) as longitude
          ,round(cast(avg(ast.latitude)  as numeric),6) as latitude
      from atn_acoustic_data ad,
           atn_acoustic_station ast,
           atn_acoustic_meta am
     where ad.receiver        = ast.receiver
       and ad.receiver_dnum   = ast.receiver_dnum
       and ad.ping_detection  > ('now'::text::date - (365 * 12))
       and ad.ping_detection <= ('now'::text::date)
       and ad.false_hit       = 0
       and am.ptt             = ad.code
       and am.commonname     <> ''
     group by 1,2,3
     order by 1,4 desc;

    truncate table aatams.atn_acoustic_sites;
    insert into aatams.atn_acoustic_sites
    select distinct a.site, 
           round(avg(a.longitude),6) as longitude, 
           round(avg(a.latitude),6)  as latitude, 
           a.detections
      from atn_acoustic_sites_step1 a
     where a.detections = (
           select max(b.detections)
             from atn_acoustic_sites_step1 b
            where b.site = a.site)
       and a.longitude is not null
       and a.latitude  is not null
       and a.site      <> 'Glider'
     group by 1,4
     order by 1;

    truncate table aatams.atn_acoustic_receivers;
    insert into aatams.atn_acoustic_receivers
    select distinct
           ad.receiver      as receiver
          ,ad.receiver_dnum as receiver_deploy
          ,ast.station_site as site
      from atn_acoustic_data ad,
           atn_acoustic_station ast,
           atn_acoustic_meta am
     where ad.receiver        = ast.receiver
       and ad.receiver_dnum   = ast.receiver_dnum
       and ad.ping_detection  > ('now'::text::date - (365 * 12))
       and ad.ping_detection <= ('now'::text::date)
       and ad.false_hit       = 0
       and am.ptt             = ad.code
       and am.commonname     <> ''
     order by 1,2,3;

    return 1;
END
$$ LANGUAGE plpgsql;

select distinct a.site,
       round(avg(a.longitude),6) as longitude,
       round(avg(a.latitude),6)  as latitude,
       a.detections
  from atn_acoustic_sites_step1 a
 where a.detections = (
       select max(b.detections)
         from atn_acoustic_sites_step1 b
        where b.site = a.site)
   and a.longitude is not null
   and a.latitude  is not null
   and a.site      <> 'Glider'
 group by 1,4
 order by 1;

    select distinct
           ad.receiver      as receiver
          ,ad.receiver_dnum as receiver_deploy
          ,ast.station_site as site
      from atn_acoustic_data ad,
           atn_acoustic_station ast,
           atn_acoustic_meta am
     where ad.receiver        = ast.receiver
       and ad.receiver_dnum   = ast.receiver_dnum
       and ad.ping_detection  > ('now'::text::date - (365 * 12))
       and ad.ping_detection <= ('now'::text::date)
       and ad.false_hit       = 0
       and am.ptt             = ad.code
       and am.commonname     <> ''
     order by 1,2,3;

select a.site, max(a.detections)
  from atn_acoustic_sites_step1 a
 group by 1;

----- -----

drop table if exists aatams.atn_plots_view;
create table aatams.atn_plots_view (
    eventid     integer,
    site        varchar(64),
    date        timestamp without time zone,
    code        integer,
    commonname  varchar(128)
);

CREATE OR REPLACE FUNCTION aatams.acoustic_atn_plot_ws_view (p_start_date text, p_end_date text,
                  commonname text default '%', station_site text default '%')
RETURNS SETOF aatams.atn_plots_view AS $$

    select am.eventid                     as eventid,
           ast.station_site               as site,
           ad.ping_detection              as date,
           ad.code                        as code,
           am.commonname                  as commonname
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

#
# -----
# 

CREATE OR REPLACE FUNCTION acoustic_atn_plot_ws (p_start_date text, p_end_date text,
                  commonname text default '%', station_site text default '%', which_dt_period text default '30')
RETURNS integer AS $$

DECLARE
    v_dt_period integer;

BEGIN
    select date_part('day', p_end_date::timestamp - p_start_date::timestamp) into v_dt_period;

    insert into aatams.atn_plots
    select am.commonname                  as species,
           now()::varchar(10)             as date_value,
           v_dt_period::varchar(32)       as time_period,
           am.eventid::varchar(64)        as eventid,
           ast.station_site               as site,
           ad.ping_detection::varchar(64) as date_value,
           ad.code::varchar(64)           as code,
           am.commonname                  as commonname
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

    return 1;
END
$$ LANGUAGE plpgsql;

$$ LANGUAGE sql;

select * from acoustic_atn_plot_ws(('now'::date-(30*12))::text,('now'::date)::text,'White Shark','%','30');


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




















