
drop table if exists biologging.atn_all_status;
create table biologging.atn_all_status (
    idx                  serial               primary key, 
    wc_id                varchar(64)          null,
    deployid             text                 null,
    ptt                  integer              null,
    depth_sensor         varchar(32)          null,
    instrument           varchar(16)          null,
    sw                   varchar(32)          null,
    rtc                  varchar(32)          null,
    received             varchar(32)          null,
    time_offset          integer              null,
    location_quality     varchar(4)           null,
    latitude             double precision     null,
    longitude            double precision     null,
    data_type            varchar(8)           null,
    hauled_out           integer              null,
    broken_thermistor    integer              null,
    broken_link          varchar(32)          null,
    transmits            varchar(32)          null,
    battery_voltage      varchar(32)          null,
    transmit_voltage     double precision     null,
    transmit_current     double precision     null,
    temperature          double precision     null,
    depth                double precision     null,
    max_depth            double precision     null,
    zero_depth_offset    double precision     null,
    light_level          double precision     null,
    no_dawn_dusk         double precision     null,
    release_type         varchar(32)          null,
    release_time         varchar(32)          null,
    initially_broken     varchar(32)          null,
    burn_minutes         integer              null,
    release_depth        integer              null,
    fast_gps_power       varchar(32)          null,
    twic_power           varchar(32)          null,
    power_limit          varchar(32)          null,
    wet_dry              integer              null,
    wet_dry_min          integer              null,
    wet_dry_max          integer              null,
    wet_dry_threshold    integer              null,
    status_word          varchar(32)          null,
    transmit_power       varchar(32)          null,
    resets               varchar(32)          null,
    pre_rel_tilt         varchar(32)          null,
    pre_rel_tilt_sd      varchar(32)          null,
    pre_rel_tilt_count   varchar(32)          null,
    xmit_queue           varchar(32)          null,
    fast_gps_loc_number  integer              null,
    fast_gps_failures    integer              null,
    battery_disconnect   varchar(32)          null
);

alter table biologging.atn_all_status owner to postgres;

create unique index ix01_atn_all_status on biologging.atn_all_status
       ();

