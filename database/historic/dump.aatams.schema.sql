--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: aatams; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA aatams;


ALTER SCHEMA aatams OWNER TO postgres;

SET search_path = aatams, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE address (
    id bigint NOT NULL,
    version bigint NOT NULL,
    country character varying(255) NOT NULL,
    postcode character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    street_address character varying(255) NOT NULL,
    suburb_town character varying(255) NOT NULL
);


ALTER TABLE address OWNER TO postgres;

--
-- Name: animal; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE animal (
    id bigint NOT NULL,
    version bigint NOT NULL,
    classification character varying(255) NOT NULL,
    sex_id bigint NOT NULL
);


ALTER TABLE animal OWNER TO postgres;

--
-- Name: animal_measurement; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE animal_measurement (
    id bigint NOT NULL,
    version bigint NOT NULL,
    comments character varying(255) NOT NULL,
    estimate boolean NOT NULL,
    type_id bigint NOT NULL,
    unit_id bigint NOT NULL,
    value real NOT NULL
);


ALTER TABLE animal_measurement OWNER TO postgres;

--
-- Name: animal_measurement_type; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE animal_measurement_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE animal_measurement_type OWNER TO postgres;

--
-- Name: animal_release; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE animal_release OWNER TO postgres;

--
-- Name: animal_release_animal_measurement; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE animal_release_animal_measurement (
    animal_release_measurements_id bigint,
    animal_measurement_id bigint
);


ALTER TABLE animal_release_animal_measurement OWNER TO postgres;

--
-- Name: detection; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE detection OWNER TO postgres;

--
-- Name: detection_tag; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE detection_tag (
    detection_tags_id bigint,
    tag_id bigint
);


ALTER TABLE detection_tag OWNER TO postgres;

--
-- Name: device; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE device OWNER TO postgres;

--
-- Name: device_manufacturer; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE device_manufacturer (
    id bigint NOT NULL,
    version bigint NOT NULL,
    manufacturer_name character varying(255) NOT NULL
);


ALTER TABLE device_manufacturer OWNER TO postgres;

--
-- Name: device_model; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE device_model (
    id bigint NOT NULL,
    version bigint NOT NULL,
    manufacturer_id bigint NOT NULL,
    model_name character varying(255) NOT NULL
);


ALTER TABLE device_model OWNER TO postgres;

--
-- Name: device_status; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE device_status (
    id bigint NOT NULL,
    version bigint NOT NULL,
    status character varying(255) NOT NULL
);


ALTER TABLE device_status OWNER TO postgres;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: aatams; Owner: postgres
--

CREATE SEQUENCE hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hibernate_sequence OWNER TO postgres;

