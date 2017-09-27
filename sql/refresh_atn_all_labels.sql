
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_labels()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1 FROM biologging.wc_zip_labels;

    v_wc_id   text;
    v_key     text;
    v_values  text[];
    

BEGIN
    open curs1;

    loop
    fetch curs1 into v_wc_id, v_key;
        exit when not found;

        if not exists (
           select 1
             from biologging.atn_all_labels a
            where a.wc_id   = v_wc_id
              and a.key     = v_key)
        then

            select array[ v2, v3 ]
              into v_values
              from biologging.wc_zip_labels a
             where a.wc_id  = v_wc_id
               and a.v1     = v_key
             limit 1;

            insert into biologging.atn_all_labels (wc_id, key, values)
            select wc_id, v1, v_values
              from biologging.wc_zip_labels a
             where a.wc_id  = v_wc_id
               and a.v1     = v_key
             limit 1;

        end if;
    end loop;
    close curs1;

    return 1;
END;
$$ LANGUAGE plpgsql volatile;

