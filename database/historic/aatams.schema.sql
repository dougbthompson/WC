
SET search_path = aatams, pg_catalog;

CREATE TABLE address (
    id bigint NOT NULL,
    version bigint NOT NULL,
    country character varying(255) NOT NULL,
    postcode character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    street_address character varying(255) NOT NULL,
    suburb_town character varying(255) NOT NULL
);

CREATE TABLE animal (
    id bigint NOT NULL,
    version bigint NOT NULL,
    classification character varying(255) NOT NULL,
    sex_id bigint NOT NULL
);

CREATE TABLE animal_measurement (
    id bigint NOT NULL,
    version bigint NOT NULL,
    comments character varying(255) NOT NULL,
    estimate boolean NOT NULL,
    type_id bigint NOT NULL,
    unit_id bigint NOT NULL,
    value real NOT NULL
);

CREATE TABLE animal_measurement_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);

CREATE TABLE animal_release (
    id bigint NOT NULL,
    version bigint NOT NULL,
    animal_id bigint NOT NULL,
    capture_date_time timestamp without time zone NOT NULL,
    capture_locality character varying(255) NOT NULL,
    capture_location bytea NOT NULL,
    comments character varying(255) NOT NULL,
    project_id bigint NOT NULL,
    release_date_time timestamp without time zone NOT NULL,
    release_locality character varying(255) NOT NULL,
    release_location bytea NOT NULL
);

CREATE TABLE animal_release_animal_measurement (
    animal_release_measurements_id bigint,
    animal_measurement_id bigint
);

CREATE TABLE detection (
    id bigint NOT NULL,
    version bigint NOT NULL,
    location bytea,
    receiver_id bigint NOT NULL,
    station_name character varying(255),
    "timestamp" timestamp without time zone NOT NULL,
    transmitter_name character varying(255),
    transmitter_serial_number character varying(255),
    class character varying(255) NOT NULL,
    sensor_unit character varying(255),
    uncalibrated_value real
);

CREATE TABLE detection_tag (
    detection_tags_id bigint,
    tag_id bigint
);

CREATE TABLE device (
    id bigint NOT NULL,
    version bigint NOT NULL,
    code_name character varying(255) NOT NULL,
    embargo_date timestamp without time zone,
    model_id bigint NOT NULL,
    project_id bigint NOT NULL,
    serial_number character varying(255) NOT NULL,
    status_id bigint NOT NULL,
    class character varying(255) NOT NULL,
    code_map character varying(255),
    ping_code integer
);

CREATE TABLE device_manufacturer (
    id bigint NOT NULL,
    version bigint NOT NULL,
    manufacturer_name character varying(255) NOT NULL
);

CREATE TABLE device_model (
    id bigint NOT NULL,
    version bigint NOT NULL,
    manufacturer_id bigint NOT NULL,
    model_name character varying(255) NOT NULL
);

CREATE TABLE device_status (
    id bigint NOT NULL,
    version bigint NOT NULL,
    status character varying(255) NOT NULL
);

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE installation (
    id bigint NOT NULL,
    version bigint NOT NULL,
    configuration_id bigint NOT NULL,
    lat_offset real NOT NULL,
    lon_offset real NOT NULL,
    name character varying(255) NOT NULL,
    project_id bigint NOT NULL
);

CREATE TABLE installation_configuration (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);

CREATE TABLE installation_station (
    id bigint NOT NULL,
    version bigint NOT NULL,
    curtain_position integer NOT NULL,
    installation_id bigint NOT NULL,
    location public.geometry NOT NULL,
    name character varying(255) NOT NULL
);

CREATE TABLE installation_station_receiver (
    installation_station_receivers_id bigint,
    receiver_id bigint
);

CREATE TABLE measurement_unit (
    id bigint NOT NULL,
    version bigint NOT NULL,
    unit character varying(255) NOT NULL
);

CREATE TABLE mooring_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);

