
CREATE OR REPLACE FUNCTION refresh_atn_all_summary()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v15, v16 FROM biologging.wc_zip_summary;

    v_wc_id               text;
    v_deployid            text;
    v_ptt                 integer;
    v_instrument          text;
    v_xmit_time_earliest  text;
    v_xmit_time_latest    text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_xmit_time_earliest, v_xmit_time_latest;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_summary a
            where a.wc_id              = v_wc_id
              and a.deployid           = v_deployid
              and a.ptt                = v_ptt
              and a.instrument         = v_instrument
              and a.xmit_time_earliest = v_xmit_time_earliest
              and a.xmit_time_latest   = v_xmit_time_latest)
        then
            insert into biologging.atn_all_summary (wc_id, deployid, ptt, instrument, sw, percent_decoded,
                   passes, percent_argos_loc, message_per_pass, ds, di, power_min, power_avg, power_max,
                   min_interval, xmit_time_earliest, xmit_time_latest, xmit_days, data_time_earliest,
                   data_time_latest, data_days, release_date, release_type, deploy_date)

            select wc_id,v1,v2,v3,v4,v5,v6,v7,v8,v9,nullif(v10,'')::integer,v11,v12,v13,v14,v15,v16,
                   v17,v18,v19,v20,v21,v22,v23,v24

              from biologging.wc_zip_summary a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_instrument
               and a.v15    = v_xmit_time_earliest
               and a.v16    = v_xmit_time_latest
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

