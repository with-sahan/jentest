
--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE SCHEMA "slammer";

SET search_path = "slammer", pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: updated_on_timestamp(); Type: FUNCTION; Schema: xxx; Owner: -
--
CREATE FUNCTION "updated_on_timestamp"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.updated_on = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


-------------
--- USERS ---
-------------
DROP TABLE  IF EXISTS "users";
CREATE TABLE "users" (
	"id" integer NOT NULL,
	"role_id" integer NOT NULL DEFAULT 1,
	"council_id" integer NOT NULL DEFAULT 0,
	"client_platform" "text",
	"client_build_number" "text",
	"login_name" "text" NOT NULL,
	"secret" "text",
    "api_key" "text",
    "encryption" character varying(16) DEFAULT 'None'::character varying,
    "uri" "text",
    "first_name" "text" NOT NULL DEFAULT '',
    "last_name" "text" NOT NULL DEFAULT '',
    "age" integer,
    "birthday" "text",
    "gender" "text",
	"timezone" "text" DEFAULT 'GMT',
	"locale" character varying(16) DEFAULT 'en_GB',
    "status" integer NOT NULL DEFAULT 0,
    "login_count" integer NOT NULL DEFAULT 0,
    "station_id" integer NOT NULL DEFAULT 0,
    "created_on" timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    "updated_on" timestamp with time zone
);

CREATE SEQUENCE "seq_id_users"
    START WITH 600000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE "seq_id_users"
OWNED BY "users"."id";

ALTER TABLE ONLY "users"
ALTER COLUMN "id"
SET DEFAULT "nextval"('"seq_id_users"'::"regclass");

ALTER TABLE ONLY "users"
ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "unique_login_name"
ON "users" USING "btree" ("login_name");

CREATE TRIGGER "on_update_users"
BEFORE UPDATE ON "users"
FOR EACH ROW EXECUTE PROCEDURE "updated_on_timestamp"();


----------------
--- SESSIONS ---
----------------
DROP TABLE  IF EXISTS "sessions";
CREATE TABLE "sessions" (
    "id" character varying(128) NOT NULL,
    "user_id" integer NOT NULL,
    "created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "expires_on" timestamp with time zone,
    "updated_on" timestamp with time zone,
    "origin" character varying(40),
    "agent" "text"
);

ALTER TABLE ONLY "sessions"
ADD CONSTRAINT "sessions_pkey" PRIMARY KEY ("id");

CREATE INDEX "unique_sessions_link_user"
ON "sessions" USING "btree" ("user_id");

CREATE TRIGGER "on_update_sessions"
BEFORE UPDATE ON "sessions"
FOR EACH ROW EXECUTE PROCEDURE "updated_on_timestamp"();

ALTER TABLE ONLY "sessions"
ADD CONSTRAINT "fk_sessions_link_user"
FOREIGN KEY ("user_id") REFERENCES "users"("id") ON UPDATE CASCADE ON DELETE CASCADE;


------------------
--- REALM_AUTH ---
------------------
DROP TABLE  IF EXISTS "realm_auth";
CREATE TABLE "realm_auth" (
    "realm" integer NOT NULL,
    "role" integer DEFAULT 0 NOT NULL,
    "updated_on" timestamp with time zone
);

COMMENT ON COLUMN "realm_auth"."role" IS 'the default role, 0, is for an unprivilleged user';


--------------
--- REALMS ---
--------------
DROP TABLE  IF EXISTS "realms";
CREATE TABLE "realms" (
    "id" serial PRIMARY KEY,
    "name" character varying(64) NOT NULL,
    "priority" integer DEFAULT 10 NOT NULL,
    "methods" "text" DEFAULT 'GET,POST,PATCH,PUT,DELETE,HEAD,OPTIONS'::"text" NOT NULL,
    "url_patterns" "text" DEFAULT '*'::"text" NOT NULL,
    "updated_on" timestamp with time zone
);


------------
--- ROLE ---
------------
DROP TABLE  IF EXISTS "role";
CREATE TABLE "role" (
	"id" serial PRIMARY KEY,
	"bitmask" integer NOT NULL,
	"title" "text" NOT NULL,
	"created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_on" timestamp with time zone
);

---------------
--- COUNCIL ---
---------------
DROP TABLE  IF EXISTS "council";
CREATE TABLE "council" (
	"id" serial PRIMARY KEY,
	"title" "text" NOT NULL,
	"area_name" "text" NOT NULL,
	"logo_url" "text" DEFAULT NULL,
	"created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_on" timestamp with time zone
);
        
--------------------------
--- STATION SETUP LIST ---
--------------------------
DROP TABLE IF EXISTS "station_setup_list";
CREATE TABLE "station_setup_list" (
        "id" serial PRIMARY KEY,
        "council_id" integer NOT NULL,
        "text" "text" NOT NULL,
        "order_id" integer DEFAULT 0 NOT NULL,
        "status" boolean DEFAULT false NOT NULL
);

------------------
--- ISSUE LIST ---
------------------
DROP TABLE IF EXISTS "issue_list";
CREATE TABLE "issue_list" (
        "id" serial PRIMARY KEY,
        "council_id" integer NOT NULL,
        "text" "text" NOT NULL,
        "order_id" integer DEFAULT 0 NOT NULL,
        "email" "text" NOT NULL,
        "status" boolean DEFAULT true NOT NULL
);


