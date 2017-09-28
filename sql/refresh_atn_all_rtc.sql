
CREATE OR REPLACE FUNCTION refresh_atn_all_rtc()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3, v4, v5, v6 FROM biologging.wc_zip_rtc;

    v_wc_id            text;
    v_deployid         text;
    v_ptt              integer;
    v_instrument       text;
    v_correction_type  text;
    v_tag_date         text;
    v_tag_time         text;

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_deployid, v_ptt, v_instrument, v_correction_type, v_tag_date, v_tag_time;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_rtc a
            where a.wc_id           = v_wc_id
              and a.deployid        = v_deployid
              and a.ptt             = v_ptt
              and a.instrument      = v_instrument
              and a.correction_type = v_correction_type
              and a.tag_date        = v_tag_date
              and a.tag_time        = v_tag_time)
        then
            insert into biologging.atn_all_rtc (wc_id, deployid, ptt, instrument, correction_type,
                   tag_date, tag_time, real_date, real_time)

            select wc_id,v1,v2,v3,v4,v5,v6,v7,v8
              from biologging.wc_zip_rtc a
             where a.wc_id  = v_wc_id
               and a.v1     = v_deployid
               and a.v2     = v_ptt
               and a.v3     = v_instrument
               and a.v4     = v_correction_type
               and a.v5     = v_tag_date
               and a.v6     = v_tag_time
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

