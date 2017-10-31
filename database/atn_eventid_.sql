
drop table if exists atn_eventid;
create table atn_eventid (
  id                     serial,
  eventid                integer,
  column_name            text,
  table_name             text,
  table_schema           text,
  toppid                 integer,
  ptt                    integer,
  local_deployment_name  text,
  animal_name            text,
  tag_manufacturer       text,
  tag_serial_number      text,
  deployment_date        timestamp,
  tag_model              text
);

drop table if exists atn_eventid_details;
create table atn_eventid_details (
  atn_ev_details_id      serial,
  atn_ev_id              integer,
  atn_table_name         text,
  atn_ev_details         jsonb
);

insert into atn_eventid_details (atn_ev_id, atn_ev_details) values(2, '{
    "guid"      : "9c36adc1-7fb5-4d5b-83b4-90356a46061a",
    "name"      : "Angela Barton",
    "is_active" : true,
    "company"   : "Magnafone",
    "address"   : "178 Howard Place, Gulf, Washington, 702",
    "registered": "2009-11-07T08:53:22 +08:00",
    "latitude"  : 19.793713,
    "longitude" : 86.513373,
    "tags": [ "enim", "aliquip", "qui" ]
}');


topp=# \d+ eventid_union
                               View "public.eventid_union"
        Column         |            Type             | Modifiers | Storage  | Description 
-----------------------+-----------------------------+-----------+----------+-------------
 eventid               | integer                     |           | plain    | 
 column_name           | text                        |           | extended | 
 table_name            | text                        |           | extended | 
 table_schema          | text                        |           | extended | 
 toppid                | integer                     |           | plain    | 
 ptt                   | integer                     |           | plain    | 
 local_deployment_name | text                        |           | extended | 
 animal_name           | text                        |           | extended | 
 tag_manufacturer      | text                        |           | extended | 
 tag_serial_number     | text                        |           | extended | 
 deployment_date       | timestamp without time zone |           | plain    | 
 tag_model             | text                        |           | extended | 
