
drop table if exists biologging.atn_all_argos;
create table biologging.atn_all_argos (
    id               serial               primary key,
    deployid         integer              null,
    ptt              integer              null,
    instr            varchar(8)           null,
    recordtype       varchar(8)           null,
    msgcount         integer              null,
    duplicates       integer              null,
    corrupt          integer              null,
    avginterval      varchar(32)          null,
    mininterval      varchar(32)          null,
    date             varchar(32)          null,
    satellite        varchar(8)           null,
    locationquality  varchar(4)           null,
    latitude         double precision     null,
    longitude        double precision     null,
    latitude2        double precision     null,
    longitude2       double precision     null,
    iq               integer              null,
    duration         varchar(16)          null,
    frequency        integer              null,
    power            double precision     null
);