CREATE TABLE organisation (
    id bigint NOT NULL,
    version bigint NOT NULL,
    fax_number character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL,
    postal_address_id bigint,
    status character varying(255) NOT NULL,
    street_address_id bigint NOT NULL
);

CREATE TABLE organisation_person (
    id bigint NOT NULL,
    version bigint NOT NULL,
    organisation_id bigint NOT NULL,
    person_id bigint NOT NULL
);

CREATE TABLE organisation_project (
    id bigint NOT NULL,
    version bigint NOT NULL,
    organisation_id bigint NOT NULL,
    project_id bigint NOT NULL
);

CREATE TABLE person (
    id bigint NOT NULL,
    version bigint NOT NULL,
    email_address character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL
);

CREATE TABLE person_system_role (
    person_system_roles_id bigint,
    system_role_id bigint
);

CREATE TABLE processed_upload_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    err_msg character varying(255),
    status character varying(255) NOT NULL,
    u_file_id bigint NOT NULL
);

CREATE TABLE project (
    id bigint NOT NULL,
    version bigint NOT NULL,
    description character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    principal_investigator_id bigint
);

CREATE TABLE project_role (
    id bigint NOT NULL,
    version bigint NOT NULL,
    person_id bigint NOT NULL,
    project_id bigint NOT NULL,
    role_type_id bigint NOT NULL
);

CREATE TABLE project_role_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    display_name character varying(255) NOT NULL
);

CREATE TABLE receiver_deployment (
    id bigint NOT NULL,
    version bigint NOT NULL,
    acoustic_releaseid character varying(255) NOT NULL,
    bottom_depthm real NOT NULL,
    comments character varying(255) NOT NULL,
    deployment_date timestamp without time zone NOT NULL,
    deployment_number integer NOT NULL,
    depth_below_surfacem real NOT NULL,
    location bytea NOT NULL,
    mooring_type_id bigint NOT NULL,
    receiver_id bigint NOT NULL,
    receiver_orientation character varying(255) NOT NULL,
    recovery_date timestamp without time zone NOT NULL,
    station_id bigint NOT NULL
);

CREATE TABLE receiver_download (
    id bigint NOT NULL,
    version bigint NOT NULL,
    battery_days integer NOT NULL,
    battery_voltage real NOT NULL,
    clock_drift real NOT NULL,
    comments character varying(255) NOT NULL,
    detection_count integer NOT NULL,
    download_date timestamp without time zone NOT NULL,
    downloader_id bigint NOT NULL,
    ping_count integer NOT NULL
);

CREATE TABLE receiver_download_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    path bytea NOT NULL,
    type character varying(255) NOT NULL
);

CREATE TABLE receiver_download_receiver_download_file (
    receiver_download_download_files_id bigint,
    receiver_download_file_id bigint
);

CREATE TABLE receiver_recovery (
    id bigint NOT NULL,
    version bigint NOT NULL,
    battery_life real,
    battery_voltage real,
    deployment_id bigint NOT NULL,
    download_id bigint,
    location bytea NOT NULL,
    recovery_date timestamp without time zone NOT NULL,
    status_id bigint NOT NULL
);

CREATE TABLE sensor (
    id bigint NOT NULL,
    version bigint NOT NULL,
    code_map character varying(255) NOT NULL,
    intercept integer NOT NULL,
    ping_code integer NOT NULL,
    slope integer NOT NULL,
    tag_id bigint NOT NULL,
    transmitter_type_id bigint NOT NULL,
    unit character varying(255) NOT NULL
);

CREATE TABLE sensor_detection_sensor (
    sensor_detection_sensors_id bigint,
    sensor_id bigint
);

CREATE TABLE sex (
    id bigint NOT NULL,
    version bigint NOT NULL,
    sex character varying(255) NOT NULL
);