------------
--- WARD ---
------------
DROP TABLE IF EXISTS "ward";
CREATE TABLE "ward" (
        "id" serial PRIMARY KEY,
        "name" "text" NOT NULL,
        "council_id" integer NOT NULL,
        "status" integer DEFAULT 1 NOT NULL
);

----------------
--- STATION  ---
----------------
DROP TABLE IF EXISTS "polling_station";
CREATE TABLE "polling_station" (
        "id" serial PRIMARY KEY,
        "name" "text" NOT NULL,
        "polling_place_id" integer DEFAULT 0 NOT NULL,
        
        "ballot_papers_issued" integer DEFAULT NULL,
        "postal_packs_received" integer DEFAULT NULL,
        "postal_packs_awaiting_collection" integer DEFAULT NULL,
        
        "ordinary_total_issued" integer DEFAULT NULL,
        "ordinary_number_of_replacements" integer DEFAULT NULL,
        "ordinary_cals_issued_and_not_spoilt" integer DEFAULT NULL,
        "ordinary_total_unused" integer DEFAULT NULL,
        "tendered_total_issued" integer DEFAULT NULL,
        "tendered_total_spoilt" integer DEFAULT NULL,
        "tendered_total_unused" integer DEFAULT NULL,
        
        "dispatch_time" timestamp with time zone DEFAULT NULL,
        "deliver_time" timestamp with time zone DEFAULT NULL,
        "eta" time DEFAULT NULL,
        
        "ballot_box_no" "text" NOT NULL
);

----------------------------
--- STATION SETUP STATUS ---
----------------------------
DROP TABLE IF EXISTS "station_setup_status";
CREATE TABLE "station_setup_status" (
        "id" serial PRIMARY KEY,
        "station_id" integer DEFAULT 0 NOT NULL,
        "station_setup_list_id" integer DEFAULT 0 NOT NULL,
        "status" boolean DEFAULT false NOT NULL
);

--------------------
--- ISSUE RECORD ---
--------------------
DROP TABLE IF EXISTS "issues";
CREATE TABLE "issues" (
        "id" serial PRIMARY KEY,
        "council_id" integer NOT NULL,
        "reason" "text" NOT NULL,
        "description" "text",
        "priority" "text" NOT NULL,
        "station_id" integer NOT NULL,
        "created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
        "resolution" "text" DEFAULT NULL,
        "status" boolean DEFAULT false NOT NULL
);

---------------------------
--- NOTIFICATION RECORD ---
---------------------------
DROP TABLE IF EXISTS "notifications";
CREATE TABLE "notifications" (
        "id" serial PRIMARY KEY,
        "text" "text" NOT NULL,
        "user_id" integer NOT NULL,
        "council_id" integer NOT NULL,
        "station_id" integer NOT NULL,
        "created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
        "status" integer DEFAULT NULL,
         "url" "text" DEFAULT NULL
);

DROP TABLE IF EXISTS "notifications_received";
CREATE TABLE "notifications_received" (
		"id" serial PRIMARY KEY,
		"notification_id" integer NOT NULL,
		"station_id" integer NOT NULL,
		"status" integer DEFAULT NULL,
        "user_id" integer NOT NULL
);

----------------
--- TRACKING ---
----------------
DROP TABLE IF EXISTS "tracking";
CREATE TABLE "tracking" (
        "id" serial PRIMARY KEY,
        "station_id" integer DEFAULT 0 NOT NULL,
        "council_id" integer NOT NULL,
        "lat" float DEFAULT 0 NOT NULL,
        "lng" float DEFAULT 0 NOT NULL,
        "status" integer DEFAULT 0 NOT NULL,
        "created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
        "updated_on" timestamp with time zone
);

CREATE TRIGGER "on_update_tracking"
BEFORE UPDATE ON "tracking"
FOR EACH ROW EXECUTE PROCEDURE "updated_on_timestamp"();

--------------------
--- USER STATION ---
--------------------
CREATE TABLE "user_station" (
	"id" serial PRIMARY KEY,
	"user_id" integer NOT NULL,
	"station_id" integer NOT NULL,
	"created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_on" timestamp with time zone
);

--------------------
--- USER WARD ---
--------------------
CREATE TABLE "user_ward" (
	"id" serial PRIMARY KEY,
	"user_id" integer NOT NULL,
	"ward_id" integer NOT NULL,
	"created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_on" timestamp with time zone
);

---------------------
--- POLLING PLACE ---
---------------------
CREATE TABLE "polling_place" (
	"id" serial PRIMARY KEY,
	"name" "text" NOT NULL,
	"polling_district_id" integer NOT NULL,
	"created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_on" timestamp with time zone
);

------------------------
--- POLLING DISTRICT ---
------------------------
CREATE TABLE "polling_district" (
	"id" serial PRIMARY KEY,
	"name" "text" NOT NULL,
	"polling_ward_id" integer NOT NULL,
	"created_on" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updated_on" timestamp with time zone
);

