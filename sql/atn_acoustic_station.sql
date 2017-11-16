
drop table if exists atn_acoustic_station;
create table atn_acoustic_station (
    station_id       serial,
    topp_station_id  int,
    station_project  text,
    station_region   text,
    station_site     text,
    station_name     text,
    receiver         integer,
    receiver_dnum    integer,
    longitude        double precision,
    latitude         double precision
);

