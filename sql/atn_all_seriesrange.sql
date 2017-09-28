
drop table if exists biologging.atn_all_seriesrange;
create table biologging.atn_all_seriesrange (
    idx                 serial               primary key,
    wc_id               varchar(64)          null,
    deployid            text                 null,
    ptt                 integer              null,
    depth_sensor        double precision     null,
    source              varchar(32)          null,
    instrument          varchar(16)          null,
    count               integer              null,
    date_start          varchar(32)          null,
    date_end            varchar(32)          null,
    location_quality    varchar(8)           null,
    latitude            double precision     null,
    longitude           double precision     null,
    depth_min           double precision     null,
    depth_min_accuracy  double precision     null,
    depth_max           double precision     null,
    depth_max_accuracy  double precision     null,
    temp_min            double precision     null,
    temp_min_accuracy   double precision     null,
    temp_max            double precision     null,
    temp_max_accuracy   double precision     null
);

alter table biologging.atn_all_seriesrange owner to postgres;

create unique index ix01_atn_all_seriesrange on biologging.atn_all_seriesrange
       (wc_id, deployid, ptt, instrument, date_start, date_end);

