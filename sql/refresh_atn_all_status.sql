
CREATE OR REPLACE FUNCTION refresh_atn_all_status()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v4, v6, v7 FROM biologging.wc_zip_status;

    v_wc_id        text;
    v_deployid     text;
    v_ptt          integer;
    v_instrument   text;
    v_received     text;
    v_time_offset  text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_received, v_time_offset;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_status a
            where a.wc_id       = v_wc_id
              and a.deployid    = v_deployid
              and a.ptt         = v_ptt
              and a.instrument  = v_instrument
              and a.received    = v_received
              and a.time_offset = v_time_offset)
        then
            insert into biologging.atn_all_status (wc_id, deployid, ptt, depth_sensor, instrument, sw, rtc, received,
            time_offset, location_quality, latitude, longitude, data_type, hauled_out, broken_thermistor, broken_link,
            transmits, battery_voltage, transmit_voltage, transmit_current, temperature, depth, max_depth, zero_depth_offset,
            light_level, no_dawn_dusk, release_type, release_time, initially_broken, burn_minutes, release_depth, fast_gps_power,
            twic_power, power_limit, wet_dry, wet_dry_min, wet_dry_max, wet_dry_threshold, status_word, transmit_power, resets,
            pre_rel_tilt, pre_rel_tilt_sd, pre_rel_tilt_count, xmit_queue, fast_gps_loc_number, fast_gps_failures, battery_disconnect)

            select wc_id,v1,v2,v3,v4,v5,v6,v7,nullf(v8,'')::integer,v9,v10,v11,v12,v13,v14,v15,v16,v17,v18,v19,
                   nullif(v20,'')::double precision, nullif(v21,'')::double precision, v22, nullif(v23,'')::double precision,
                   nullif(v24,'')::double precision, nullif(v25,'')::double preciscion,v26,v27,v28,nullif(v29,'')::integer,
                   nullif(v30,'')::integer,v31,v32,nullif(v33,'')::integer,v34,v35,v36,v37,v38,v39,v40,v41,v42,v43,v44,
                   nullif(v45,'')::integer,nullif(v46,'')::integer,v47,v48

              from biologging.wc_zip_status a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v4     = v_instrument
               and a.v6     = v_received
               and a.v7     = v_time_offset
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