CREATE TABLE surgery (
    id bigint NOT NULL,
    version bigint NOT NULL,
    comments character varying(255) NOT NULL,
    release_id bigint NOT NULL,
    surgeon_id bigint NOT NULL,
    sutures boolean NOT NULL,
    tag_id bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    treatment_type_id bigint NOT NULL,
    type_id bigint NOT NULL
);

CREATE TABLE surgery_treatment_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);

CREATE TABLE surgery_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);

CREATE TABLE system_role (
    id bigint NOT NULL,
    version bigint NOT NULL,
    role_type_id bigint NOT NULL
);

CREATE TABLE system_role_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    display_name character varying(255) NOT NULL
);

CREATE TABLE transmitter_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    transmitter_type_name character varying(255) NOT NULL
);

CREATE TABLE ufile (
    id bigint NOT NULL,
    version bigint NOT NULL,
    date_uploaded timestamp without time zone NOT NULL,
    downloads integer NOT NULL,
    extension character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    path character varying(255) NOT NULL,
    size bigint NOT NULL
);

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);

ALTER TABLE ONLY animal_measurement
    ADD CONSTRAINT animal_measurement_pkey PRIMARY KEY (id);

ALTER TABLE ONLY animal_measurement_type
    ADD CONSTRAINT animal_measurement_type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY animal_measurement_type
    ADD CONSTRAINT animal_measurement_type_type_key UNIQUE (type);

ALTER TABLE ONLY animal
    ADD CONSTRAINT animal_pkey PRIMARY KEY (id);

ALTER TABLE ONLY animal_release
    ADD CONSTRAINT animal_release_pkey PRIMARY KEY (id);

ALTER TABLE ONLY detection
    ADD CONSTRAINT detection_pkey PRIMARY KEY (id);

ALTER TABLE ONLY device_manufacturer
    ADD CONSTRAINT device_manufacturer_manufacturer_name_key UNIQUE (manufacturer_name);

ALTER TABLE ONLY device_manufacturer
    ADD CONSTRAINT device_manufacturer_pkey PRIMARY KEY (id);

ALTER TABLE ONLY device_model
    ADD CONSTRAINT device_model_model_name_key UNIQUE (model_name);

ALTER TABLE ONLY device_model
    ADD CONSTRAINT device_model_pkey PRIMARY KEY (id);

ALTER TABLE ONLY device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id);

ALTER TABLE ONLY device_status
    ADD CONSTRAINT device_status_pkey PRIMARY KEY (id);

ALTER TABLE ONLY device_status
    ADD CONSTRAINT device_status_status_key UNIQUE (status);

ALTER TABLE ONLY installation_configuration
    ADD CONSTRAINT installation_configuration_pkey PRIMARY KEY (id);

ALTER TABLE ONLY installation_configuration
    ADD CONSTRAINT installation_configuration_type_key UNIQUE (type);

ALTER TABLE ONLY installation
    ADD CONSTRAINT installation_pkey PRIMARY KEY (id);

ALTER TABLE ONLY installation_station
    ADD CONSTRAINT installation_station_pkey PRIMARY KEY (id);

ALTER TABLE ONLY measurement_unit
    ADD CONSTRAINT measurement_unit_pkey PRIMARY KEY (id);

ALTER TABLE ONLY measurement_unit
    ADD CONSTRAINT measurement_unit_unit_key UNIQUE (unit);

ALTER TABLE ONLY mooring_type
    ADD CONSTRAINT mooring_type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY mooring_type
    ADD CONSTRAINT mooring_type_type_key UNIQUE (type);

ALTER TABLE ONLY organisation
    ADD CONSTRAINT organisation_name_key UNIQUE (name);

ALTER TABLE ONLY organisation_person
    ADD CONSTRAINT organisation_person_pkey PRIMARY KEY (id);

ALTER TABLE ONLY organisation
    ADD CONSTRAINT organisation_pkey PRIMARY KEY (id);

ALTER TABLE ONLY organisation_project
    ADD CONSTRAINT organisation_project_pkey PRIMARY KEY (id);

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);

