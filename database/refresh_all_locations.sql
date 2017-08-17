CREATE OR REPLACE FUNCTION refresh_wc_all_locations()
RETURNS integer AS $$

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
$$ LANGUAGE plpgsql volatile;

