CREATE OR REPLACE FUNCTION refresh_wc_all_profiles()
RETURNS integer AS $$

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
                         "bin.depth.1"::text, "bin.depth.2"::text, "bin.depth.3"::text,
                         "bin.depth.4"::text, "bin.depth.5"::text, "bin.depth.6"::text,
                         "bin.depth.7"::text, "bin.depth.8"::text, "bin.depth.9"::text,
                         "bin.depth.10"::text]
              into v_bin
              from tmp_all_profiles
             where wc_id  = v_row.wc_id
               and date   = v_row.date
             limit 1;

            select array["bin.temperature"::text, 
                         "bin.temperature.1"::text, "bin.temperature.2"::text, "bin.temperature.3"::text,
                         "bin.temperature.4"::text, "bin.temperature.5"::text, "bin.temperature.6"::text,
                         "bin.temperature.7"::text, "bin.temperature.8"::text, "bin.temperature.9"::text,
                         "bin.temperature.10"::text]
              into v_temperature
              from tmp_all_profiles
             where wc_id  = v_row.wc_id
               and date   = v_row.date
             limit 1;

            select array["bin.discontinuity"::text, 
                         "bin.discontinuity.1"::text, "bin.discontinuity.2"::text, "bin.discontinuity.3"::text,
                         "bin.discontinuity.4"::text, "bin.discontinuity.5"::text, "bin.discontinuity.6"::text,
                         "bin.discontinuity.7"::text, "bin.discontinuity.8"::text, "bin.discontinuity.9"::text,
                         "bin.discontinuity.10"::text]
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
$$ LANGUAGE plpgsql volatile;

