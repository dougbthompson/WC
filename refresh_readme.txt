
create unique index ix01_atn_all on biologging.atn_all (wc_id, deployid, platform_id, program_id, location_date, satellite, message_date);

select a.*
  from wc_zip_all a
 where not exists (
       select 1
         from atn_all b
        where b.wc_id         = a.wc_id
          and b.deployid      = a.v1::integer
          and b.platform_id   = a.v2 
          and b.program_id    = a.v3
          and b.location_date = a.v7
          and b.satellite     = a.v11
          and b.message_date  = a.v14)
