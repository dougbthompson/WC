
drop table if exists biologging.atn_all_fastgps;
create table biologging.atn_all_fastgps (
    idx            serial               primary key,
    wc_id          varchar(64)          null,
    name           varchar(32)          null,
    day            varchar(16)          null,
    time           varchar(16)          null,
    count          integer              null,
    time_offset    double precision     null,
    locnumber      integer              null,
    failures       integer              null,
    hauled_out     integer              null,
    satellites     integer              null,
    initlat        double precision     null,
    initlon        double precision     null,
    inittime       varchar(64)          null,
    inittype       varchar(16)          null,
    latitude       double precision     null,
    longitude      double precision     null,
    height         double precision     null,
    bad_sats       varchar(8)           null,
    residual       double precision     null,
    time_error     double precision     null,
    twic_power     varchar(32)          null,
    fastloc_power  varchar(32)          null,
    noise          varchar(32)          null,
    range_bits     integer              null,

    data_id        integer[]            null,
    data_range     integer[]            null,
    data_signal    integer[]            null,
    data_doppler   integer[]            null,
    data_cnr       integer[]            null
);

alter table biologging.atn_all_fastgps owner to postgres;

create unique index ix01_atn_all_fastgps on biologging.atn_all_fastgps
       (wc_id, name, day, time, inittime);

