
drop table if exists biologging.atn_all_sst;
create table biologging.atn_all_sst (
    idx               serial               primary key,
    wc_id             varchar(64)          null,
    deployid          integer              null,
    ptt               integer              null,
    depth_sensor      varchar(32)          null,
    instrument        varchar(16)          null,
    data_date         varchar(32)          null,
    location_quality  varchar(4)           null,
    latitude          double precision     null,
    longitude         double precision     null,
    depth             double precision     null,
    temperature       double precision     null,
    data_source       varchar(16)          null
);

alter table biologging.atn_all_sst owner to postgres;

