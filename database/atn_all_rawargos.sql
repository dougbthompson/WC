
drop table if exists biologging.atn_all_rawargos;
create table biologging.atn_all_rawargos (
    id                     serial               primary key,
    program                integer              null,
    ptt                    integer              null,
    length                 integer              null,
    satellite              varchar(16)          null,
    data_class             integer              null,
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

Prog,PTT   ,Len,Satellite,Class,Pass,PassDate   ,PassTime,Latitude,Longitude,Comment,Frequency,Power,IQ,Dups,MsgDate    ,MsgTime         ,Latitude2,Longitude2,Duration,Error radius,Error Semi-major axis,Error Semi-minor axis,Error Ellipse orientation,Offset,Offset orientation,SENSOR #01,SENSOR

6305,171361,27 ,NP       ,3    ,4   ,19-Jul-2017,20:45:34,28.5764 ,-80.6533 ,       ,401677374,-122 ,50,0   ,19-Jul-2017,20:46:42,28.5764,-80.6533 ,270       ,143     ,358        ,57                    ,90                   ,                         ,      ,121               ,156,117,231,68,240,24,185,124,133,56,42,50,27,25,166,248,209,202,39,57,138,197,52,149,96,33,,,,,
