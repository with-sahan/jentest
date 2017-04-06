SET search_path = "slammer";

ALTER TABLE ONLY "users"
DROP CONSTRAINT "users_pkey" CASCADE;

ALTER TABLE ONLY "sessions"
DROP CONSTRAINT "sessions_pkey" CASCADE;

-- ALTER TABLE ONLY "sessions"
-- DROP CONSTRAINT "fk_sessions_link_user" CASCADE;
