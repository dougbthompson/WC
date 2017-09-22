
CREATE TABLE acoustic_detections (
    id integer NOT NULL,
    file_id bigint NOT NULL,
    receiver_name character varying(255) NOT NULL,
    transmitter_id character varying(255) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    sensor_value real,
    sensor_unit character varying(255),
    duplicate boolean
);

CREATE TABLE activity_log (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    class_name character varying(255) NOT NULL,
    property_name character varying(255) NOT NULL,
    persisted_object_id character varying(255) NOT NULL,
    event_type character varying(255) NOT NULL,
    modification_datetime timestamp with time zone NOT NULL,
    new_value character varying(255),
    old_value character varying(255),
);


CREATE TABLE animal (
    id bigint NOT NULL,
    animal_name character varying(255),
    species_id bigint NOT NULL,
    sex character varying(7) NOT NULL,
);

CREATE TABLE animal_capture (
    id bigint NOT NULL,
    animal_id bigint NOT NULL,
    catcher_id bigint NOT NULL,
    capture_number integer,
    capture_locality character varying(255) NOT NULL,
    capture_location public.geometry NOT NULL,
    capture_datetime timestamp with time zone NOT NULL,
    release_locality character varying(255) NOT NULL,
    release_location public.geometry NOT NULL,
    release_datetime timestamp with time zone NOT NULL,
    release_comments character varying(255),
    tag_status character varying(255)
);

CREATE TABLE animal_measurements (
    id bigint NOT NULL,
    capture_id bigint NOT NULL,
    type character varying(255) NOT NULL,
    unit character varying(20) NOT NULL,
    value real NOT NULL,
    estimate boolean NOT NULL,
    comments character varying(255)
);

CREATE TABLE animal_observations (
    id bigint NOT NULL,
    capture_id bigint NOT NULL,
    "lifeStage" character varying(255) NOT NULL,
    "ageUnit" character varying(20),
    value real,
    estimate boolean,
    "DNA_sample_number" character varying(20),
    "mRNA_sample_number" character varying(20),
    genetic_sample_location character varying(255),
    conventional_tag_numbers character varying(255),
    conventional_tag_locations character varying(255),
    comments character varying(255),
);

CREATE TABLE argos_locations (
    id integer NOT NULL,
    file_id bigint NOT NULL,
    device_name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    "decimalLatitude" double precision NOT NULL,
    "decimalLongitude" double precision NOT NULL,
    location_quality character varying(2) NOT NULL,
    alt_latitude double precision,
    alt_longitude double precision,
    n_mess double precision,
    n_mess_120 double precision,
    best_level double precision,
    pass_dur double precision,
    freq double precision,
    duplicate boolean,
);

CREATE TABLE atn_pat_cl_raw (
    apcr_date character varying(32),
    apcr_time character varying(32),
    apcr_depth double precision,
    apcr_lt double precision,
    apcr_internal_temp double precision,
    apcr_external_temp double precision,
    apcr_julian integer,
    apcr_year integer,
    apcr_month integer,
    apcr_day integer,
    apcr_hour integer,
    apcr_minute integer,
    apcr_second integer
);

CREATE TABLE atn_pat_gl4_raw (
    apgr_month integer,
    apgr_day integer,
    apgr_year integer,
    apgr_longitude double precision,
    apgr_latitude double precision,
    apgr_max_depth double precision,
    apgr_cloud_cover double precision,
    apgr_sst_type double precision,
    apgr_idx double precision[],
    apgr_surface_temps double precision[]
);

CREATE TABLE atn_pat_histo_raw (
    aphr_deployment_id character varying(16) NOT NULL,
    aphr_ptt integer,
    aphr_depth_sensor double precision,
    aphr_source character varying(8),
    aphr_instrument character varying(8),
    aphr_hist_type character varying(16),
    aphr_date character varying(32),
    aphr_time_offset double precision,
    aphr_count integer,
    aphr_bad_therm double precision,
    aphr_location_quality character varying(16),
    aphr_latitude double precision,
    aphr_longitude double precision,
    aphr_numb_bins integer,
    aphr_sum integer,
    aphr_bin double precision[]
);

