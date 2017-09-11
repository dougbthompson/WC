
drop table if exists biologging.atn_all_locations;
create table biologging.atn_all_locations (
    id                     serial         primary key,
    deployid               integer              null,
    ptt                    integer              null,
    instr                  varchar(16)          null,
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

DeployID,Ptt   ,Instr,Date                       ,Type   ,Quality,Latitude,Longitude,Error radius,Error Semi-major axis,Error Semi-minor axis,Error Ellipse orientation,Offset,Offset orientation,GPE MSD,GPE U,Count,Comment

8       ,171361,Mk10 ,20:15:00.860001 19-Jul-2017,FastGPS,       ,28.5771           ,-80.6533,,,,,,,,,,
