
drop table if exists atn_all_fastgps;
create table atn_all_fastgps (
    id             serial          primary key,
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

Name,Day       ,Time    ,Count,Time Offset,LocNumber,Failures,Hauled Out,Satellites,InitLat,InitLon ,InitTime                   ,InitType,Latitude,Longitude,Height,Bad Sats,Residual,Time Error,TWIC Power,Fastloc Power,Noise,Range Bits,Id,Range,Signal,Doppler,CNR ,

8  ,19-Jul-2017,20:15:00,10   ,2.000000   ,1        ,8       ,1         ,6         ,28.5771,-80.6533,20:15:00.860001 19-Jul-2017,FastGPS ,28.5771 ,-80.6533 ,      ,        ,8.8     ,-1.1      ,          ,             ,     ,15        ,5 ,26098,      ,       ,    ,2,19978,,,,17,18540,,,,12,27070,,,,6,18216,,,,19,20066,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