CREATE TABLE atn_pat_light_location_raw (
    apllr_index integer,
    apllr_deployment_id character varying(16),
    apllr_ptt integer,
    apllr_depth_sensor double precision,
    apllr_instrument character varying(8),
    apllr_day character varying(16),
    apllr_time character varying(16),
    apllr_time_offset double precision,
    apllr_count integer,
    apllr_init_loc_quality integer,
    apllr_init_time character varying(16),
    apllr_init_latitude double precision,
    apllr_init_longitude double precision,
    apllr_deepest integer,
    apllr_sst_time character varying(32),
    apllr_sst_depth integer,
    apllr_sst_temp double precision,
    apllr_type character varying(16),
    apllr_delta integer,
    apllr_min_depth integer,
    apllr_max_depth integer,
    apllr_atten_shallow double precision,
    apllr_atten_deep double precision,
    apllr_travel_metric integer,
    apllr_found_previous integer,
    apllr_k integer,
    apllr_ll integer[],
    apllr_depth integer[]
);

CREATE TABLE atn_pat_locations_raw (
    aplr_deployment_id character varying(16),
    aplr_ptt integer,
    aplr_instrument character varying(8),
    aplr_date character varying(32),
    aplr_type character varying(8),
    aplr_quality character varying(8),
    aplr_latitude double precision,
    aplr_longitude double precision,
    aplr_error_radius double precision,
    aplr_error_semi_major_axis double precision,
    aplr_error_semi_minor_axis double precision,
    aplr_error_ellipse_orient double precision,
    aplr_offset double precision,
    aplr_offset_orient double precision,
    aplr_gpe_msd double precision,
    aplr_gpe_u double precision,
    aplr_comment text
);

CREATE TABLE atn_pat_minmax_depth_raw (
    apmdr_deployment_id character varying(16),
    apmdr_ptt integer,
    apmdr_depth_sensor double precision,
    apmdr_instrument character varying(8),
    apmdr_date character varying(32),
    apmdr_location_quality integer,
    apmdr_latitude double precision,
    apmdr_longitude double precision,
    apmdr_min_depth integer,
    apmdr_min_accuracy double precision,
    apmdr_min_source character varying(16),
    apmdr_max_depth integer,
    apmdr_max_accuracy double precision,
    apmdr_max_source character varying(16)
);

CREATE TABLE atn_pat_mix_layer_raw (
    apmlr_deployment_id character varying(16),
    apmlr_ptt integer,
    apmlr_depth_sensor double precision,
    apmlr_source character varying(8),
    apmlr_instrument character varying(8),
    apmlr_date character varying(32),
    apmlr_hours integer,
    apmlr_location_quality integer,
    apmlr_latitude double precision,
    apmlr_longitude double precision,
    apmlr_pc_ml_time double precision,
    apmlr_mlt_ave double precision,
    apmlr_mlt_min double precision,
    apmlr_mlt_max double precision,
    apmlr_mlt_extreme double precision,
    apmlr_sst_ave double precision,
    apmlr_sst_min double precision,
    apmlr_sst_max double precision,
    apmlr_temp_min double precision,
    apmlr_depth_min double precision,
    apmlr_depth_max double precision
);

CREATE TABLE atn_pat_pdt_raw (
    apr_deployment_id character varying(16),
    apr_ptt integer,
    apr_depth_sensor double precision,
    apr_source character varying(8),
    apr_instrument character varying(8),
    apr_date character varying(32),
    apr_time_offset integer,
    apr_count integer,
    apr_location_quality integer,
    apr_latitude double precision,
    apr_longitude double precision,
    apr_bad_therm double precision,
    apr_numb_bins integer,
    apr_partial double precision,
    apr_depth double precision[],
    apr_min_temp double precision[],
    apr_max_temp double precision[],
    apr_x double precision[],
    apr_discont double precision[]
);

CREATE TABLE atn_pat_sst_raw (
    apr_deployment_id character varying(16),
    apr_ptt integer,
    apr_depth_sensor double precision,
    apr_instrument character varying(8),
    apr_date character varying(32),
    apr_location_quality integer,
    apr_latitude double precision,
    apr_longitude double precision,
    apr_depth double precision,
    apr_temperature double precision,
    apr_source character varying(8)
);

