\c tap_schema;

COPY ivoa.obscore (access_estsize,access_format,access_url,calib_level,dataproduct_subtype,dataproduct_type,em_max,em_min,em_res_power,em_xel,facility_name,instrument_name,o_ucd,obs_collection,obs_id,obs_publisher_did,pol_states,pol_xel,proposal_id,s_dec,s_fov,s_ra,s_region,s_resolution,s_xel1,s_xel2,t_exptime,t_max,t_min,t_resolution,t_xel,target_name) FROM PROGRAM 'gunzip -c /docker-entrypoint-initdb.d/allwise-coadds-all-fixed.csv.gz' WITH (FORMAT CSV, DELIMITER ',', HEADER true, NULL 'NULL');