ALTER TABLE ONLY processed_upload_file
    ADD CONSTRAINT processed_upload_file_pkey PRIMARY KEY (id);

ALTER TABLE ONLY project
    ADD CONSTRAINT project_name_key UNIQUE (name);

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);

ALTER TABLE ONLY project_role
    ADD CONSTRAINT project_role_pkey PRIMARY KEY (id);

ALTER TABLE ONLY project_role_type
    ADD CONSTRAINT project_role_type_display_name_key UNIQUE (display_name);

ALTER TABLE ONLY project_role_type
    ADD CONSTRAINT project_role_type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY receiver_deployment
    ADD CONSTRAINT receiver_deployment_pkey PRIMARY KEY (id);

ALTER TABLE ONLY receiver_download_file
    ADD CONSTRAINT receiver_download_file_pkey PRIMARY KEY (id);

ALTER TABLE ONLY receiver_download
    ADD CONSTRAINT receiver_download_pkey PRIMARY KEY (id);

ALTER TABLE ONLY receiver_recovery
    ADD CONSTRAINT receiver_recovery_pkey PRIMARY KEY (id);

ALTER TABLE ONLY sensor
    ADD CONSTRAINT sensor_pkey PRIMARY KEY (id);

ALTER TABLE ONLY sex
    ADD CONSTRAINT sex_pkey PRIMARY KEY (id);

ALTER TABLE ONLY sex
    ADD CONSTRAINT sex_sex_key UNIQUE (sex);

ALTER TABLE ONLY surgery
    ADD CONSTRAINT surgery_pkey PRIMARY KEY (id);

ALTER TABLE ONLY surgery_treatment_type
    ADD CONSTRAINT surgery_treatment_type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY surgery_treatment_type
    ADD CONSTRAINT surgery_treatment_type_type_key UNIQUE (type);

ALTER TABLE ONLY surgery_type
    ADD CONSTRAINT surgery_type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY surgery_type
    ADD CONSTRAINT surgery_type_type_key UNIQUE (type);

ALTER TABLE ONLY system_role
    ADD CONSTRAINT system_role_pkey PRIMARY KEY (id);

ALTER TABLE ONLY system_role_type
    ADD CONSTRAINT system_role_type_display_name_key UNIQUE (display_name);

ALTER TABLE ONLY system_role_type
    ADD CONSTRAINT system_role_type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY transmitter_type
    ADD CONSTRAINT transmitter_type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY transmitter_type
    ADD CONSTRAINT transmitter_type_transmitter_type_name_key UNIQUE (transmitter_type_name);

ALTER TABLE ONLY ufile
    ADD CONSTRAINT ufile_pkey PRIMARY KEY (id);

ALTER TABLE ONLY installation_station_receiver
    ADD CONSTRAINT fk2f7233ffd6ed9307 FOREIGN KEY (installation_station_receivers_id) REFERENCES installation_station(id);

ALTER TABLE ONLY installation_station_receiver
    ADD CONSTRAINT fk2f7233fff0bb6d33 FOREIGN KEY (receiver_id) REFERENCES device(id);

ALTER TABLE ONLY project_role
    ADD CONSTRAINT fk37fff5dc51218487 FOREIGN KEY (role_type_id) REFERENCES project_role_type(id);

ALTER TABLE ONLY project_role
    ADD CONSTRAINT fk37fff5dcbf505a21 FOREIGN KEY (project_id) REFERENCES project(id);

ALTER TABLE ONLY project_role
    ADD CONSTRAINT fk37fff5dce985cdb3 FOREIGN KEY (person_id) REFERENCES person(id);

ALTER TABLE ONLY organisation
    ADD CONSTRAINT fk3a5300dabc5dddfd FOREIGN KEY (street_address_id) REFERENCES address(id);