CREATE TABLE atn_pat_summary_raw (
    apsr_deployment_id character varying(16),
    apsr_ptt integer,
    apsr_instrument character varying(8),
    apsr_sw double precision,
    apsr_perc_decoded double precision,
    apsr_passes integer,
    apsr_perc_argos_location double precision,
    apsr_message_per_pass integer,
    apsr_ds double precision,
    apsr_di double precision,
    apsr_min_power double precision,
    apsr_avg_power double precision,
    apsr_max_power double precision,
    apsr_min_interval character varying(32),
    apsr_earliest_xmit_date character varying(32),
    apsr_latest_xmit_date character varying(32),
    apsr_xmit_days integer,
    apsr_earliest_data_date character varying(32),
    apsr_latest_data_date character varying(32),
    apsr_data_days integer,
    apsr_release_date character varying(32),
    apsr_release_type character varying(16),
    apsr_deploy_date character varying(32)
);

CREATE TABLE atn_pat_tag_raw (
    eventid bigint,
    date timestamp without time zone,
    depth_sensor_resolution double precision,
    temperature_sensor_resolution double precision,
    gps_snapshot_date double precision,
    gps_snapshot_latitude double precision,
    gps_snapshot_longitude double precision,
    gps_snapshot_residual double precision,
    gps_snapshot_time_error double precision,
    gps_snapshot_satellites double precision,
    gps_snapshot_bad_satellites double precision,
    bin_depth double precision[],
    bin_temperature double precision[],
    bin_discontinuity boolean[]
);

CREATE TABLE atn_splash10_fast_gps_raw (
    fgps_name character varying(32) NOT NULL,
    fgps_day timestamp without time zone,
    fgps_time character varying(16),
    fgps_count integer DEFAULT 0,
    fgps_time_offset double precision DEFAULT 0.0,
    fgps_location_number integer,
    fgps_failures integer DEFAULT 0,
    fgps_hauled_out_date integer,
    fgps_satellites integer DEFAULT 0,
    fgps_init_latitude double precision,
    fgps_init_longitude double precision,
    fgps_init_time character varying(32),
    fgps_init_type character varying(8),
    fgps_latitude double precision,
    fgps_longitude double precision,
    fgps_height double precision,
    fgps_bad_satellites integer DEFAULT 0,
    fgps_residual double precision,
    fgps_time_error double precision,
    fgps_twic_power double precision,
    fgps_fastloc_power double precision,
    fgps_noise double precision,
    fgps_range_bits double precision,
    fgps_id integer[],
    fgps_range integer[],
    fgps_signal integer[],
    fgps_doppler integer[],
    fgps_cnr integer[]
);

CREATE TABLE atn_splash10_locations_raw (
    flocs_deployment_id character varying(32) NOT NULL,
    flocs_ptt integer,
    flocs_instrument character varying(16),
    flocs_date character varying(32),
    flocs_type character varying(16),
    flocs_quality character varying(8),
    flocs_latitude double precision,
    flocs_longitude double precision,
    flocs_error_radius double precision,
    flocs_error_semi_major_axis double precision,
    flocs_error_semi_minor_axis double precision,
    flocs_error_ellipse_orient double precision,
    flocs_offset double precision,
    flocs_offset_orient double precision,
    flocs_gpe_msd double precision,
    flocs_gpe_u double precision,
    flocs_comment text
);

CREATE TABLE atn_spot5_tag_raw (
    deployment_id character varying(32),
    platform_id character varying(16),
    program_number integer,
    latitude double precision,
    longitude double precision,
    location_quality character varying(8),
    location_date timestamp without time zone,
    location_type character varying(32),
    altitude double precision,
    pass_number integer,
    satellite character varying(8),
    mote_id character varying(16),
    frequency integer,
    message_date timestamp without time zone,
    comp integer,
    message integer,
    greater_120_db integer,
    best_level integer,
    delta_frequency integer,
    longitude_1 double precision,
    latitude_sol_1 double precision,
    longitude_2 double precision,
    latitude_sol_2 double precision,
    location_index integer,
    nopc integer,
    error_radius integer,
    semi_major_axis integer,
    semi_minor_axis integer,
    ellipse_orientation integer,
    gdop integer,
    sensor integer[]
);

