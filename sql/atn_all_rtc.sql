
drop table if exists biologging.atn_all_rtc;
create table biologging.atn_all_rtc (
    idx              serial           primary key,
    wc_id            varchar(64)      null,
    deployid         integer          null,
    ptt              integer          null,
    instrument       varchar(16)      null,
    correction_type  varchar(16)      null,
    tag_date         varchar(32)      null,
    tag_time         varchar(32)      null,
    real_date        varchar(32)      null,
    real_time        varchar(32)      null
);

alter table biologging.atn_all_rtc owner to postgres;

