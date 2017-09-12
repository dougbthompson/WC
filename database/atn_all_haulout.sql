
drop table if exists biologging.atn_all_haulout;
create table biologging.atn_all_haulout (
    id                serial               primary key,
    deployid          integer              null,
    ptt               integer              null,
    instr             varchar(16)          null,
    data_id           integer              null,
    date_start        varchar(32)          null,
    date_end          varchar(32)          null,
    duration          varchar(32)          null,
    location_quality  varchar(4)           null,
    latitude          double precision     null,
    longitude         double precision     null
);

DeployID,Ptt   ,Instr,Id,Start               ,End,Duration,LocationQuality,Latitude,Longitude

8       ,171361,Mk10 ,1 ,18:21:00 19-Jul-2017,   ,        ,               ,        ,