ALTER TABLE ONLY organisation
    ADD CONSTRAINT fk3a5300dac7e435 FOREIGN KEY (postal_address_id) REFERENCES address(id);

ALTER TABLE ONLY installation
    ADD CONSTRAINT fk796d5e3a18d65d27 FOREIGN KEY (configuration_id) REFERENCES installation_configuration(id);

ALTER TABLE ONLY installation
    ADD CONSTRAINT fk796d5e3abf505a21 FOREIGN KEY (project_id) REFERENCES project(id);

ALTER TABLE ONLY receiver_download
    ADD CONSTRAINT fk79accd8b8e509d3 FOREIGN KEY (downloader_id) REFERENCES person(id);

ALTER TABLE ONLY sensor_detection_sensor
    ADD CONSTRAINT fk8165509916b1b072 FOREIGN KEY (sensor_detection_sensors_id) REFERENCES detection(id);

ALTER TABLE ONLY sensor_detection_sensor
    ADD CONSTRAINT fk81655099d7d8b793 FOREIGN KEY (sensor_id) REFERENCES sensor(id);

ALTER TABLE ONLY receiver_recovery
    ADD CONSTRAINT fk82de83e56b73e7c9 FOREIGN KEY (status_id) REFERENCES device_status(id);

ALTER TABLE ONLY receiver_recovery
    ADD CONSTRAINT fk82de83e579a96182 FOREIGN KEY (deployment_id) REFERENCES receiver_deployment(id);

ALTER TABLE ONLY receiver_recovery
    ADD CONSTRAINT fk82de83e593fa40a2 FOREIGN KEY (download_id) REFERENCES receiver_download(id);

ALTER TABLE ONLY receiver_deployment
    ADD CONSTRAINT fk862aeb1531eebdc FOREIGN KEY (mooring_type_id) REFERENCES mooring_type(id);

ALTER TABLE ONLY receiver_deployment
    ADD CONSTRAINT fk862aeb15cdaf3227 FOREIGN KEY (station_id) REFERENCES installation_station(id);

ALTER TABLE ONLY receiver_deployment
    ADD CONSTRAINT fk862aeb15f0bb6d33 FOREIGN KEY (receiver_id) REFERENCES device(id);

ALTER TABLE ONLY animal_release
    ADD CONSTRAINT fk88d6a0c4bf505a21 FOREIGN KEY (project_id) REFERENCES project(id);

ALTER TABLE ONLY animal_release
    ADD CONSTRAINT fk88d6a0c4e0347853 FOREIGN KEY (animal_id) REFERENCES animal(id);

ALTER TABLE ONLY person_system_role
    ADD CONSTRAINT fk8e3f6e9c244fac71 FOREIGN KEY (person_system_roles_id) REFERENCES person(id);

ALTER TABLE ONLY person_system_role
    ADD CONSTRAINT fk8e3f6e9cbba8aa52 FOREIGN KEY (system_role_id) REFERENCES system_role(id);

ALTER TABLE ONLY animal_measurement
    ADD CONSTRAINT fk8eb3adf914018681 FOREIGN KEY (type_id) REFERENCES animal_measurement_type(id);

ALTER TABLE ONLY animal_measurement
    ADD CONSTRAINT fk8eb3adf9e6ea591d FOREIGN KEY (unit_id) REFERENCES measurement_unit(id);

ALTER TABLE ONLY installation_station
    ADD CONSTRAINT fk902c2c2f35e870d3 FOREIGN KEY (installation_id) REFERENCES installation(id);

ALTER TABLE ONLY detection
    ADD CONSTRAINT fk90e7ca85f0bb6d33 FOREIGN KEY (receiver_id) REFERENCES device(id);

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f54f2dd3af FOREIGN KEY (treatment_type_id) REFERENCES surgery_treatment_type(id);

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f56d95e296 FOREIGN KEY (type_id) REFERENCES surgery_type(id);

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f57480ac7b FOREIGN KEY (surgeon_id) REFERENCES person(id);

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f5b5c10085 FOREIGN KEY (release_id) REFERENCES animal_release(id);

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f5ceab1a01 FOREIGN KEY (tag_id) REFERENCES device(id);

