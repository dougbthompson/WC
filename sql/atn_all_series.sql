
drop table if exists biologging.atn_all_series;
create table biologging.atn_all_series (
    idx                serial               primary key,
    wc_id              varchar(64)          null,
    deployid           text                 null,
    ptt                integer              null,
    depth_sensor       varchar(32)          null,
    source             varchar(32)          null,
    instrument         varchar(16)          null,
    date_start         varchar(32)          null,
    date_end           varchar(32)          null,
    location_quality   varchar(8)           null,
    latitude           double precision     null,
    longitude          double precision     null,
    depth              double precision     null,
    depth_range        double precision     null,
    temperature        varchar(32)          null,
    temperature_range  varchar(32)          null
);

alter table biologging.atn_all_series owner to postgres;

create unique index ix01_atn_all_series on biologging.atn_all_series
       (wc_id, deployid, ptt, instrument, date_start, date_end);

