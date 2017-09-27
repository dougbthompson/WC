
drop table if exists biologging.atn_all_argos;
create table biologging.atn_all_argos (
    idx               serial               primary key,
    wc_id             varchar(64)          null,
    deployid          text                 null,
    ptt               integer              null,
    instrument        varchar(8)           null,
    record_type       varchar(8)           null,
    message_count     integer              null,
    duplicates        integer              null,
    corrupt           integer              null,
    interval_avg      varchar(32)          null,
    interval_min      varchar(32)          null,
    date              varchar(32)          null,
    satellite         varchar(8)           null,
    location_quality  varchar(4)           null,
    latitude1         double precision     null,
    longitude1        double precision     null,
    latitude2         double precision     null,
    longitude2        double precision     null,
    iq                integer              null,
    duration          varchar(16)          null,
    frequency         integer              null,
    power             double precision     null
);

alter table biologging.atn_all_argos owner to postgres;

