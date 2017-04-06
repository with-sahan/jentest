SET search_path = "slammer";

SELECT setval('seq_id_users', (SELECT COALESCE(MAX(id)+1,1) FROM  "users")) ;
