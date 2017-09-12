
drop table if exists biologging.atn_all_summary;
create table biologging.atn_all_summary (
    id                   serial               primary key, 
    deployid             integer              null,
    ptt                  integer              null,
    instrument           varchar(16)          null,
    sw                   varchar(32)          null,
    percent_decoded      integer              null,
    passes               integer              null,
    percent_argos_loc    integer              null,
    message_per_pass     integer              null,
    ds                   integer              null,
    di                   integer              null,
    power_min            varchar(32)          null,
    power_avg            varchar(32)          null,
    power_max            varchar(32)          null,
    min_interval         integer              null,
    xmit_time_earliest   varchar(32)          null,
    xmit_time_latest     varchar(32)          null,
    xmit_days            integer              null,
    data_time_earliest   varchar(32)          null,
    data_time_latest     varchar(32)          null,
    data_days            integer              null,
    release_date         varchar(32)          null,
    release_type         varchar(32)          null,
    deploy_date          varchar(32)          null
);

DeployID,Ptt   ,Instr,SW,PercentDecoded,Passes,PercentArgosLoc,MsgPerPass,DS  ,DI,MinPower,AvgPower,MaxPower,MinInterval,EarliestXmitTime    ,LatestXmitTime      ,XmitDays,EarliestDataTime    ,LatestDataTime      ,DataDays,ReleaseDate,ReleaseType,DeployDate
8       ,171361,Mk10 ,  ,79            ,519   ,100            ,3         ,1491,  ,        ,        ,        ,14         ,20:45:34 19-Jul-2017,15:04:28 31-Aug-2017,43      ,20:15:00 19-Jul-2017,10:18:28 31-Aug-2017,43      ,           ,           ,
