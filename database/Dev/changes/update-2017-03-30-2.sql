/*Remove duplicate records from psm.list_category table in order to avoid unexpected behaviour on psi check list */

DELETE a 
FROM psm.list_category as a, psm.list_category as b 
WHERE (a.organization_id   = b.organization_id OR a.organization_id IS NULL AND b.organization_id IS NULL) 
      AND (a.name = b.name OR a.name IS NULL AND b.name IS NULL) 
      AND (a.list_order = b.list_order OR a.list_order IS NULL AND b.list_order IS NULL) 
      AND a.id > b.id;