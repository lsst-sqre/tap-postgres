
-- grant usage on schema tap_schema to ''@'%';

CREATE USER tap_schema WITH ENCRYPTED PASSWORD 'pw-tapschema';
CREATE DATABASE tap_schema WITH OWNER tap_schema;

\c tap_schema
CREATE SCHEMA tap_schema AUTHORIZATION tap_schema;
CREATE SCHEMA ivoa AUTHORIZATION tap_schema;

CREATE EXTENSION citext;
CREATE EXTENSION pg_sphere;
