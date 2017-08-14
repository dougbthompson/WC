
drop table if exists wc_all_deployment_profiles;
create table wc_all_deployment_profiles (
  wc_id                  text             not null,
  owner                  text                 null,
  status                 text                 null,
  last_update_date       integer          not null,
  tag_tag_type           text                 null,
  tag_serial_number      text                 null,
  argos_program_number   integer              null,
  argos_ptt_decimal      integer              null,
  sources_source         text                 null,
  labels_category_name   text                 null,
  labels_category_label  text                 null,
  deploy_id              text                 null,
  two_digit_year         double precision     null,
  primary key (wc_id, last_update_date)
);

drop table if exists wc_all_deployments;
create table wc_all_deployments (
  wc_id                        text             not null, 
  owner                        text                 null, 
  status                       text                 null, 
  last_update_date             integer          not null, 
  tag_tag_type                 text                 null, 
  tag_serial_number            text                 null, 
  argos_program_number         integer              null, 
  argos_ptt_decimal            integer              null, 
  argos_first_uplink_date      integer              null, 
  argos_last_uplink_date       integer              null, 
  last_location_latitude       double precision     null, 
  last_location_longitude      double precision     null, 
  last_location_location_date  integer              null, 
  sources_source               text                 null, 
  two_digit_year               double precision     null, 
  primary key (wc_id, last_update_date)
);


drop table if exists wc_all_locations;
create table wc_all_locations (
  wc_id                      text                 null, 
  date                       integer              null, 
  latitude                   double precision     null, 
  longitude                  double precision     null, 
  location_class             text                 null, 
  error_radius               integer              null, 
  error_semi_major_axis      integer              null, 
  error_semi_minor_axis      integer              null, 
  error_ellipse_orientation  integer              null, 
  primary key (wc_id, date, latitude, longitude)
);

drop table if exists wc_all_profiles;
create table wc_all_profiles (
  wc_id                          text     null, 
  date                           text     null, 
  depth_sensor_resolution        text     null, 
  temperature_sensor_resolution  text     null, 
  gps_snapshot_date              text     null, 
  gps_snapshot_latitude          text     null, 
  gps_snapshot_longitude         text     null, 
  gps_snapshot_residual          text     null, 
  gps_snapshot_time_error        text     null, 
  gps_snapshot_satellites        text     null, 
  gps_snapshot_bad_satellites    text     null, 
  bin_depth                      text[]   null, 
  bin_temperature                text[]   null, 
  bin_discontinuity              text[]   null, 
  primary key (wc_id, date)
);