--
-- Name: installation; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE installation (
    id bigint NOT NULL,
    version bigint NOT NULL,
    configuration_id bigint NOT NULL,
    lat_offset real NOT NULL,
    lon_offset real NOT NULL,
    name character varying(255) NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE installation OWNER TO postgres;

--
-- Name: installation_configuration; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE installation_configuration (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE installation_configuration OWNER TO postgres;

--
-- Name: installation_station; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE installation_station (
    id bigint NOT NULL,
    version bigint NOT NULL,
    curtain_position integer NOT NULL,
    installation_id bigint NOT NULL,
    location public.geometry NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE installation_station OWNER TO postgres;

--
-- Name: installation_station_receiver; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE installation_station_receiver (
    installation_station_receivers_id bigint,
    receiver_id bigint
);


ALTER TABLE installation_station_receiver OWNER TO postgres;

--
-- Name: measurement_unit; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE measurement_unit (
    id bigint NOT NULL,
    version bigint NOT NULL,
    unit character varying(255) NOT NULL
);


ALTER TABLE measurement_unit OWNER TO postgres;

--
-- Name: mooring_type; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE mooring_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE mooring_type OWNER TO postgres;

--
-- Name: organisation; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE organisation OWNER TO postgres;

--
-- Name: organisation_person; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE organisation_person (
    id bigint NOT NULL,
    version bigint NOT NULL,
    organisation_id bigint NOT NULL,
    person_id bigint NOT NULL
);


ALTER TABLE organisation_person OWNER TO postgres;

--
-- Name: organisation_project; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE organisation_project (
    id bigint NOT NULL,
    version bigint NOT NULL,
    organisation_id bigint NOT NULL,
    project_id bigint NOT NULL
);


ALTER TABLE organisation_project OWNER TO postgres;

--
-- Name: person; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE person (
    id bigint NOT NULL,
    version bigint NOT NULL,
    email_address character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL
);


ALTER TABLE person OWNER TO postgres;

--
-- Name: person_system_role; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE person_system_role (
    person_system_roles_id bigint,
    system_role_id bigint
);


ALTER TABLE person_system_role OWNER TO postgres;

--
-- Name: processed_upload_file; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE processed_upload_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    err_msg character varying(255),
    status character varying(255) NOT NULL,
    u_file_id bigint NOT NULL
);


ALTER TABLE processed_upload_file OWNER TO postgres;

--
-- Name: project; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE project (
    id bigint NOT NULL,
    version bigint NOT NULL,
    description character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    principal_investigator_id bigint
);


ALTER TABLE project OWNER TO postgres;

--
-- Name: project_role; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE project_role (
    id bigint NOT NULL,
    version bigint NOT NULL,
    person_id bigint NOT NULL,
    project_id bigint NOT NULL,
    role_type_id bigint NOT NULL
);


ALTER TABLE project_role OWNER TO postgres;

--
-- Name: project_role_type; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE project_role_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    display_name character varying(255) NOT NULL
);


ALTER TABLE project_role_type OWNER TO postgres;

--
-- Name: receiver_deployment; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE receiver_deployment OWNER TO postgres;

--
-- Name: receiver_download; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE receiver_download OWNER TO postgres;

--
-- Name: receiver_download_file; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE receiver_download_file (
    id bigint NOT NULL,
    version bigint NOT NULL,
    path bytea NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE receiver_download_file OWNER TO postgres;

--
-- Name: receiver_download_receiver_download_file; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE receiver_download_receiver_download_file (
    receiver_download_download_files_id bigint,
    receiver_download_file_id bigint
);


ALTER TABLE receiver_download_receiver_download_file OWNER TO postgres;

--
-- Name: receiver_recovery; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE receiver_recovery OWNER TO postgres;

--
-- Name: sensor; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE sensor OWNER TO postgres;

--
-- Name: sensor_detection_sensor; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE sensor_detection_sensor (
    sensor_detection_sensors_id bigint,
    sensor_id bigint
);


ALTER TABLE sensor_detection_sensor OWNER TO postgres;

--
-- Name: sex; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE sex (
    id bigint NOT NULL,
    version bigint NOT NULL,
    sex character varying(255) NOT NULL
);


ALTER TABLE sex OWNER TO postgres;

--
-- Name: surgery; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE surgery OWNER TO postgres;

--
-- Name: surgery_treatment_type; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE surgery_treatment_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE surgery_treatment_type OWNER TO postgres;

--
-- Name: surgery_type; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE surgery_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE surgery_type OWNER TO postgres;

--
-- Name: system_role; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE system_role (
    id bigint NOT NULL,
    version bigint NOT NULL,
    role_type_id bigint NOT NULL
);


ALTER TABLE system_role OWNER TO postgres;

--
-- Name: system_role_type; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE system_role_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    display_name character varying(255) NOT NULL
);


ALTER TABLE system_role_type OWNER TO postgres;

--
-- Name: transmitter_type; Type: TABLE; Schema: aatams; Owner: postgres
--

CREATE TABLE transmitter_type (
    id bigint NOT NULL,
    version bigint NOT NULL,
    transmitter_type_name character varying(255) NOT NULL
);


ALTER TABLE transmitter_type OWNER TO postgres;

--
-- Name: ufile; Type: TABLE; Schema: aatams; Owner: postgres
--

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


ALTER TABLE ufile OWNER TO postgres;

--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: animal_measurement animal_measurement_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_measurement
    ADD CONSTRAINT animal_measurement_pkey PRIMARY KEY (id);


--
-- Name: animal_measurement_type animal_measurement_type_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_measurement_type
    ADD CONSTRAINT animal_measurement_type_pkey PRIMARY KEY (id);


--
-- Name: animal_measurement_type animal_measurement_type_type_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_measurement_type
    ADD CONSTRAINT animal_measurement_type_type_key UNIQUE (type);


--
-- Name: animal animal_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal
    ADD CONSTRAINT animal_pkey PRIMARY KEY (id);


--
-- Name: animal_release animal_release_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_release
    ADD CONSTRAINT animal_release_pkey PRIMARY KEY (id);


--
-- Name: detection detection_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY detection
    ADD CONSTRAINT detection_pkey PRIMARY KEY (id);


--
-- Name: device_manufacturer device_manufacturer_manufacturer_name_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device_manufacturer
    ADD CONSTRAINT device_manufacturer_manufacturer_name_key UNIQUE (manufacturer_name);


--
-- Name: device_manufacturer device_manufacturer_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device_manufacturer
    ADD CONSTRAINT device_manufacturer_pkey PRIMARY KEY (id);


--
-- Name: device_model device_model_model_name_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device_model
    ADD CONSTRAINT device_model_model_name_key UNIQUE (model_name);


--
-- Name: device_model device_model_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device_model
    ADD CONSTRAINT device_model_pkey PRIMARY KEY (id);


--
-- Name: device device_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id);