CREATE TABLE dbtable (
    gid integer NOT NULL,
    long double precision,
    lat double precision,
    date character varying(10),
    hour character varying(2),
    min character varying(2),
    sec character varying(2),
    lc character varying(1),
    geom public.geometry
);

CREATE TABLE device (
    id bigint NOT NULL,
    device_name character varying(255) NOT NULL,
    project_id bigint NOT NULL,
    device_type character varying(255) NOT NULL,
    manufacturer character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    serial_number character varying(255) NOT NULL,
    ptt character varying(255),
    wmo_number character varying(255),
    infourl character varying(255) NOT NULL,
    invoice_number character varying(255),
    invoice_date timestamp with time zone,
    shipping_date timestamp with time zone,
);

CREATE TABLE device_deployment_recovery (
    id bigint NOT NULL,
    device_id bigint NOT NULL,
    animal_id bigint,
    installation_station_id bigint,
    initialisation_datetime timestamp with time zone,
    deployer_id bigint NOT NULL,
    deployment_locality character varying(255) NOT NULL,
    deployment_location public.geometry NOT NULL,
    deployment_datetime timestamp with time zone NOT NULL,
    deployment_depth real,
    deployment_position character varying(255),
    deployment_method character varying(255) NOT NULL,
    deployment_comments character varying(255),
    deployment_bottom_depthm real,
    deployment_sst real,
    recoverer_id bigint,
    recovery_locality character varying(255) NOT NULL,
    recovery_location public.geometry NOT NULL,
    recovery_datetime timestamp with time zone NOT NULL,
    popup_location public.geometry,
    popup_datetime timestamp with time zone,
    device_recovery_status character varying(255),
    embargo_datetime timestamp with time zone
);

CREATE TABLE device_specifications (
    id bigint NOT NULL,
    device_id bigint NOT NULL,
    manufacturing_date timestamp with time zone NOT NULL,
    firmware_name character varying(255),
    firmware_version character varying(255),
    software_name character varying(255),
    software_version character varying(255),
    software_specifications text NOT NULL,
    software_modified_date timestamp with time zone NOT NULL,
    programmed_popoff_date timestamp with time zone,
    pressure boolean NOT NULL,
    temperature boolean NOT NULL,
    light boolean NOT NULL,
    conductivity boolean NOT NULL,
    fluorescence boolean NOT NULL,
    accelerometer_3d boolean NOT NULL,
    magnetometer_3d boolean NOT NULL,
    stomach_temperature boolean NOT NULL,
    gps_location boolean NOT NULL,
    argos_location boolean NOT NULL,
    geolocation boolean NOT NULL,
    argos_data_processing character varying(255),
    geolocation_data_processing character varying(255),
    acoustic_transmitter_type character varying(255),
    code_map character varying(255),
    ping_code integer,
    intercept real,
    slope real,
    unit character varying(255),
);

CREATE TABLE gls_locations (
    id integer NOT NULL,
    file_id bigint NOT NULL,
    device_name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    "decimalLatitude" double precision NOT NULL,
    "decimalLongitude" double precision NOT NULL,
    duplicate boolean,
    CONSTRAINT gls_locations_latitude CHECK ((("decimalLatitude" < (90)::double precision) AND ("decimalLatitude" > ('-90'::integer)::double precision))),
    CONSTRAINT gls_locations_longitude CHECK ((("decimalLongitude" < (180)::double precision) AND ("decimalLongitude" > ('-180'::integer)::double precision))),
    CONSTRAINT gls_locations_time CHECK (("timestamp" < now()))
);

CREATE TABLE gps_locations (
    id integer NOT NULL,
    file_id bigint NOT NULL,
    device_name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    "decimalLatitude" double precision NOT NULL,
    "decimalLongitude" double precision NOT NULL,
    nsats_detected double precision,
    nsats_transmitted double precision,
    pseudoranges character varying(255),
    max_csn double precision,
    residual double precision,
    timeshift double precision,
    duplicate boolean,
);

CREATE TABLE installation_station (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    installation_name character varying(255) NOT NULL,
    station_name character varying(255) NOT NULL,
    station_location public.geometry NOT NULL
);