View definition:
 SELECT x.eventid,
    x.column_name,
    x.table_name,
    x.table_schema,
    x.toppid,
    x.ptt,
    x.local_deployment_name,
    x.animal_name,
    x.tag_manufacturer,
    x.tag_serial_number,
    x.deployment_date,
    x.tag_model
   FROM ( SELECT satdeployments.eventid,
            'eventid'::text AS column_name,
            'satdeployments'::text AS table_name,
            'public'::text AS table_schema,
            satdeployments.eventid / 100 AS toppid,
            satdeployments.pttnumber AS ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            satdeployments.startdate::timestamp without time zone AS deployment_date,
            satdeployments.modelname AS tag_model
           FROM satdeployments
        UNION ALL
         SELECT tblfgsatdeployments.fgsdkey AS eventid,
            'fgsdkey'::text AS column_name,
            'tblfgsatdeployments'::text AS table_name,
            'public'::text AS table_schema,
            tblfgsatdeployments.fgsdkey / 100 AS toppid,
            tblfgsatdeployments.ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tblfgsatdeployments.localtaggingdate::timestamp without time zone AS deployment_date,
            tblfgsatdeployments.contag1number AS tag_model
           FROM tblfgsatdeployments
        UNION ALL
         SELECT tbltgsatdeployment.tgsdkey::integer AS eventid,
            'tgsdkey'::text AS column_name,
            'tbltgsatdeployment'::text AS table_name,
            'public'::text AS table_schema,
            tbltgsatdeployment.tgsdkey::integer / 100 AS toppid,
            tbltgsatdeployment.tag1ptt::integer AS ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tbltgsatdeployment.startdate::timestamp without time zone AS deployment_date,
            tbltgsatdeployment.tag1code AS tag_model
           FROM tbltgsatdeployment
        UNION ALL
         SELECT tbltgsmrudeployments.tgdeploykey::integer AS eventid,
            'tgdeploykey'::text AS column_name,
            'tbltgsmrudeployments'::text AS table_name,
            'public'::text AS table_schema,
            tbltgsmrudeployments.tgdeploykey::integer / 100 AS toppid,
            tbltgsmrudeployments.ptt::integer AS ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tbltgsmrudeployments.dep_date::timestamp without time zone AS deployment_date,
            tbltgsmrudeployments.reff AS tag_model
           FROM tbltgsmrudeployments
        UNION ALL
         SELECT tblsharkdeployment.sgdepkey AS eventid,
            'sgdepkey'::text AS column_name,
            'tblsharkdeployment'::text AS table_name,
            'public'::text AS table_schema,
            tblsharkdeployment.sgdepkey / 100 AS toppid,
            tblsharkdeployment.ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tblsharkdeployment.taggingdate::timestamp without time zone AS deployment_date,
            tblsharkdeployment.contag1number AS tag_model
           FROM tblsharkdeployment
        UNION ALL
         SELECT tblsatdeployments.eventid,
            'eventid'::text AS column_name,
            'tblsatdeployments'::text AS table_name,
            'public'::text AS table_schema,
            tblsatdeployments.eventid / 100 AS toppid,
            tblsatdeployments.pttnumber AS ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tblsatdeployments.startdate::timestamp without time zone AS deployment_date,
            tblsatdeployments.modelname AS tag_model
           FROM tblsatdeployments
        UNION ALL
         SELECT tbltrccsatdeployment.fgsdkey AS eventid,
            'fgsdkey'::text AS column_name,
            'tbltrccsatdeployment'::text AS table_name,
            'public'::text AS table_schema,
            tbltrccsatdeployment.fgsdkey / 100 AS toppid,
            tbltrccsatdeployment.ptt::integer AS ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tbltrccsatdeployment.taggingdate::timestamp without time zone AS deployment_date,
            tbltrccsatdeployment.tagmodel AS tag_model
           FROM tbltrccsatdeployment
        UNION ALL
         SELECT tblsgarchivaldeployment.sgdepkey AS eventid,
            'sgdepkey'::text AS column_name,
            'tblsgarchivaldeployment'::text AS table_name,
            'public'::text AS table_schema,
            tblsgarchivaldeployment.sgdepkey / 100 AS toppid,
            NULL::integer AS ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tblsgarchivaldeployment.taggingdate::timestamp without time zone AS deployment_date,
            tblsgarchivaldeployment.contag1number AS tag_model
           FROM tblsgarchivaldeployment
        UNION ALL
         SELECT tbltrccarchivaldeployment.fgadkey AS eventid,
            'fgadkey'::text AS column_name,
            'tbltrccarchivaldeployment'::text AS table_name,
            'public'::text AS table_schema,
            tbltrccarchivaldeployment.fgadkey / 100 AS toppid,
            NULL::integer AS ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tbltrccarchivaldeployment.taggingdate::timestamp without time zone AS deployment_date,
            tbltrccarchivaldeployment.tagmodel AS tag_model
           FROM tbltrccarchivaldeployment
        UNION ALL
         SELECT tblfgarchivaldeployment.fgadkey AS eventid,
            'fgadkey'::text AS column_name,
            'tblfgarchivaldeployment'::text AS table_name,
            'public'::text AS table_schema,
            tblfgarchivaldeployment.fgadkey / 100 AS toppid,
            NULL::integer AS ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tblfgarchivaldeployment.taggingdate::timestamp without time zone AS deployment_date,
            tblfgarchivaldeployment.contag1number AS tag_model
           FROM tblfgarchivaldeployment
        UNION ALL
         SELECT tbltgarchivaldeployment.tgadkey::integer AS eventid,
            'tgadkey'::text AS column_name,
            'tbltgarchivaldeployment'::text AS table_name,
            'public'::text AS table_schema,
            tbltgarchivaldeployment.tgadkey::integer / 100 AS toppid,
            NULL::integer AS ptt,
            NULL::text AS local_deployment_name,
            NULL::text AS animal_name,
            NULL::text AS tag_manufacturer,
            NULL::text AS tag_serial_number,
            tbltgarchivaldeployment.startdate::timestamp without time zone AS deployment_date,
            tbltgarchivaldeployment.tag1code AS tag_model
           FROM tbltgarchivaldeployment) x
  WHERE x.eventid >= 100000000;


