
drop table if exists biologging.atn_all_haulout;
create table biologging.atn_all_haulout (
    idx               serial               primary key,
    wc_id             varchar(64)          null,
    deployid          text                 null,
    ptt               integer              null,
    instrument        varchar(16)          null,
    data_id           integer              null,
    date_start        varchar(32)          null,
    date_end          varchar(32)          null,
    duration          varchar(32)          null,
    location_quality  varchar(4)           null,
    latitude          double precision     null default 0.0,
    longitude         double precision     null default 0.0
);

alter table biologging.atn_all_haulout owner to postgres;

create unique index ix01_atn_all_haulout on biologging.atn_all_haulout
       (wc_id, deployid, ptt, instrument, data_id, date_start);