--
-- Name: device_status device_status_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device_status
    ADD CONSTRAINT device_status_pkey PRIMARY KEY (id);


--
-- Name: device_status device_status_status_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device_status
    ADD CONSTRAINT device_status_status_key UNIQUE (status);


--
-- Name: installation_configuration installation_configuration_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY installation_configuration
    ADD CONSTRAINT installation_configuration_pkey PRIMARY KEY (id);


--
-- Name: installation_configuration installation_configuration_type_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY installation_configuration
    ADD CONSTRAINT installation_configuration_type_key UNIQUE (type);


--
-- Name: installation installation_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY installation
    ADD CONSTRAINT installation_pkey PRIMARY KEY (id);


--
-- Name: installation_station installation_station_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY installation_station
    ADD CONSTRAINT installation_station_pkey PRIMARY KEY (id);


--
-- Name: measurement_unit measurement_unit_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY measurement_unit
    ADD CONSTRAINT measurement_unit_pkey PRIMARY KEY (id);


--
-- Name: measurement_unit measurement_unit_unit_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY measurement_unit
    ADD CONSTRAINT measurement_unit_unit_key UNIQUE (unit);


--
-- Name: mooring_type mooring_type_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY mooring_type
    ADD CONSTRAINT mooring_type_pkey PRIMARY KEY (id);


--
-- Name: mooring_type mooring_type_type_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY mooring_type
    ADD CONSTRAINT mooring_type_type_key UNIQUE (type);


--
-- Name: organisation organisation_name_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation
    ADD CONSTRAINT organisation_name_key UNIQUE (name);


--
-- Name: organisation_person organisation_person_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation_person
    ADD CONSTRAINT organisation_person_pkey PRIMARY KEY (id);


--
-- Name: organisation organisation_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation
    ADD CONSTRAINT organisation_pkey PRIMARY KEY (id);