ALTER TABLE ONLY animal_release_animal_measurement
    ADD CONSTRAINT fka3b75543290ccda FOREIGN KEY (animal_release_measurements_id) REFERENCES animal_release(id);

ALTER TABLE ONLY animal_release_animal_measurement
    ADD CONSTRAINT fka3b7554af520388 FOREIGN KEY (animal_measurement_id) REFERENCES animal_measurement(id);

ALTER TABLE ONLY system_role
    ADD CONSTRAINT fka47ecc86d06730af FOREIGN KEY (role_type_id) REFERENCES system_role_type(id);

ALTER TABLE ONLY animal
    ADD CONSTRAINT fkabc58dfccd365681 FOREIGN KEY (sex_id) REFERENCES sex(id);

ALTER TABLE ONLY receiver_download_receiver_download_file
    ADD CONSTRAINT fkadfe47ca50da4c63 FOREIGN KEY (receiver_download_file_id) REFERENCES receiver_download_file(id);

ALTER TABLE ONLY receiver_download_receiver_download_file
    ADD CONSTRAINT fkadfe47cafa360683 FOREIGN KEY (receiver_download_download_files_id) REFERENCES receiver_download(id);

ALTER TABLE ONLY device
    ADD CONSTRAINT fkb06b1e561c043beb FOREIGN KEY (model_id) REFERENCES device_model(id);

ALTER TABLE ONLY device
    ADD CONSTRAINT fkb06b1e566b73e7c9 FOREIGN KEY (status_id) REFERENCES device_status(id);

ALTER TABLE ONLY device
    ADD CONSTRAINT fkb06b1e56bf505a21 FOREIGN KEY (project_id) REFERENCES project(id);

ALTER TABLE ONLY processed_upload_file
    ADD CONSTRAINT fkc1735d892224770f FOREIGN KEY (u_file_id) REFERENCES ufile(id);

ALTER TABLE ONLY sensor
    ADD CONSTRAINT fkca0053ba4b0c3bc4 FOREIGN KEY (transmitter_type_id) REFERENCES transmitter_type(id);

ALTER TABLE ONLY sensor
    ADD CONSTRAINT fkca0053baceab1a01 FOREIGN KEY (tag_id) REFERENCES device(id);

ALTER TABLE ONLY device_model
    ADD CONSTRAINT fkdcc4e40025f67029 FOREIGN KEY (manufacturer_id) REFERENCES device_manufacturer(id);

ALTER TABLE ONLY detection_tag
    ADD CONSTRAINT fkeb71eee0ac39c713 FOREIGN KEY (detection_tags_id) REFERENCES detection(id);

ALTER TABLE ONLY detection_tag
    ADD CONSTRAINT fkeb71eee0ceab1a01 FOREIGN KEY (tag_id) REFERENCES device(id);

ALTER TABLE ONLY project
    ADD CONSTRAINT fked904b19ab94ee16 FOREIGN KEY (principal_investigator_id) REFERENCES project_role(id);

ALTER TABLE ONLY organisation_person
    ADD CONSTRAINT fkee60ce5a99b5ecd3 FOREIGN KEY (organisation_id) REFERENCES organisation(id);

ALTER TABLE ONLY organisation_person
    ADD CONSTRAINT fkee60ce5ae985cdb3 FOREIGN KEY (person_id) REFERENCES person(id);

ALTER TABLE ONLY organisation_project
    ADD CONSTRAINT fkf3b978b499b5ecd3 FOREIGN KEY (organisation_id) REFERENCES organisation(id);

ALTER TABLE ONLY organisation_project
    ADD CONSTRAINT fkf3b978b4bf505a21 FOREIGN KEY (project_id) REFERENCES project(id);

