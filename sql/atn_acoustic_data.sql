
drop table if exists atn_acoustic_data;
create table atn_acoustic_data (
    acoustic_data_id  serial,
    tkey              integer,
    code              integer,
    codespace         text,
    date              text,
    receiver          integer,
    receiver_dnum     integer,
    false_hit         integer,
    ping_detection    timestamp
);

