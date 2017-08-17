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
-- Name: biologging; Type: SCHEMA; Schema: -; Owner: biologging
--

CREATE SCHEMA biologging;


ALTER SCHEMA biologging OWNER TO biologging;

SET search_path = biologging, pg_catalog;

--
-- Name: load_worms_data(integer); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION load_worms_data(id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
declare
    file varchar(256);
    sql varchar(256);
BEGIN

truncate table json;

file := quote_literal('/opt/mola/worms/' || id || '.adb.json');
file := quote_literal('/home/dougt/mola/worms/' || id || '.adb.json');
sql := 'copy json(v) from ' || file;
execute sql;

sql := 'update json set id = ' || id || ', worm_code = ' || quote_literal('adb') || ' where id is null;';
-- raise notice '%', sql;
execute sql;

insert into species_atn_worms_adb (id, locality, location_id, higher_geograhpy, higher_geography_id, record_status,
            type_status, establishment_means, decimal_latitude, decimal_longitude, quality_status)
select a.id, v->>'locality', v->>'locationID', v->>'higherGeography', v->>'higherGeographyID', v->>'recordStatus',
           v->>'typeStatus', v->>'establishmentMeans', 
           cast(v->>'decimalLatitude' as double precision), 
           cast(v->>'decimalLongitude' as double precision), v->>'qualityStatus'
  from (select b.id, json_array_elements(replace(b.v,'\','\\')::json) as v
          from json b where b.worm_code = 'adb') a;

file := quote_literal('/opt/mola/worms/' || id || '.arb.json');
file := quote_literal('/home/dougt/mola/worms/' || id || '.arb.json');
sql := 'copy json(v) from ' || file;
execute sql;

sql := 'update json set id = ' || id || ', worm_code = ' || quote_literal('arb') || ' where id is null;';
-- raise notice '%', sql;
execute sql;

insert into species_atn_worms_arb (id, aphia_id, url, scientific_name, authority, rank, status, unaccept_reason, valid_aphia_id,
            valid_name, valid_authority, kingdom, phylum, class, order_name, family, genus, citation, ls_id, is_marine,
            is_freshwater, is_terrestrial, is_extinct, match_type, modified)
select a.id, cast(v->>'AphiaID' as integer), v->>'url', v->>'scientificname', v->>'authority', v->>'rank', v->>'status', v->>'unacceptreason', 
           cast(v->>'valid_AphiaID' as integer), v->>'valid_name', v->>'valid_authority', v->>'kingdom', v->>'phylum', v->>'class', 
           v->>'order', v->>'family', v->>'genus', v->>'citation', v->>'lsid', cast(v->>'isMarine' as boolean), cast(v->>'isFreshwater' as boolean), 
           cast(v->>'isTerrestrial' as boolean), cast(v->>'isExtinct' as boolean), v->>'match_type', v->>'modified'
  from (select b.id, b.v::json as v from json b where b.worm_code = 'arb') a;

file := quote_literal('/opt/mola/worms/' || id || '.avb.json');
file := quote_literal('/home/dougt/mola/worms/' || id || '.avb.json');
sql := 'copy json(v) from ' || file;
execute sql;

sql := 'update json set id = ' || id || ', worm_code = ' || quote_literal('avb') || ' where id is null;';
-- raise notice '%', sql;
execute sql;

insert into species_atn_worms_avb (id, vernacular, language_code, language)
select a.id, v->>'vernacular', v->>'language_code', v->>'language'
  from (select b.id, json_array_elements(replace(b.v,'\','\\')::json) as v
          from json b where b.worm_code = 'avb') a;

END;
$$;


ALTER FUNCTION biologging.load_worms_data(id integer) OWNER TO postgres;

--
-- Name: refresh_wc_all_deployment_profiles(); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION refresh_wc_all_deployment_profiles() RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE
    curs1 CURSOR FOR SELECT wc_id, last_update_date FROM tmp_all_deployment_profiles;

    v_last_update_date integer;
    v_wc_id            text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_last_update_date;
        exit when not found; -- v_wc_id = null;

        /*
        select count(1) into v_cnt
          from wc_all_deployment_profiles
         where wc_id            = v_wc_id
           and last_update_date = v_last_update_date;
          
        -- RAISE NOTICE 'Keys: <%> <%> <%>', v_wc_id, v_last_update_date, v_cnt;
        */

        if not exists (
            select 1
              from wc_all_deployment_profiles
             where wc_id            = v_wc_id
               and last_update_date = v_last_update_date)
        then
            insert into wc_all_deployment_profiles
            select *
              from tmp_all_deployment_profiles
             where wc_id            = v_wc_id
               and last_update_date = v_last_update_date
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$;


ALTER FUNCTION biologging.refresh_wc_all_deployment_profiles() OWNER TO postgres;

--
-- Name: refresh_wc_all_deployments(); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION refresh_wc_all_deployments() RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE
    curs1 CURSOR FOR SELECT wc_id, last_update_date FROM tmp_all_deployments;

    v_last_update_date integer;
    v_wc_id            text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_last_update_date;
        exit when not found; -- v_wc_id = null;

        if not exists (
            select 1
              from wc_all_deployments
             where wc_id            = v_wc_id
               and last_update_date = v_last_update_date)
        then
            insert into wc_all_deployments
            select *
              from tmp_all_deployments
             where wc_id            = v_wc_id
               and last_update_date = v_last_update_date
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$;


ALTER FUNCTION biologging.refresh_wc_all_deployments() OWNER TO postgres;

--
-- Name: refresh_wc_all_locations(); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION refresh_wc_all_locations() RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE
    curs1 CURSOR FOR 
        SELECT wc_id, date, latitude, longitude
          FROM tmp_all_locations;

    v_date       integer;
    v_latitude   double precision;
    v_longitude  double precision;
    v_wc_id      text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_date, v_latitude, v_longitude;
        exit when not found; -- v_wc_id = null;

        if not exists (
            select 1
              from wc_all_locations
             where wc_id     = v_wc_id
               and date      = v_date
               and latitude  = v_latitude
               and longitude = v_longitude)
        then
            insert into wc_all_locations
            select *
              from tmp_all_locations
             where wc_id     = v_wc_id
               and date      = v_date
               and latitude  = v_latitude
               and longitude = v_longitude
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$;


ALTER FUNCTION biologging.refresh_wc_all_locations() OWNER TO postgres;

--
-- Name: refresh_wc_all_profiles(); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION refresh_wc_all_profiles() RETURNS integer
    LANGUAGE plpgsql
    AS $$

DECLARE
    curs1 CURSOR FOR 
        SELECT wc_id, date FROM tmp_all_profiles;
    v_bin            text[];
    v_date           integer;
    v_discontinuity  text[];
    v_temperature    text[];
    v_wc_id          text;
    v_row            RECORD;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_row;
        exit when not found;

        if not exists (
            select 1
              from wc_all_profiles
             where wc_id  = v_row.wc_id
               and date   = v_row.date)
        then
            select array["bin.depth"::text, 
                         "bin.depth.1"::text, "bin.depth.2"::text, "bin.depth.3"::text, "bin.depth.4"::text, 
                         "bin.depth.5"::text, "bin.depth.6"::text, "bin.depth.7"::text, "bin.depth.8"::text,
                         "bin.depth.9"::text, "bin.depth.10"::text]
              into v_bin
              from tmp_all_profiles
             where wc_id  = v_row.wc_id
               and date   = v_row.date
             limit 1;

            select array["bin.temperature"::text, 
                         "bin.temperature.1"::text, "bin.temperature.2"::text, "bin.temperature.3"::text, "bin.temperature.4"::text, 
                         "bin.temperature.5"::text, "bin.temperature.6"::text, "bin.temperature.7"::text, "bin.temperature.8"::text,
                         "bin.temperature.9"::text, "bin.temperature.10"::text]
              into v_temperature
              from tmp_all_profiles
             where wc_id  = v_row.wc_id
               and date   = v_row.date
             limit 1;

            select array["bin.discontinuity"::text, 
                         "bin.discontinuity.1"::text, "bin.discontinuity.2"::text, "bin.discontinuity.3"::text, "bin.discontinuity.4"::text, 
                         "bin.discontinuity.5"::text, "bin.discontinuity.6"::text, "bin.discontinuity.7"::text, "bin.discontinuity.8"::text,
                         "bin.discontinuity.9"::text, "bin.discontinuity.10"::text]
              into v_discontinuity
              from tmp_all_profiles
             where wc_id  = v_row.wc_id
               and date   = v_row.date
             limit 1;

            insert into wc_all_profiles (wc_id, date, depth_sensor_resolution, temperature_sensor_resolution,
                   gps_snapshot_date, gps_snapshot_latitude, gps_snapshot_longitude, gps_snapshot_residual,
                   gps_snapshot_time_error, gps_snapshot_satellites, gps_snapshot_bad_satellites,
                   bin_depth, bin_temperature, bin_discontinuity)
            select wc_id, date, depth_sensor_resolution, temperature_sensor_resolution, "gps_snapshot.date", 
                   "gps_snapshot.latitude", "gps_snapshot.longitude", "gps_snapshot.residual",
                   "gps_snapshot.time_error", "gps_snapshot.satellites", "gps_snapshot.bad_satellites",
                   v_bin, v_temperature, v_discontinuity
              from tmp_all_profiles
             where wc_id     = v_row.wc_id
               and date      = v_row.date
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$;


ALTER FUNCTION biologging.refresh_wc_all_profiles() OWNER TO postgres;

--
-- Name: set_acoustic_detections_duplicate_status(); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION set_acoustic_detections_duplicate_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$


                        DECLARE
                          changed_row biologging.acoustic_detections%ROWTYPE;


                        BEGIN
                          IF (TG_OP = 'DELETE') THEN
                            changed_row = OLD;
                          ELSE
                            changed_row = NEW;
                          END IF;


                          UPDATE biologging.acoustic_detections
                          SET duplicate = subquery.duplicate
                          FROM (
                            SELECT id,
                            ROW_NUMBER() OVER(PARTITION BY timestamp, transmitter_id, receiver_name ORDER BY id asc) > 1
                              AS duplicate
                            FROM biologging.acoustic_detections
                            WHERE timestamp = changed_row.timestamp
                              AND transmitter_id = changed_row.transmitter_id
                              AND receiver_name = changed_row.receiver_name
                          ) subquery
                          WHERE detection.id = subquery.id;


                          RETURN changed_row;
                        END;


                        $$;


ALTER FUNCTION biologging.set_acoustic_detections_duplicate_status() OWNER TO postgres;

--
-- Name: set_argos_locations_duplicate_status(); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION set_argos_locations_duplicate_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$


                        DECLARE
                          changed_row biologging.argos_locations%ROWTYPE;


                        BEGIN
                          IF (TG_OP = 'DELETE') THEN
                            changed_row = OLD;
                          ELSE
                            changed_row = NEW;
                          END IF;


                          UPDATE biologging.argos_locations
                          SET duplicate = subquery.duplicate
                          FROM (
                            SELECT id,
                            ROW_NUMBER() OVER(PARTITION BY timestamp, device_ic ORDER BY id asc) > 1
                              AS duplicate
                            FROM biologging.argos_locations
                            WHERE timestamp = changed_row.timestamp
                              AND device_name = changed_row.device_name
                          ) subquery
                          WHERE argos_locations.id = subquery.id;


                          RETURN changed_row;
                        END;


                        $$;


ALTER FUNCTION biologging.set_argos_locations_duplicate_status() OWNER TO postgres;

--
-- Name: set_gls_locations_duplicate_status(); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION set_gls_locations_duplicate_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$


                        DECLARE
                          changed_row biologging.gls_locations%ROWTYPE;


                        BEGIN
                          IF (TG_OP = 'DELETE') THEN
                            changed_row = OLD;
                          ELSE
                            changed_row = NEW;
                          END IF;


                          UPDATE biologging.gls_locations
                          SET duplicate = subquery.duplicate
                          FROM (
                            SELECT id,
                            ROW_NUMBER() OVER(PARTITION BY timestamp, device_name ORDER BY id asc) > 1
                              AS duplicate
                            FROM biologging.gls_locations
                            WHERE timestamp = changed_row.timestamp
                              AND device_name = changed_row.device_name
                          ) subquery
                          WHERE detection.id = subquery.id;


                          RETURN changed_row;
                        END;


                        $$;


ALTER FUNCTION biologging.set_gls_locations_duplicate_status() OWNER TO postgres;

--
-- Name: set_gps_locations_duplicate_status(); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION set_gps_locations_duplicate_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$


                        DECLARE
                          changed_row biologging.gps_locations%ROWTYPE;


                        BEGIN
                          IF (TG_OP = 'DELETE') THEN
                            changed_row = OLD;
                          ELSE
                            changed_row = NEW;
                          END IF;


                          UPDATE biologging.gps_locations
                          SET duplicate = subquery.duplicate
                          FROM (
                            SELECT id,
                            ROW_NUMBER() OVER(PARTITION BY timestamp, device_name ORDER BY id asc) > 1
                              AS duplicate
                            FROM biologging.gps_locations
                            WHERE timestamp = changed_row.timestamp
                              AND device_name = changed_row.device_name
                          ) subquery
                          WHERE detection.id = subquery.id;


                          RETURN changed_row;
                        END;


                        $$;


ALTER FUNCTION biologging.set_gps_locations_duplicate_status() OWNER TO postgres;

--
-- Name: test_sqldf(integer); Type: FUNCTION; Schema: biologging; Owner: postgres
--

CREATE FUNCTION test_sqldf(id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
    a  int;
    b varchar(32);
begin

    create table if not exists tmp(a int, b varchar(32));

    insert into tmp(a, b) values (id, 'abc');

    return 1;
end;
$$;


ALTER FUNCTION biologging.test_sqldf(id integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acoustic_detections; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE acoustic_detections OWNER TO postgres;

--
-- Name: acoustic_detections_id_seq; Type: SEQUENCE; Schema: biologging; Owner: postgres
--

CREATE SEQUENCE acoustic_detections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE acoustic_detections_id_seq OWNER TO postgres;

--
-- Name: acoustic_detections_id_seq; Type: SEQUENCE OWNED BY; Schema: biologging; Owner: postgres
--

ALTER SEQUENCE acoustic_detections_id_seq OWNED BY acoustic_detections.id;


--
-- Name: activity_log; Type: TABLE; Schema: biologging; Owner: postgres
--

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
    CONSTRAINT event_types CHECK ((((event_type)::text = 'Delete'::text) OR ((event_type)::text = 'Insert'::text) OR ((event_type)::text = 'Update'::text)))
);


ALTER TABLE activity_log OWNER TO postgres;

--
-- Name: animal; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE animal (
    id bigint NOT NULL,
    animal_name character varying(255),
    species_id bigint NOT NULL,
    sex character varying(7) NOT NULL,
    CONSTRAINT animal_sex_types CHECK ((((sex)::text = 'Female'::text) OR ((sex)::text = 'Male'::text) OR ((sex)::text = 'Unknown'::text)))
);


ALTER TABLE animal OWNER TO postgres;

--
-- Name: animal_capture; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE animal_capture OWNER TO postgres;

--
-- Name: animal_measurements; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE animal_measurements (
    id bigint NOT NULL,
    capture_id bigint NOT NULL,
    type character varying(255) NOT NULL,
    unit character varying(20) NOT NULL,
    value real NOT NULL,
    estimate boolean NOT NULL,
    comments character varying(255)
);


ALTER TABLE animal_measurements OWNER TO postgres;

--
-- Name: animal_observations; Type: TABLE; Schema: biologging; Owner: postgres
--

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
    CONSTRAINT animal_life_stage_types CHECK (((("lifeStage")::text = 'Adult'::text) OR (("lifeStage")::text = 'Juvenile'::text) OR (("lifeStage")::text = 'Subadult'::text))),
    CONSTRAINT animal_unit_types CHECK (((("ageUnit")::text = 'Days'::text) OR (("ageUnit")::text = 'Months'::text) OR (("ageUnit")::text = 'Years'::text) OR ("ageUnit" IS NULL)))
);


ALTER TABLE animal_observations OWNER TO postgres;

--
-- Name: argos_locations; Type: TABLE; Schema: biologging; Owner: postgres
--

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
    CONSTRAINT argos_locations_latitude CHECK ((("decimalLatitude" < (90)::double precision) AND ("decimalLatitude" > ('-90'::integer)::double precision))),
    CONSTRAINT argos_locations_longitude CHECK ((("decimalLongitude" < (180)::double precision) AND ("decimalLongitude" > ('-180'::integer)::double precision))),
    CONSTRAINT argos_locations_time CHECK (("timestamp" < now()))
);


ALTER TABLE argos_locations OWNER TO postgres;

--
-- Name: argos_locations_id_seq; Type: SEQUENCE; Schema: biologging; Owner: postgres
--

CREATE SEQUENCE argos_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE argos_locations_id_seq OWNER TO postgres;

--
-- Name: argos_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: biologging; Owner: postgres
--

ALTER SEQUENCE argos_locations_id_seq OWNED BY argos_locations.id;


--
-- Name: atn_pat_cl_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_cl_raw OWNER TO postgres;

--
-- Name: atn_pat_gl4_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_gl4_raw OWNER TO postgres;

--
-- Name: atn_pat_histo_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_histo_raw OWNER TO postgres;

--
-- Name: atn_pat_light_location_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_light_location_raw OWNER TO postgres;

--
-- Name: atn_pat_locations_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_locations_raw OWNER TO postgres;

--
-- Name: atn_pat_minmax_depth_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_minmax_depth_raw OWNER TO postgres;

--
-- Name: atn_pat_mix_layer_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_mix_layer_raw OWNER TO postgres;

--
-- Name: atn_pat_pdt_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_pdt_raw OWNER TO postgres;

--
-- Name: atn_pat_sst_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_sst_raw OWNER TO postgres;

--
-- Name: atn_pat_summary_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_summary_raw OWNER TO postgres;

--
-- Name: atn_pat_tag_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_pat_tag_raw OWNER TO postgres;

--
-- Name: atn_splash10_fast_gps_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_splash10_fast_gps_raw OWNER TO postgres;

--
-- Name: atn_splash10_locations_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_splash10_locations_raw OWNER TO postgres;

--
-- Name: atn_spot5_tag_raw; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE atn_spot5_tag_raw OWNER TO postgres;

--
-- Name: dbtable; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE dbtable OWNER TO postgres;

--
-- Name: dbtable_gid_seq; Type: SEQUENCE; Schema: biologging; Owner: postgres
--

CREATE SEQUENCE dbtable_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dbtable_gid_seq OWNER TO postgres;

--
-- Name: dbtable_gid_seq; Type: SEQUENCE OWNED BY; Schema: biologging; Owner: postgres
--

ALTER SEQUENCE dbtable_gid_seq OWNED BY dbtable.gid;


--
-- Name: device; Type: TABLE; Schema: biologging; Owner: postgres
--

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
    CONSTRAINT device_models CHECK ((((device_type)::text = 'Acoustic receiver'::text) AND ((model_name)::text = ANY ((ARRAY['VR2'::character varying, 'VR2AR'::character varying, 'VR2C'::character varying, 'VR2W'::character varying, 'VR3-UWM'::character varying, 'VR3UWM'::character varying, 'VR4-UWM'::character varying])::text[])))),
    CONSTRAINT device_types CHECK ((((device_type)::text = 'Archival tag'::text) OR ((device_type)::text = 'Pop-up satellite archival tag'::text) OR ((device_type)::text = 'Satellite tag'::text) OR ((device_type)::text = 'Acoustic tag'::text) OR ((device_type)::text = 'Acoustic receiver'::text)))
);


ALTER TABLE device OWNER TO postgres;

--
-- Name: device_deployment_recovery; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE device_deployment_recovery OWNER TO postgres;

--
-- Name: device_specifications; Type: TABLE; Schema: biologging; Owner: postgres
--

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
    CONSTRAINT instrument_geolocation_processing CHECK ((((geolocation = false) AND (geolocation_data_processing IS NULL)) OR ((geolocation = true) AND (geolocation_data_processing IS NOT NULL))))
);


ALTER TABLE device_specifications OWNER TO postgres;

--
-- Name: gls_locations; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE gls_locations OWNER TO postgres;

--
-- Name: gls_locations_id_seq; Type: SEQUENCE; Schema: biologging; Owner: postgres
--

CREATE SEQUENCE gls_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gls_locations_id_seq OWNER TO postgres;

--
-- Name: gls_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: biologging; Owner: postgres
--

ALTER SEQUENCE gls_locations_id_seq OWNED BY gls_locations.id;


--
-- Name: gps_locations; Type: TABLE; Schema: biologging; Owner: postgres
--

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
    CONSTRAINT gps_locations_latitude CHECK ((("decimalLatitude" < (90)::double precision) AND ("decimalLatitude" > ('-90'::integer)::double precision))),
    CONSTRAINT gps_locations_longitude CHECK ((("decimalLongitude" < (180)::double precision) AND ("decimalLongitude" > ('-180'::integer)::double precision))),
    CONSTRAINT gps_locations_time CHECK (("timestamp" < now()))
);


ALTER TABLE gps_locations OWNER TO postgres;

--
-- Name: gps_locations_id_seq; Type: SEQUENCE; Schema: biologging; Owner: postgres
--

CREATE SEQUENCE gps_locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gps_locations_id_seq OWNER TO postgres;

--
-- Name: gps_locations_id_seq; Type: SEQUENCE OWNED BY; Schema: biologging; Owner: postgres
--

ALTER SEQUENCE gps_locations_id_seq OWNED BY gps_locations.id;


--
-- Name: installation_station; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE installation_station (
    id bigint NOT NULL,
    project_id bigint NOT NULL,
    installation_name character varying(255) NOT NULL,
    station_name character varying(255) NOT NULL,
    station_location public.geometry NOT NULL
);


ALTER TABLE installation_station OWNER TO postgres;

--
-- Name: json; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE json (
    id integer,
    worm_code character varying(4),
    v text
);


ALTER TABLE json OWNER TO postgres;

--
-- Name: project; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE project OWNER TO postgres;

--
-- Name: project_role; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE project_role (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    project_id bigint NOT NULL,
    role_type character varying NOT NULL,
    CONSTRAINT project_role_types CHECK ((((role_type)::text = 'Principal Investigator'::text) OR ((role_type)::text = 'Co-Investigator'::text) OR ((role_type)::text = 'Research Assistant'::text) OR ((role_type)::text = 'Technical Assistant'::text) OR ((role_type)::text = 'Administrator'::text) OR ((role_type)::text = 'Student'::text)))
);


ALTER TABLE project_role OWNER TO postgres;

--
-- Name: raw_fisha; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE raw_fisha (
    raw_name character varying(64),
    raw_year_deployed integer DEFAULT 0,
    raw_project integer DEFAULT 0,
    raw_topp_id integer DEFAULT 0,
    raw_event_id integer DEFAULT 0,
    raw_serial_number integer DEFAULT 0,
    raw_is_drifter integer DEFAULT 0,
    raw_time timestamp without time zone,
    raw_longitude double precision,
    raw_latitude double precision,
    raw_lc character varying(4)
);


ALTER TABLE raw_fisha OWNER TO postgres;

--
-- Name: raw_fishb; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE raw_fishb (
    raw_name character varying(64),
    raw_year_deployed integer DEFAULT 0,
    raw_project integer DEFAULT 0,
    raw_topp_id integer DEFAULT 0,
    raw_event_id integer DEFAULT 0,
    raw_serial_number integer DEFAULT 0,
    raw_is_drifter integer DEFAULT 0,
    raw_time timestamp without time zone,
    raw_lc character varying(4)
);


ALTER TABLE raw_fishb OWNER TO postgres;

--
-- Name: raw_fishc; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE raw_fishc (
    raw_name character varying(64),
    raw_year_deployed integer DEFAULT 0,
    raw_project integer DEFAULT 0,
    raw_topp_id integer DEFAULT 0,
    raw_serial_number integer DEFAULT 0,
    raw_is_drifter integer DEFAULT 0,
    raw_time timestamp without time zone,
    raw_longitude double precision,
    raw_latitude double precision,
    raw_lc character varying(4)
);


ALTER TABLE raw_fishc OWNER TO postgres;

--
-- Name: species; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE species OWNER TO postgres;

--
-- Name: species_atn; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE species_atn (
    id bigint NOT NULL
);


ALTER TABLE species_atn OWNER TO postgres;

--
-- Name: species_atn_worms_adb; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE species_atn_worms_adb OWNER TO postgres;

--
-- Name: species_atn_worms_arb; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE species_atn_worms_arb OWNER TO postgres;

--
-- Name: species_atn_worms_avb; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE species_atn_worms_avb (
    id integer,
    vernacular character varying(255),
    language_code character varying(255),
    language character varying(255)
);


ALTER TABLE species_atn_worms_avb OWNER TO postgres;

--
-- Name: tmp_all_deployment_profiles; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE tmp_all_deployment_profiles (
    wc_id text,
    owner text,
    status text,
    last_update_date integer,
    "tag.tag_type" text,
    "tag.serial_number" text,
    "argos.program_number" integer,
    "argos.ptt_decimal" integer,
    "sources.source" text,
    "labels.category.name" text,
    "labels.category.label" text,
    deploy_id text,
    two_digit_year double precision
);


ALTER TABLE tmp_all_deployment_profiles OWNER TO postgres;

--
-- Name: tmp_all_deployments; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE tmp_all_deployments (
    wc_id text,
    owner text,
    status text,
    last_update_date integer,
    "tag.tag_type" text,
    "tag.serial_number" text,
    "argos.program_number" integer,
    "argos.ptt_decimal" integer,
    "argos.first_uplink_date" integer,
    "argos.last_uplink_date" integer,
    "last_location.latitude" double precision,
    "last_location.longitude" double precision,
    "last_location.location_date" integer,
    "sources.source" text,
    two_digit_year double precision
);


ALTER TABLE tmp_all_deployments OWNER TO postgres;

--
-- Name: tmp_all_locations; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE tmp_all_locations (
    wc_id text,
    date integer,
    latitude double precision,
    longitude double precision,
    location_class text,
    error_radius integer,
    error_semi_major_axis integer,
    error_semi_minor_axis integer,
    error_ellipse_orientation integer
);


ALTER TABLE tmp_all_locations OWNER TO postgres;

--
-- Name: tmp_all_profiles; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE tmp_all_profiles (
    wc_id text,
    ".id" text,
    date text,
    depth_sensor_resolution text,
    temperature_sensor_resolution text,
    "gps_snapshot.date" text,
    "gps_snapshot.latitude" text,
    "gps_snapshot.longitude" text,
    "gps_snapshot.residual" text,
    "gps_snapshot.time_error" text,
    "gps_snapshot.satellites" text,
    "gps_snapshot.bad_satellites" text,
    "bin.depth" text,
    "bin.temperature" text,
    "bin.discontinuity" text,
    "bin.depth.1" text,
    "bin.temperature.1" text,
    "bin.discontinuity.1" text,
    "bin.depth.2" text,
    "bin.temperature.2" text,
    "bin.discontinuity.2" text,
    "bin.depth.3" text,
    "bin.temperature.3" text,
    "bin.discontinuity.3" text,
    "bin.depth.4" text,
    "bin.temperature.4" text,
    "bin.discontinuity.4" text,
    "bin.depth.5" text,
    "bin.temperature.5" text,
    "bin.discontinuity.5" text,
    "bin.depth.6" text,
    "bin.temperature.6" text,
    "bin.discontinuity.6" text,
    "bin.depth.7" text,
    "bin.temperature.7" text,
    "bin.discontinuity.7" text,
    "bin.depth.8" text,
    "bin.temperature.8" text,
    "bin.discontinuity.8" text,
    "bin.depth.9" text,
    "bin.temperature.9" text,
    "bin.discontinuity.9" text,
    "bin.depth.10" text,
    "bin.temperature.10" text,
    "bin.discontinuity.10" text
);


ALTER TABLE tmp_all_profiles OWNER TO postgres;

--
-- Name: uploaded_file; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE uploaded_file (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    file_type character varying(255) NOT NULL,
    file_name character varying(255) NOT NULL,
    class_name character varying(255),
    persisted_object_id character varying(255),
    upload_datetime timestamp with time zone NOT NULL,
    status character varying(255) NOT NULL,
    err_msg text NOT NULL,
    CONSTRAINT file_types CHECK ((((file_type)::text = 'Acoustic detections'::text) OR ((file_type)::text = 'GPS locations'::text) OR ((file_type)::text = 'Argos locations'::text) OR ((file_type)::text = 'GLS locations'::text))),
    CONSTRAINT statuses CHECK ((((status)::text = 'Processed'::text) OR ((status)::text = 'Processing'::text) OR ((status)::text = 'Error'::text)))
);


ALTER TABLE uploaded_file OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE users (
    id bigint NOT NULL,
    organisation_name character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    email_address character varying(255) NOT NULL,
    department character varying(255) NOT NULL,
    phone_number character varying(20) NOT NULL,
    postal_address character varying(255) NOT NULL
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: wc_all_deployment_profiles; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE wc_all_deployment_profiles (
    wc_id text NOT NULL,
    owner text,
    status text,
    last_update_date integer NOT NULL,
    tag_tag_type text,
    tag_serial_number text,
    argos_program_number integer,
    argos_ptt_decimal integer,
    sources_source text,
    labels_category_name text,
    labels_category_label text,
    deploy_id text,
    two_digit_year double precision
);


ALTER TABLE wc_all_deployment_profiles OWNER TO postgres;

--
-- Name: wc_all_deployments; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE wc_all_deployments (
    wc_id text NOT NULL,
    owner text,
    status text,
    last_update_date integer NOT NULL,
    tag_tag_type text,
    tag_serial_number text,
    argos_program_number integer,
    argos_ptt_decimal integer,
    argos_first_uplink_date integer,
    argos_last_uplink_date integer,
    last_location_latitude double precision,
    last_location_longitude double precision,
    last_location_location_date integer,
    sources_source text,
    two_digit_year double precision
);


ALTER TABLE wc_all_deployments OWNER TO postgres;

--
-- Name: wc_all_locations; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE wc_all_locations (
    wc_id text NOT NULL,
    date integer NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    location_class text,
    error_radius integer,
    error_semi_major_axis integer,
    error_semi_minor_axis integer,
    error_ellipse_orientation integer
);


ALTER TABLE wc_all_locations OWNER TO postgres;

--
-- Name: wc_all_profiles; Type: TABLE; Schema: biologging; Owner: postgres
--

CREATE TABLE wc_all_profiles (
    wc_id text NOT NULL,
    date text NOT NULL,
    depth_sensor_resolution text,
    temperature_sensor_resolution text,
    gps_snapshot_date text,
    gps_snapshot_latitude text,
    gps_snapshot_longitude text,
    gps_snapshot_residual text,
    gps_snapshot_time_error text,
    gps_snapshot_satellites text,
    gps_snapshot_bad_satellites text,
    bin_depth text[],
    bin_temperature text[],
    bin_discontinuity text[]
);


ALTER TABLE wc_all_profiles OWNER TO postgres;

--
-- Name: wc_argos_locations; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE wc_argos_locations OWNER TO postgres;

--
-- Name: wc_status; Type: TABLE; Schema: biologging; Owner: postgres
--

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


ALTER TABLE wc_status OWNER TO postgres;

--
-- Name: acoustic_detections id; Type: DEFAULT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY acoustic_detections ALTER COLUMN id SET DEFAULT nextval('acoustic_detections_id_seq'::regclass);


--
-- Name: argos_locations id; Type: DEFAULT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY argos_locations ALTER COLUMN id SET DEFAULT nextval('argos_locations_id_seq'::regclass);


--
-- Name: dbtable gid; Type: DEFAULT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY dbtable ALTER COLUMN gid SET DEFAULT nextval('dbtable_gid_seq'::regclass);


--
-- Name: gls_locations id; Type: DEFAULT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY gls_locations ALTER COLUMN id SET DEFAULT nextval('gls_locations_id_seq'::regclass);


--
-- Name: gps_locations id; Type: DEFAULT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY gps_locations ALTER COLUMN id SET DEFAULT nextval('gps_locations_id_seq'::regclass);


--
-- Name: acoustic_detections acoustic_detections_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY acoustic_detections
    ADD CONSTRAINT acoustic_detections_pkey PRIMARY KEY (id);


--
-- Name: activity_log activity_log_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY activity_log
    ADD CONSTRAINT activity_log_pkey PRIMARY KEY (id);


--
-- Name: animal_capture animal_capture_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal_capture
    ADD CONSTRAINT animal_capture_pkey PRIMARY KEY (id);


--
-- Name: animal_measurements animal_measurements_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal_measurements
    ADD CONSTRAINT animal_measurements_pkey PRIMARY KEY (id);


--
-- Name: animal_observations animal_observations_capture_ukey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal_observations
    ADD CONSTRAINT animal_observations_capture_ukey UNIQUE (capture_id);


--
-- Name: animal_observations animal_observations_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal_observations
    ADD CONSTRAINT animal_observations_pkey PRIMARY KEY (id);


--
-- Name: animal animal_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal
    ADD CONSTRAINT animal_pkey PRIMARY KEY (id);


--
-- Name: argos_locations argos_locations_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY argos_locations
    ADD CONSTRAINT argos_locations_pkey PRIMARY KEY (id);


--
-- Name: device_deployment_recovery device_deployment_recovery_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device_deployment_recovery
    ADD CONSTRAINT device_deployment_recovery_pkey PRIMARY KEY (id);


--
-- Name: device device_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id);


--
-- Name: device_specifications device_specifications_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device_specifications
    ADD CONSTRAINT device_specifications_pkey PRIMARY KEY (id);


--
-- Name: device device_unique; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device
    ADD CONSTRAINT device_unique UNIQUE (manufacturer, model_name, serial_number);


--
-- Name: gls_locations gls_locations_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY gls_locations
    ADD CONSTRAINT gls_locations_pkey PRIMARY KEY (id);


--
-- Name: gps_locations gps_locations_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY gps_locations
    ADD CONSTRAINT gps_locations_pkey PRIMARY KEY (id);


--
-- Name: installation_station installation_name_key; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY installation_station
    ADD CONSTRAINT installation_name_key UNIQUE (installation_name);


--
-- Name: installation_station installation_station_name_key; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY installation_station
    ADD CONSTRAINT installation_station_name_key UNIQUE (installation_name, station_name);


--
-- Name: installation_station installation_station_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY installation_station
    ADD CONSTRAINT installation_station_pkey PRIMARY KEY (id);


--
-- Name: project project_name_key; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_name_key UNIQUE (title);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: project_role project_role_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY project_role
    ADD CONSTRAINT project_role_pkey PRIMARY KEY (id);


--
-- Name: species_atn species_atn_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY species_atn
    ADD CONSTRAINT species_atn_pkey PRIMARY KEY (id);


--
-- Name: species species_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY species
    ADD CONSTRAINT species_pkey PRIMARY KEY (id);


--
-- Name: uploaded_file uploaded_file_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY uploaded_file
    ADD CONSTRAINT uploaded_file_pkey PRIMARY KEY (id);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_name_key UNIQUE (name, email_address);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wc_all_deployment_profiles wc_all_deployment_profiles_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY wc_all_deployment_profiles
    ADD CONSTRAINT wc_all_deployment_profiles_pkey PRIMARY KEY (wc_id, last_update_date);


--
-- Name: wc_all_deployments wc_all_deployments_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY wc_all_deployments
    ADD CONSTRAINT wc_all_deployments_pkey PRIMARY KEY (wc_id, last_update_date);


--
-- Name: wc_all_locations wc_all_locations_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY wc_all_locations
    ADD CONSTRAINT wc_all_locations_pkey PRIMARY KEY (wc_id, date, latitude, longitude);


--
-- Name: wc_all_profiles wc_all_profiles_pkey; Type: CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY wc_all_profiles
    ADD CONSTRAINT wc_all_profiles_pkey PRIMARY KEY (wc_id, date);


--
-- Name: acoustic_detections check_for_acoustic_detections_duplicates; Type: TRIGGER; Schema: biologging; Owner: postgres
--

CREATE TRIGGER check_for_acoustic_detections_duplicates AFTER INSERT OR DELETE ON acoustic_detections FOR EACH ROW EXECUTE PROCEDURE set_acoustic_detections_duplicate_status();


--
-- Name: argos_locations check_for_argos_locations_duplicates; Type: TRIGGER; Schema: biologging; Owner: postgres
--

CREATE TRIGGER check_for_argos_locations_duplicates AFTER INSERT OR DELETE ON argos_locations FOR EACH ROW EXECUTE PROCEDURE set_argos_locations_duplicate_status();


--
-- Name: gls_locations check_for_gls_locations_duplicates; Type: TRIGGER; Schema: biologging; Owner: postgres
--

CREATE TRIGGER check_for_gls_locations_duplicates AFTER INSERT OR DELETE ON gls_locations FOR EACH ROW EXECUTE PROCEDURE set_gls_locations_duplicate_status();


--
-- Name: gps_locations check_for_gps_locations_duplicates; Type: TRIGGER; Schema: biologging; Owner: postgres
--

CREATE TRIGGER check_for_gps_locations_duplicates AFTER INSERT OR DELETE ON gps_locations FOR EACH ROW EXECUTE PROCEDURE set_gps_locations_duplicate_status();


--
-- Name: acoustic_detections acoustic_detections_fkey_uploaded_file; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY acoustic_detections
    ADD CONSTRAINT acoustic_detections_fkey_uploaded_file FOREIGN KEY (file_id) REFERENCES uploaded_file(id);


--
-- Name: activity_log activity_log_fkey_users; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY activity_log
    ADD CONSTRAINT activity_log_fkey_users FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: animal_capture animal_capture_fkey_animal; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal_capture
    ADD CONSTRAINT animal_capture_fkey_animal FOREIGN KEY (animal_id) REFERENCES animal(id);


--
-- Name: animal_capture animal_capture_fkey_catcher; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal_capture
    ADD CONSTRAINT animal_capture_fkey_catcher FOREIGN KEY (catcher_id) REFERENCES users(id);


--
-- Name: animal animal_fkey_species; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal
    ADD CONSTRAINT animal_fkey_species FOREIGN KEY (species_id) REFERENCES species(id);


--
-- Name: animal_measurements animal_measurements_fkey_animal; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal_measurements
    ADD CONSTRAINT animal_measurements_fkey_animal FOREIGN KEY (capture_id) REFERENCES animal_capture(id);


--
-- Name: animal_observations animal_observations_fkey_animal; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY animal_observations
    ADD CONSTRAINT animal_observations_fkey_animal FOREIGN KEY (capture_id) REFERENCES animal_capture(id);


--
-- Name: argos_locations argos_locations_fkey_uploaded_file; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY argos_locations
    ADD CONSTRAINT argos_locations_fkey_uploaded_file FOREIGN KEY (file_id) REFERENCES uploaded_file(id);


--
-- Name: device_deployment_recovery device_deployment_recovery_fkey_animal; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device_deployment_recovery
    ADD CONSTRAINT device_deployment_recovery_fkey_animal FOREIGN KEY (animal_id) REFERENCES animal(id);


--
-- Name: device_deployment_recovery device_deployment_recovery_fkey_device; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device_deployment_recovery
    ADD CONSTRAINT device_deployment_recovery_fkey_device FOREIGN KEY (device_id) REFERENCES device(id);


--
-- Name: device_deployment_recovery device_deployment_recovery_fkey_installation_station; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device_deployment_recovery
    ADD CONSTRAINT device_deployment_recovery_fkey_installation_station FOREIGN KEY (installation_station_id) REFERENCES installation_station(id);


--
-- Name: device_deployment_recovery device_deployment_recovery_fkey_recoverer; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device_deployment_recovery
    ADD CONSTRAINT device_deployment_recovery_fkey_recoverer FOREIGN KEY (recoverer_id) REFERENCES users(id);


--
-- Name: device_deployment_recovery device_deployment_recovery_fkey_tagger; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device_deployment_recovery
    ADD CONSTRAINT device_deployment_recovery_fkey_tagger FOREIGN KEY (deployer_id) REFERENCES users(id);


--
-- Name: device device_fkey_project; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device
    ADD CONSTRAINT device_fkey_project FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: device_specifications device_specifications_fkey_device; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY device_specifications
    ADD CONSTRAINT device_specifications_fkey_device FOREIGN KEY (device_id) REFERENCES device(id);


--
-- Name: gls_locations gls_locations_fkey_uploaded_file; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY gls_locations
    ADD CONSTRAINT gls_locations_fkey_uploaded_file FOREIGN KEY (file_id) REFERENCES uploaded_file(id);


--
-- Name: gps_locations gps_locations_fkey_uploaded_file; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY gps_locations
    ADD CONSTRAINT gps_locations_fkey_uploaded_file FOREIGN KEY (file_id) REFERENCES uploaded_file(id);


--
-- Name: installation_station installation_station_fkey_project; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY installation_station
    ADD CONSTRAINT installation_station_fkey_project FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_role project_role_fkey_project; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY project_role
    ADD CONSTRAINT project_role_fkey_project FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: project_role project_role_fkey_users; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY project_role
    ADD CONSTRAINT project_role_fkey_users FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: uploaded_file uploaded_file_fkey_users; Type: FK CONSTRAINT; Schema: biologging; Owner: postgres
--

ALTER TABLE ONLY uploaded_file
    ADD CONSTRAINT uploaded_file_fkey_users FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: biologging; Type: ACL; Schema: -; Owner: biologging
--

GRANT ALL ON SCHEMA biologging TO jeg;


--
-- Name: species; Type: ACL; Schema: biologging; Owner: postgres
--

GRANT ALL ON TABLE species TO jeg;


--
-- PostgreSQL database dump complete
--

