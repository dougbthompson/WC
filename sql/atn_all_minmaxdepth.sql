
drop table if exists biologging.atn_all_minmaxdepth;
create table biologging.atn_all_minmaxdepth (
    idx               serial               primary key,
    wc_id             varchar(64)          null,
    deployid          text                 null,
    ptt               integer              null,
    depth_sensor      varchar(32)          null,
    instrument        varchar(16)          null,
    data_date         varchar(32)          null,
    location_quality  varchar(4)           null,
    latitude          double precision     null,
    longitude         double precision     null,
    min_depth         double precision     null,
    min_accuracy      double precision     null,
    min_source        varchar(16)          null,
    max_depth         double precision     null,
    max_accuracy      double precision     null,
    max_source        varchar(16)          null
);

alter table biologging.atn_all_minmaxdepth owner to postgres;

