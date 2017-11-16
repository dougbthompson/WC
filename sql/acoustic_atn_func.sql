
CREATE OR REPLACE FUNCTION acoustic_atn_func (p_start_date text, p_end_date text)
RETURNS integer AS $$

DECLARE
    v_last_update_date integer;
    v_wc_id            text;

BEGIN

    if p_start_date is null
    then
        p_start_date = ('now'::text::date - 90);
    end if;

    if p_end_date is null
    then
        p_end_date   = ('now'::text::date);
    end if;

    select ad.code           as code,
           count(ad.code)    as detections,
           ast.station_site  as site,
           ast.station_name  as station,
           round(cast(avg(ast.longitude) as numeric),4) as longitude,
           round(cast(avg(ast.latitude)  as numeric),4) as latitude,
           am.commonname     as commonname
      from atn_acoustic_data ad,
           atn_acoustic_station ast,
           atn_acoustic_meta am
     where ad.receiver        = ast.receiver
       and ad.receiver_dnum   = ast.receiver_dnum
       and ad.ping_detection  > p_start_date
       and ad.ping_detection <= p_end_date
       and ad.false_hit       = 0
       and am.ptt             = ad.code
       and am.commonname     <> ''
       and ast.station_site in ('Ano Nuevo','Palmyra','Tomales')
     group by 1,3,4,7
     order by 3,4,1;

END;
$$ LANGUAGE plpgsql volatile;
