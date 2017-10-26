
# Database Schema files

## WC Tables
### wc.tables.sql: 

## Postgres (refresh) Functions
### The WC api retrieves all current data from the WC portal,
### data is loaded into tmp_* tables, which are then copied into
### the final destination tables.
### All tables:
#### atn_all_argos.sql

### refresh_all_deployment_profiles.sql
### refresh_all_deployments.sql
### refresh_all_locations.sql
### refresh_all_profiles.sql

## Original biologging schema
### The orginal "common" "core II" schema developed in cooperation
### with US ATN and Australian IMOS organizations is defined within
### the dump.biologging.schema.sql.
###
### Initially, we will not be modifying this schema, just adding to
### the core as needed as we build a new framework to support our 
### existing data, plus additions to the schema to support new data
### formats coming from WC.
###

## Registration tables (user registration update 8/17)
### atn.registration.sql:
#### atn_contact
#### atn_organisation
#### atn_organisation_project
#### atn_project
#### atn_project_user_role
#### atn_user
#### atn_user_role
#### 

