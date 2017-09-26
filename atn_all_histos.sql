
drop table if exists biologging.atn_all_histos;
create table biologging.atn_all_histos (
    idx               serial               primary key,
    wc_id             varchar(64)          null,
    deployid          integer              null,
    ptt               integer              null,
    depth_sensor      varchar(32)          null,
    source            varchar(32)          null,
    instrument        varchar(16)          null,
    histtype          varchar(16)          null,
    data_date         varchar(32)          null,
    time_offset       double precision     null,
    data_count        integer              null,
    bad_therm         integer              null,
    location_quality  varchar(4)           null,
    latitude          double precision     null,
    longitude         double precision     null,
    numbins           integer              null,
    data_sum          double precision     null,

    data_bin          double precision[]   null
);

alter table biologging.atn_all_histos owner to postgres;

