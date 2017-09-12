
drop table if exists biologging.atn_all_rtc;
create table biologging.atn_all_rtc (
    id               serial           primary key,
    deployid         integer          null,
    ptt              integer          null,
    instr            varchar(16)      null,
    correction_type  varchar(16)      null,
    tag_date         varchar(32)      null,
    tag_time         varchar(32)      null,
    real_date        varchar(32)      null,
    real_time        varchar(32)      null
);

DeployID,Ptt,Instr,CorrectionType,TagDate,TagTime,RealDate,RealTime

8,171361,Mk10,Strong,19-Jul-2017,23:19:40,19-Jul-2017,23:19:42
