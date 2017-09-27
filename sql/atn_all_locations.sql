
drop table if exists biologging.atn_all_locations;
create table biologging.atn_all_locations (
    idx                    serial               primary key,
    wc_id                  varchar(64)          null,
    deployid               text                 null,
    ptt                    integer              null,
    instrument             varchar(16)          null,
    data_date              varchar(32)          null,
    data_type              varchar(16)          null,
    date_quality           varchar(4)           null,
    latitude               double precision     null,
    longitude              double precision     null,
    error_radius           varchar(32)          null,
    error_semi_major_axis  varchar(32)          null,
    error_semi_minor_axis  varchar(32)          null,
    error_ellipse_orient   varchar(32)          null,
    data_offset            varchar(32)          null,
    offset_orient          varchar(32)          null,
    gpe_msd                varchar(32)          null,
    gpe_u                  varchar(32)          null,
    data_count             integer              null,
    data_comment           text                 null
);

alter table biologging.atn_all_locations owner to postgres;

