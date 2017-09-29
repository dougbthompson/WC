
drop table if exists biologging.atn_all_rawargos;
create table biologging.atn_all_rawargos (
    idx                    serial               primary key,
    wc_id                  varchar(64)          null,
    program                text                 null,
    ptt                    integer              null,
    length                 integer              null,
    satellite              varchar(16)          null,
    data_class             varchar(4)           null,
    pass                   integer              null,
    pass_date              varchar(32)          null,
    pass_time              varchar(32)          null,
    latitude1              double precision     null,
    longitude1             double precision     null,
    comment                text                 null,
    frequency              integer              null,
    power                  double precision     null,
    iq                     integer              null,
    duplicates             integer              null,
    message_date           varchar(32)          null,
    message_time           varchar(32)          null,
    latitude2              double precision     null,
    longitude2             double precision     null,
    duration               integer              null,
    error_radius           integer              null,
    error_semi_major_axis  integer              null,
    error_semi_minor_axis  integer              null,
    error_ellipse_orient   integer              null,
    data_offset            integer              null,
    offset_orient          integer              null,

    data_sensor            integer[]            null  -- 32 sensors
);

alter table biologging.atn_all_rawargos owner to postgres;

create unique index ix01_atn_all_rawargos on biologging.atn_all_rawargos
       (wc_id, program, ptt, satellite, message_date, message_time);

