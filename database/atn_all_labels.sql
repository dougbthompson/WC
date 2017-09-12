
drop table if exists biologging.atn_all_labels;
create table biologging.atn_all_labels (
    id       serial         primary key,
    key      varchar(64)    not null,
    values   varchar(64)[]  not null
);

Key,Value(s)

local tag id,8,
Species,CM,
CL-NN,106.0,

local tag id,8,
