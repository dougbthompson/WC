
drop table if exists biologging.atn_all;
create table biologging.atn_all(
    idx                    serial               primary key,
    wc_id                  varchar(64)          null,
    deployid               integer              null,
    platform_id            integer              null,
    program_id             integer              null,
    latitude               double precision     null,
    longitude              double precision     null,
    location_quality       varchar(4)           null,
    location_date          varchar(32)          null,
    location_type          varchar(16)          null,
    altitude               integer              null,
    data_pass              integer              null,
    satellite              varchar(8)           null,
    mote_id                varchar(32)          null,
    frequency              double precision     null,
    message_date           varchar(32)          null,
    comp                   integer              null,
    message                varchar(32)          null,
    greater_120db          varchar(32)          null,
    best_level             double precision     null,
    delta_frequency        double precision     null,
    longitude1             double precision     null,
    latitude_sol1          double precision     null,
    longitude2             double precision     null,
    latitude_sol2          double precision     null,
    location_index         integer              null,
    nopc                   integer              null,
    error_radius           integer              null,
    error_semi_major_axis  integer              null,
    error_semi_minor_axis  integer              null,
    error_ellipse_orient   integer              null,
    gdop                   integer              null,
    data_sensor            integer[]            null
);

alter table biologging.atn_all owner to postgres;

