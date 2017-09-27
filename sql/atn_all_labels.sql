
drop table if exists biologging.atn_all_labels;
create table biologging.atn_all_labels (
    idx      serial             primary key,
    wc_id    varchar(64)        null,
    key      varchar(64)    not null,
    values   varchar(64)[]  not null
);

alter table biologging.atn_all_labels owner to postgres;

create unique index ix01_atn_all_labels on biologging.atn_all_labels (wc_id, key);