satdeployments             .eventid
tblfgsatdeployments        .fgsdkey               AS eventid,
tbltgsatdeployment         .tgsdkey     ::integer AS eventid,
tbltgsmrudeployments       .tgdeploykey ::integer AS eventid,
tblsharkdeployment         .sgdepkey              AS eventid,
tblsatdeployments          .eventid
tbltrccsatdeployment       .fgsdkey               AS eventid,
tblsgarchivaldeployment    .sgdepkey              AS eventid,
tbltrccarchivaldeployment  .fgadkey               AS eventid,
tblfgarchivaldeployment    .fgadkey               AS eventid,
tbltgarchivaldeployment    .tgadkey     ::integer AS eventid,


SELECT satdeployments.eventid       AS eventid,
       'eventid'::text              AS column_name,
       'satdeployments'::text       AS table_name,
       'public'::text               AS table_schema,
       satdeployments.eventid / 100 AS toppid,
       satdeployments.pttnumber     AS ptt,
       NULL::text                   AS local_deployment_name,
       NULL::text                   AS animal_name,
       NULL::text                   AS tag_manufacturer,
       NULL::text                   AS tag_serial_number,
       satdeployments.startdate::timestamp without time zone AS deployment_date,
       satdeployments.modelname     AS tag_model
  FROM satdeployments

  Table "public.satdeployments"
      Column      |          Type          |                                Modifiers                                 
  ----------------+------------------------+--------------------------------------------------------------------------
  satdeploymentid | integer                | not null default nextval('satdeployments_satdeploymentid_seq'::regclass)
  toppid          | text                   | 
* pttnumber       | integer                | 
  speciesname     | text                   | 
  startdate       | date                   | 
  enddate         | date                   | 
  actualpopupdate | date                   | 
  tagnumber       | text                   | 
  comment         | text                   | 
  contact         | text                   | 
  projectname     | text                   | 
* modelname       | text                   | 
  testingnote     | text                   | 
  owner           | text                   | 
* eventid         | integer                | 
  las             | text                   | 
  tagcode         | character varying(50)  | 
* starttime       | time without time zone | 
  endtime         | time without time zone | 
  est_end_date    | date                   | 


atndb=# select json_build_object(ordinal_position, column_name) from information_schema.columns where table_name = 'atn_eventid';
        json_build_object        
---------------------------------
 { "1" : "id"}
 { "2" : "eventid"}
 { "3" : "column_name"}
 { "4" : "table_name"}
 { "5" : "table_schema"}
 { "6" : "toppid"}
 { "7" : "ptt"}
 { "8" : "local_deployment_name"}
 { "9" : "animal_name"}
 {"10" : "tag_manufacturer"}
 {"11" : "tag_serial_number"}
 {"12" : "deployment_date"}
 {"13" : "tag_model"}

atndb=# 
select json_build_object('id',id, 'eventid',eventid, 'column_name',column_name, 'table_name',table_name,
                         'table_schema',table_schema, 'toppid',toppid)
  from atn_eventid
 limit 4;
                                                              json_build_object                                                               
----------------------------------------------------------------------------------------------------------------------------------------------
 {"id" : 1, "eventid" : 101700401, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1017004}
 {"id" : 2, "eventid" : 101700501, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1017005}
 {"id" : 3, "eventid" : 101700601, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1017006}
 {"id" : 4, "eventid" : 100513200, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1005132}

> dbGetQuery (db_connection, "select json_build_object('id',id, 'eventid',eventid, 'column_name',column_name, 'table_name',table_name, 'table_schema',table_schema, 'toppid',toppid) from atn_eventid limit 4;")
                                                                                                                             json_build_object
