
drop view if exists acoustic_atn;
create or replace view acoustic_atn
as

  select a.code        as code,
         count(a.code) as detections,
         a.site        as site,
         a.station     as station,
         a.longitude   as longitude,
         a.latitude    as latitude,
         a.commoname   as commonname

    from acoustic_data a
   where a.