--
-- Name: organisation_project organisation_project_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation_project
    ADD CONSTRAINT organisation_project_pkey PRIMARY KEY (id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: processed_upload_file processed_upload_file_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY processed_upload_file
    ADD CONSTRAINT processed_upload_file_pkey PRIMARY KEY (id);


--
-- Name: project project_name_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_name_key UNIQUE (name);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: project_role project_role_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY project_role
    ADD CONSTRAINT project_role_pkey PRIMARY KEY (id);


--
-- Name: project_role_type project_role_type_display_name_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY project_role_type
    ADD CONSTRAINT project_role_type_display_name_key UNIQUE (display_name);


--
-- Name: project_role_type project_role_type_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY project_role_type
    ADD CONSTRAINT project_role_type_pkey PRIMARY KEY (id);


--
-- Name: receiver_deployment receiver_deployment_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_deployment
    ADD CONSTRAINT receiver_deployment_pkey PRIMARY KEY (id);


--
-- Name: receiver_download_file receiver_download_file_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_download_file
    ADD CONSTRAINT receiver_download_file_pkey PRIMARY KEY (id);


--
-- Name: receiver_download receiver_download_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_download
    ADD CONSTRAINT receiver_download_pkey PRIMARY KEY (id);


--
-- Name: receiver_recovery receiver_recovery_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_recovery
    ADD CONSTRAINT receiver_recovery_pkey PRIMARY KEY (id);


--
-- Name: sensor sensor_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY sensor
    ADD CONSTRAINT sensor_pkey PRIMARY KEY (id);


--
-- Name: sex sex_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY sex
    ADD CONSTRAINT sex_pkey PRIMARY KEY (id);


--
-- Name: sex sex_sex_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY sex
    ADD CONSTRAINT sex_sex_key UNIQUE (sex);


--
-- Name: surgery surgery_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery
    ADD CONSTRAINT surgery_pkey PRIMARY KEY (id);


--
-- Name: surgery_treatment_type surgery_treatment_type_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery_treatment_type
    ADD CONSTRAINT surgery_treatment_type_pkey PRIMARY KEY (id);


--
-- Name: surgery_treatment_type surgery_treatment_type_type_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery_treatment_type
    ADD CONSTRAINT surgery_treatment_type_type_key UNIQUE (type);


--
-- Name: surgery_type surgery_type_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery_type
    ADD CONSTRAINT surgery_type_pkey PRIMARY KEY (id);


--
-- Name: surgery_type surgery_type_type_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery_type
    ADD CONSTRAINT surgery_type_type_key UNIQUE (type);


--
-- Name: system_role system_role_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY system_role
    ADD CONSTRAINT system_role_pkey PRIMARY KEY (id);


--
-- Name: system_role_type system_role_type_display_name_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY system_role_type
    ADD CONSTRAINT system_role_type_display_name_key UNIQUE (display_name);


--
-- Name: system_role_type system_role_type_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY system_role_type
    ADD CONSTRAINT system_role_type_pkey PRIMARY KEY (id);


--
-- Name: transmitter_type transmitter_type_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY transmitter_type
    ADD CONSTRAINT transmitter_type_pkey PRIMARY KEY (id);


--
-- Name: transmitter_type transmitter_type_transmitter_type_name_key; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY transmitter_type
    ADD CONSTRAINT transmitter_type_transmitter_type_name_key UNIQUE (transmitter_type_name);


--
-- Name: ufile ufile_pkey; Type: CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY ufile
    ADD CONSTRAINT ufile_pkey PRIMARY KEY (id);


--
-- Name: installation_station_receiver fk2f7233ffd6ed9307; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY installation_station_receiver
    ADD CONSTRAINT fk2f7233ffd6ed9307 FOREIGN KEY (installation_station_receivers_id) REFERENCES installation_station(id);


--
-- Name: installation_station_receiver fk2f7233fff0bb6d33; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY installation_station_receiver
    ADD CONSTRAINT fk2f7233fff0bb6d33 FOREIGN KEY (receiver_id) REFERENCES device(id);


--
-- Name: project_role fk37fff5dc51218487; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY project_role
    ADD CONSTRAINT fk37fff5dc51218487 FOREIGN KEY (role_type_id) REFERENCES project_role_type(id);


--
-- Name: project_role fk37fff5dcbf505a21; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY project_role
    ADD CONSTRAINT fk37fff5dcbf505a21 FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_role fk37fff5dce985cdb3; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY project_role
    ADD CONSTRAINT fk37fff5dce985cdb3 FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: organisation fk3a5300dabc5dddfd; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation
    ADD CONSTRAINT fk3a5300dabc5dddfd FOREIGN KEY (street_address_id) REFERENCES address(id);


--
-- Name: organisation fk3a5300dac7e435; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation
    ADD CONSTRAINT fk3a5300dac7e435 FOREIGN KEY (postal_address_id) REFERENCES address(id);


--
-- Name: installation fk796d5e3a18d65d27; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY installation
    ADD CONSTRAINT fk796d5e3a18d65d27 FOREIGN KEY (configuration_id) REFERENCES installation_configuration(id);


--
-- Name: installation fk796d5e3abf505a21; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY installation
    ADD CONSTRAINT fk796d5e3abf505a21 FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: receiver_download fk79accd8b8e509d3; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_download
    ADD CONSTRAINT fk79accd8b8e509d3 FOREIGN KEY (downloader_id) REFERENCES person(id);


--
-- Name: sensor_detection_sensor fk8165509916b1b072; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY sensor_detection_sensor
    ADD CONSTRAINT fk8165509916b1b072 FOREIGN KEY (sensor_detection_sensors_id) REFERENCES detection(id);


--
-- Name: sensor_detection_sensor fk81655099d7d8b793; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY sensor_detection_sensor
    ADD CONSTRAINT fk81655099d7d8b793 FOREIGN KEY (sensor_id) REFERENCES sensor(id);


--
-- Name: receiver_recovery fk82de83e56b73e7c9; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_recovery
    ADD CONSTRAINT fk82de83e56b73e7c9 FOREIGN KEY (status_id) REFERENCES device_status(id);


--
-- Name: receiver_recovery fk82de83e579a96182; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_recovery
    ADD CONSTRAINT fk82de83e579a96182 FOREIGN KEY (deployment_id) REFERENCES receiver_deployment(id);


--
-- Name: receiver_recovery fk82de83e593fa40a2; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_recovery
    ADD CONSTRAINT fk82de83e593fa40a2 FOREIGN KEY (download_id) REFERENCES receiver_download(id);


--
-- Name: receiver_deployment fk862aeb1531eebdc; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_deployment
    ADD CONSTRAINT fk862aeb1531eebdc FOREIGN KEY (mooring_type_id) REFERENCES mooring_type(id);


--
-- Name: receiver_deployment fk862aeb15cdaf3227; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_deployment
    ADD CONSTRAINT fk862aeb15cdaf3227 FOREIGN KEY (station_id) REFERENCES installation_station(id);


--
-- Name: receiver_deployment fk862aeb15f0bb6d33; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_deployment
    ADD CONSTRAINT fk862aeb15f0bb6d33 FOREIGN KEY (receiver_id) REFERENCES device(id);


--
-- Name: animal_release fk88d6a0c4bf505a21; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_release
    ADD CONSTRAINT fk88d6a0c4bf505a21 FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: animal_release fk88d6a0c4e0347853; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_release
    ADD CONSTRAINT fk88d6a0c4e0347853 FOREIGN KEY (animal_id) REFERENCES animal(id);


--
-- Name: person_system_role fk8e3f6e9c244fac71; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY person_system_role
    ADD CONSTRAINT fk8e3f6e9c244fac71 FOREIGN KEY (person_system_roles_id) REFERENCES person(id);


--
-- Name: person_system_role fk8e3f6e9cbba8aa52; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY person_system_role
    ADD CONSTRAINT fk8e3f6e9cbba8aa52 FOREIGN KEY (system_role_id) REFERENCES system_role(id);


--
-- Name: animal_measurement fk8eb3adf914018681; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_measurement
    ADD CONSTRAINT fk8eb3adf914018681 FOREIGN KEY (type_id) REFERENCES animal_measurement_type(id);


--
-- Name: animal_measurement fk8eb3adf9e6ea591d; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_measurement
    ADD CONSTRAINT fk8eb3adf9e6ea591d FOREIGN KEY (unit_id) REFERENCES measurement_unit(id);


--
-- Name: installation_station fk902c2c2f35e870d3; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY installation_station
    ADD CONSTRAINT fk902c2c2f35e870d3 FOREIGN KEY (installation_id) REFERENCES installation(id);


--
-- Name: detection fk90e7ca85f0bb6d33; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY detection
    ADD CONSTRAINT fk90e7ca85f0bb6d33 FOREIGN KEY (receiver_id) REFERENCES device(id);


--
-- Name: surgery fk918a71f54f2dd3af; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f54f2dd3af FOREIGN KEY (treatment_type_id) REFERENCES surgery_treatment_type(id);


--
-- Name: surgery fk918a71f56d95e296; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f56d95e296 FOREIGN KEY (type_id) REFERENCES surgery_type(id);


--
-- Name: surgery fk918a71f57480ac7b; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f57480ac7b FOREIGN KEY (surgeon_id) REFERENCES person(id);


--
-- Name: surgery fk918a71f5b5c10085; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f5b5c10085 FOREIGN KEY (release_id) REFERENCES animal_release(id);


--
-- Name: surgery fk918a71f5ceab1a01; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY surgery
    ADD CONSTRAINT fk918a71f5ceab1a01 FOREIGN KEY (tag_id) REFERENCES device(id);


--
-- Name: animal_release_animal_measurement fka3b75543290ccda; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_release_animal_measurement
    ADD CONSTRAINT fka3b75543290ccda FOREIGN KEY (animal_release_measurements_id) REFERENCES animal_release(id);


--
-- Name: animal_release_animal_measurement fka3b7554af520388; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal_release_animal_measurement
    ADD CONSTRAINT fka3b7554af520388 FOREIGN KEY (animal_measurement_id) REFERENCES animal_measurement(id);


--
-- Name: system_role fka47ecc86d06730af; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY system_role
    ADD CONSTRAINT fka47ecc86d06730af FOREIGN KEY (role_type_id) REFERENCES system_role_type(id);


--
-- Name: animal fkabc58dfccd365681; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY animal
    ADD CONSTRAINT fkabc58dfccd365681 FOREIGN KEY (sex_id) REFERENCES sex(id);


--
-- Name: receiver_download_receiver_download_file fkadfe47ca50da4c63; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_download_receiver_download_file
    ADD CONSTRAINT fkadfe47ca50da4c63 FOREIGN KEY (receiver_download_file_id) REFERENCES receiver_download_file(id);


--
-- Name: receiver_download_receiver_download_file fkadfe47cafa360683; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY receiver_download_receiver_download_file
    ADD CONSTRAINT fkadfe47cafa360683 FOREIGN KEY (receiver_download_download_files_id) REFERENCES receiver_download(id);


--
-- Name: device fkb06b1e561c043beb; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device
    ADD CONSTRAINT fkb06b1e561c043beb FOREIGN KEY (model_id) REFERENCES device_model(id);


--
-- Name: device fkb06b1e566b73e7c9; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device
    ADD CONSTRAINT fkb06b1e566b73e7c9 FOREIGN KEY (status_id) REFERENCES device_status(id);


--
-- Name: device fkb06b1e56bf505a21; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device
    ADD CONSTRAINT fkb06b1e56bf505a21 FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: processed_upload_file fkc1735d892224770f; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY processed_upload_file
    ADD CONSTRAINT fkc1735d892224770f FOREIGN KEY (u_file_id) REFERENCES ufile(id);


--
-- Name: sensor fkca0053ba4b0c3bc4; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY sensor
    ADD CONSTRAINT fkca0053ba4b0c3bc4 FOREIGN KEY (transmitter_type_id) REFERENCES transmitter_type(id);


--
-- Name: sensor fkca0053baceab1a01; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY sensor
    ADD CONSTRAINT fkca0053baceab1a01 FOREIGN KEY (tag_id) REFERENCES device(id);


--
-- Name: device_model fkdcc4e40025f67029; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY device_model
    ADD CONSTRAINT fkdcc4e40025f67029 FOREIGN KEY (manufacturer_id) REFERENCES device_manufacturer(id);


--
-- Name: detection_tag fkeb71eee0ac39c713; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY detection_tag
    ADD CONSTRAINT fkeb71eee0ac39c713 FOREIGN KEY (detection_tags_id) REFERENCES detection(id);


--
-- Name: detection_tag fkeb71eee0ceab1a01; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY detection_tag
    ADD CONSTRAINT fkeb71eee0ceab1a01 FOREIGN KEY (tag_id) REFERENCES device(id);


--
-- Name: project fked904b19ab94ee16; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT fked904b19ab94ee16 FOREIGN KEY (principal_investigator_id) REFERENCES project_role(id);


--
-- Name: organisation_person fkee60ce5a99b5ecd3; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation_person
    ADD CONSTRAINT fkee60ce5a99b5ecd3 FOREIGN KEY (organisation_id) REFERENCES organisation(id);


--
-- Name: organisation_person fkee60ce5ae985cdb3; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation_person
    ADD CONSTRAINT fkee60ce5ae985cdb3 FOREIGN KEY (person_id) REFERENCES person(id);


--
-- Name: organisation_project fkf3b978b499b5ecd3; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation_project
    ADD CONSTRAINT fkf3b978b499b5ecd3 FOREIGN KEY (organisation_id) REFERENCES organisation(id);


--
-- Name: organisation_project fkf3b978b4bf505a21; Type: FK CONSTRAINT; Schema: aatams; Owner: postgres
--

ALTER TABLE ONLY organisation_project
    ADD CONSTRAINT fkf3b978b4bf505a21 FOREIGN KEY (project_id) REFERENCES project(id);


--
-- PostgreSQL database dump complete
--

