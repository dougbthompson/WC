
drop table if exists biologging.atn_all_minmaxdepth;
create table biologging.atn_all_minmaxdepth (
    id                serial         primary key,
    deployid          integer              null,
    ptt               integer              null,
    depthsensor       varchar(32)          null,
    instr             varchar(16)          null,
    data_date         varchar(32)          null,
    location_quality  varchar(4)           null,
    latitude          double precision     null,
    longitude         double precision     null,
    min_depth         double precision     null,
    min_accuracy      double precision     null,
    min_source        varchar(16)          null,
    max_depth         double precision     null,
    max_accuracy      double precision     null,
    max_source        varchar(16)          null
);

DeployID,Ptt   ,DepthSensor,Instr,Date                ,LocationQuality,Latitude,Longitude,MinDepth,MinAccuracy,MinSource,MaxDepth,MaxAccuracy,MaxSource

8       ,171361,           ,Mk10 ,00:00:00 19-Jul-2017,               ,        ,         ,0.000000,0.000000   ,Status   ,        ,           ,
