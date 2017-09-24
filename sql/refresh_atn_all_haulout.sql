
CREATE OR REPLACE FUNCTION refresh_wc_atn_all_haulout()
RETURNS integer AS $$
  
DECLARE
    curs1 CURSOR FOR
    SELECT wc_id, v1, v2, v3 FROM biologging.wc_zip_haulout;
BEGIN
    return 1;
END;
$$ LANGUAGE plpgsql volatile;

