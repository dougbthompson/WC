CREATE OR REPLACE FUNCTION refresh_wc_all_deployment_profiles()
RETURNS integer AS $$

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
$$ LANGUAGE plpgsql volatile;

