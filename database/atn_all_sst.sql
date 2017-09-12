
drop table if exists biologging.atn_all_sst;
create table biologging.atn_all_sst (
    id                serial               primary key,
    deployid          integer              null,
    ptt               integer              null,
    depth_sensor      varchar(32)          null,
    instrument        varchar(16)          null,
    data_date         varchar(32)          null,
    location_quality  varchar(4)           null,
    latitude          double precision     null,
    longitude         double precision     null,
    depth             double precision     null,
    temperature       double precision     null,
    data_source       varchar(16)          null
);

DeployID,Ptt,DepthSensor,Instr,Date,LocationQuality,Latitude,Longitude,Depth,Temperature,Source

8,171361,,Mk10,11:00:00 26-Jul-2017,,,,0.0,26.6,Status
