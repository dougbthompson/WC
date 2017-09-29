
drop table if exists biologging.atn_all_behavior;
create table biologging.atn_all_behavior (
    idx               serial               primary key,
    wc_id             varchar(64)          null,
    deployid          text                 null,
    ptt               integer              null,
    depth_sensor      varchar(32)          null,
    source            varchar(32)          null,
    instrument        varchar(16)          null,
    count             integer              null,
    date_start        varchar(32)          null,
    date_end          varchar(32)          null,
    what              varchar(32)          null,

    shallow           double precision     null,
    deep              double precision     null,

    number            integer[]            null,
    shape             varchar(64)[]        null,
    depth_min         integer[]            null,
    depth_max         integer[]            null,
    duration_min      double precision[]   null,
    duration_max      double precision[]   null
);

alter table biologging.atn_all_behavior owner to postgres;

create unique index ix01_atn_all_behavior on biologging.atn_all_behavior
       (wc_id, deployid, ptt, instrument, date_start, date_end);

