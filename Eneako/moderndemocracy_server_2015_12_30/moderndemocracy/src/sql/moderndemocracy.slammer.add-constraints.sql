SET search_path = "slammer";

ALTER TABLE ONLY "users"
ADD CONSTRAINT "users_pkey"
PRIMARY KEY ("id");

ALTER TABLE ONLY "sessions"
ADD CONSTRAINT "sessions_pkey"
PRIMARY KEY ("id");

ALTER TABLE ONLY "sessions"
ADD CONSTRAINT "fk_sessions_link_user"
FOREIGN KEY ("user_id") REFERENCES "users"("id") ON UPDATE CASCADE ON DELETE CASCADE;