1 {"id" : 1, "eventid" : 101700401, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1017004}
2 {"id" : 2, "eventid" : 101700501, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1017005}
3 {"id" : 3, "eventid" : 101700601, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1017006}
4 {"id" : 4, "eventid" : 100513200, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1005132}
Warning message:
In postgresqlExecStatement(conn, statement, ...) :
  RS-DBI driver warning: (unrecognized PostgreSQL field type json (id:114) in column 0)
> dbGetQuery (db_connection, "select json_build_object('id',id, 'eventid',eventid, 'column_name',column_name, 'table_name',table_name, 'table_schema',table_schema, 'toppid',toppid)::text from atn_eventid limit 4;")
                                                                                                                             json_build_object
1 {"id" : 1, "eventid" : 101700401, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1017004}
2 {"id" : 2, "eventid" : 101700501, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1017005}
3 {"id" : 3, "eventid" : 101700601, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1017006}
4 {"id" : 4, "eventid" : 100513200, "column_name" : "eventid", "table_name" : "satdeployments", "table_schema" : "public", "toppid" : 1005132}
>

COPY (SELECT * FROM satdeployments) TO '/tmp/atn_x_satdeployments.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tblfgsatdeployments) TO '/tmp/atn_x_tblfgsatdeployments.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tbltgsatdeployment) TO '/tmp/atn_x_tbltgsatdeployment.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tbltgsmrudeployments) TO '/tmp/atn_x_tbltgsmrudeployments.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tblsharkdeployment) TO '/tmp/atn_x_tblsharkdeployment.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tblsatdeployments) TO '/tmp/atn_x_tblsatdeployments.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tbltrccsatdeployment) TO '/tmp/atn_x_tbltrccsatdeployment.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tblsgarchivaldeployment) TO '/tmp/atn_x_tblsgarchivaldeployment.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tbltrccarchivaldeployment) TO '/tmp/atn_x_tbltrccarchivaldeployment.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tblfgarchivaldeployment) TO '/tmp/atn_x_tblfgarchivaldeployment.csv' delimiter '|' csv header; 
COPY (SELECT * FROM tbltgarchivaldeployment) TO '/tmp/atn_x_tbltgarchivaldeployment.csv' delimiter '|' csv header; 

atndb=# select * from tmp_x_satdeployments where eventid = '101700401';
-[ RECORD 1 ]---+-------------------
satdeploymentid | 7083
toppid          | 1017004
pttnumber       | 166391
speciesname     | pacificBluefinTuna
startdate       | 2017-09-15
enddate         | 
actualpopupdate | 
tagnumber       | 16P1975
comment         | Shogun 2017
contact         | 
projectname     | 
modelname       | miniPAT
testingnote     | 
owner           | Block
eventid         | 101700401
las             | 
tagcode         | PAM116P1975
starttime       | 
endtime         | 
est_end_date    | 

atndb=# \x
Expanded display is off.
atndb=# \d atn_eventid_details
                                      Table "public.atn_eventid_details"
      Column       |  Type   |                                    Modifiers                                    
-------------------+---------+---------------------------------------------------------------------------------
 atn_ev_details_id | integer | not null default nextval('atn_eventid_details_atn_ev_details_id_seq'::regclass)
 atn_ev_id         | integer | 
 atn_table_name    | text    | 
 atn_ev_details    | jsonb   | 

atndb=# select * from atn_eventid_details limit 1;
 atn_ev_details_id | atn_ev_id | atn_table_name |                                                                                                                                                          atn_ev_details                                                                                                                                                          
-------------------+-----------+----------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                 1 |         1 | satdeployments | {"id": 1, "ptt": 166391, "toppid": 1017004, "eventid": 101700401, "tag_model": "miniPAT", "table_name": "satdeployments", "animal_name": null, "column_name": "eventid", "table_schema": "public", "deployment_date": "2017-09-15T00:00:00", "tag_manufacturer": null, "tag_serial_number": null, "local_deployment_name": null}
(1 row)

atndb=# select atn_ev_details->'eventid' from atn_eventid_details limit 1;
 ?column?  
-----------
 101700401
(1 row)


