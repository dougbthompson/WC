
drop table if exists biologging.atn_all_corrupt;
create table biologging.atn_all_corrupt (
    idx                 serial               primary key,
    wc_id               varchar(64)          null,
    deployid            text                 null,
    ptt                 integer              null,
    instrument          varchar(8)           null,
    date                varchar(64)          null,
    duplicates          integer              null,
    satellite           varchar(8)           null,
    location_quality    varchar(4)           null,
    latitude            double precision     null,
    longitude           double precision     null,
    reason              varchar(64)          null,
    possible_timestamp  varchar(64)          null,
    possible_type       varchar(64)          null,
    bytes               integer[]            null
);

alter table biologging.atn_all_corrupt owner to postgres;

create unique index ix01_atn_all_corrupt on biologging.atn_all_corrupt
       (wc_id, deployid, ptt, instrument, date, satellite, reason);

