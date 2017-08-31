
drop table if exists wc_zip_argos;
create table wc_zip_argos (
  wc_id                      varchar(64)      not null,
  date                       integer          not null,
  deploy_id                  varchar(64)          null,
  ptt                        integer              null,
  instrument_family          varchar(128)         null,
  record_type                varchar(8)           null,
  msg_count                  integer              null,
  duplicates                 varchar(8)           null,
  corrupt                    integer              null,
  avg_interval               integer              null,
  min_interval               integer              null,
  date                       varchar(32)          null,
  satellite                  varchar(32)          null,
  location_quality           varchar(8)           null,
  latitude1                  double precision     null,
  longitude1                 double precision     null,
  latitude2                  double precision     null,
  longitude2                 double precision     null,
  iq                         varchar(64)          null,
  duration                   integer              null,
  frequency                  double precision     null,
  power                      integer              null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_behavior;
create table wc_zip_behavior (
  wc_id                      varchar(64)      not null,
  date                       integer          not null,
  deploy_id                  varchar(64)          null,
  ptt                        integer              null,
  depth_sensor               double precision     null,
  source                     varchar(128)         null,
  instrument_family          varchar(128)         null,
  data_count                 integer              null,
  start_ts                   integer              null,
  end_ts                     integer              null,
  what_element               varchar(32)          null, -- surface, haulout, dive, mesage, unrecognized
  number                     integer              null,
  shape                      varchar(128)         null,
  min_depth                  integer              null,
  max_depth                  integer              null,
  min_duration               integer              null,
  max_duration               integer              null,
  shallow                    integer              null,
  deep                       integer              null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_corrupt;
create table wc_zip_corrupt (
  wc_id                      varchar(64)      not null,
  date                       integer          not null,
  deploy_id                  varchar(64)          null,
  ptt                        integer              null,
  instrument_family          varchar(128)         null,
  date_ts                    integer              null,
  duplicates                 integer              null,
  satellite                  varchar(32)          null,
  location_quality           varchar(8)           null,
  latitude                   double precision     null,
  longitude                  double precision     null,
  reason                     varchar(128)         null,
  possible_ts                integer              null,
  possible_type              varchar(64)          null,
  data_bytes                 bytea                null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_divepdt;
create table wc_zip_divepdt (
  wc_id                      varchar(64)      not null,
  date                       integer          not null,
  bad_therm                  varchar(8)           null,
  depth                      integer              null,
  temperature_delta          double precision     null,
  temperature                double precision     null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_ddn;
create table wc_zip_ddn (
  wc_id                      varchar(64)      not null,
  date                       integer          not null,
  deploy_id                  varchar(64)          null,
  ptt                        integer              null,
  instrument_family          varchar(128)         null,
  data_count                 integer              null,
  date_ts                    integer              null,
  disposition                varchar(16)          null, -- dry, deep, neither
  code                       varchar(8)           null, -- dry(0), deep(1), neither(2)
  primary key (wc_id, date)
);


drop table if exists wc_zip_fastlocgps;
create table wc_zip_fastlocgps (
  wc_id                      varchar(64)      not null,
  date                       integer          not null,
  name                       varchar(64)          null,
  gps_day                    varchar(32)          null,
  gps_time                   varchar(32)          null,
  data_count                 integer              null,
  time_offset                integer              null,
  loc_number                 integer              null,
  failures                   integer              null,
  hauled_out                 varchar(8)           null,
  satellites                 integer              null,
  init_latitude              double precision     null,
  init_longitude             double precision     null,
  init_time                  integer              null,
  init_source                varchar(32)          null,
  latitude                   double precision     null,
  longitude                  double precision     null,
  height                     integer              null,
  bad_satellites             integer              null,
  residual                   integer              null,
  time_error                 integer              null,
  twic_power                 double precision     null,
  fastloc_power              double precision     null,
  sn_noise                   .
  sn_range_bits              .
  sn_id                      .
  primary key (wc_id, date)
);


drop table if exists wc_zip_haulout;
create table wc_zip_haulout (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_histos;
create table wc_zip_histos (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_lightloc;
create table wc_zip_lightloc (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_locations;
create table wc_zip_locations (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_xlocations;
create table wc_zip_xlocations (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_mixlayer;
create table wc_zip_mixlayer (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_pdt;
create table wc_zip_pdt (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_series;
create table wc_zip_series (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_seriesrange;
create table wc_zip_seriesrange (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_sst;
create table wc_zip_sst (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_status;
create table wc_zip_status (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_stp;
create table wc_zip_stp (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_summary;
create table wc_zip_summary (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_rtc;
create table wc_zip_rtc (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_labels;
create table wc_zip_labels (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_rawargos;
create table wc_zip_rawargos (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_gpe3;
create table wc_zip_gpe3 (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_dailydata;
create table wc_zip_dailydata (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);


drop table if exists wc_zip_all;
create table wc_zip_all (
  wc_id                      varchar(64)  not null,
  date                       integer      not null,
  primary key (wc_id, date)
);