CREATE TABLE project (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    summary character varying(255) NOT NULL,
    citation character varying(255) NOT NULL,
    infourl character varying(255),
    publications character varying(255),
    license character varying(255),
    distribution_statement character varying(255),
    date_modified timestamp with time zone NOT NULL,
    location public.geometry NOT NULL,
    timestamp_start timestamp with time zone NOT NULL,
    timestamp_end timestamp with time zone NOT NULL
);

CREATE TABLE project_role (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    project_id bigint NOT NULL,
    role_type character varying NOT NULL,
);

CREATE TABLE species (
    id bigint NOT NULL,
    "worms_aphiaID" character varying NOT NULL,
    kingdom character varying(255) NOT NULL,
    phylum character varying(255) NOT NULL,
    class_name character varying(255) NOT NULL,
    order_name character varying(255) NOT NULL,
    family character varying(255) NOT NULL,
    genus character varying(255) NOT NULL,
    subgenus character varying(255),
    "specificEpithet" character varying(255) NOT NULL,
    "infraspecificEpithet" character varying(255) NOT NULL,
    "scientificName" character varying(255) NOT NULL,
    "acceptedNameUsage" character varying(255) NOT NULL,
    "vernacularName" character varying(255) NOT NULL,
    "scientificNameAuthorship" character varying(255) NOT NULL,
    date_modified timestamp with time zone NOT NULL
);

CREATE TABLE species_atn (
    id bigint NOT NULL
);

CREATE TABLE species_atn_worms_adb (
    id integer,
    locality character varying(255),
    location_id character varying(255),
    higher_geograhpy character varying(255),
    higher_geography_id character varying(255),
    record_status character varying(255),
    type_status character varying(255),
    establishment_means character varying(255),
    decimal_latitude double precision DEFAULT 0.0,
    decimal_longitude double precision DEFAULT 0.0,
    quality_status character varying(255)
);

CREATE TABLE species_atn_worms_arb (
    id integer,
    aphia_id integer,
    url character varying(255),
    scientific_name character varying(255),
    authority character varying(255),
    rank character varying(255),
    status character varying(255),
    unaccept_reason character varying(255),
    valid_aphia_id integer,
    valid_name character varying(255),
    valid_authority character varying(255),
    kingdom character varying(255),
    phylum character varying(255),
    class character varying(255),
    order_name character varying(255),
    family character varying(255),
    genus character varying(255),
    citation character varying(1024),
    ls_id character varying(255),
    is_marine boolean,
    is_freshwater boolean,
    is_terrestrial boolean,
    is_extinct boolean,
    match_type character varying(255),
    modified character varying(255)
);

CREATE TABLE users (
    id bigint NOT NULL,
    organisation_name character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    email_address character varying(255) NOT NULL,
    department character varying(255) NOT NULL,
    phone_number character varying(20) NOT NULL,
    postal_address character varying(255) NOT NULL
);

CREATE TABLE wc_argos_locations (
    wcal_id character varying(64) NOT NULL,
    wcal_date integer NOT NULL,
    wcal_longitude double precision NOT NULL,
    wcal_loc_class character varying(4) NOT NULL,
    wcal_error_radius integer NOT NULL,
    wcal_error_semi_major_axis integer NOT NULL,
    wcal_error_semi_minor_axis integer NOT NULL,
    wcal_ellipse_orient integer NOT NULL
);

CREATE TABLE wc_status (
    wcs_id character varying(64) NOT NULL,
    wcs_owner_email character varying(64) NOT NULL,
    wcs_status character varying(16) NOT NULL,
    wcs_last_updated_date integer NOT NULL,
    wcs_tag_type character varying(16) NOT NULL,
    wcs_serial_number character varying(16) NOT NULL,
    wcs_program_number character varying(16) NOT NULL,
    wcs_ptt_decimal integer NOT NULL,
    wcs_first_uplink_date integer NOT NULL,
    wcs_last_uplink_date integer NOT NULL,
    wcs_last_latitude double precision NOT NULL,
    wcs_last_longitude double precision NOT NULL,
    wcs_last_location_date integer NOT NULL,
    wcs_source character varying(16) NOT NULL,
    wcs_two_digit_year character varying(2) NOT NULL
);

