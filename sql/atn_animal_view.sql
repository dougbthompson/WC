
drop table if exists atn_animal_view;
create table atn_animal_view (
    animal_view_id       serial,
    speciescode          character varying(2),
    animalid             character varying(40),
    gender               character varying(20),
    identifyingfeatures  character varying(255),
    nickname             character varying(40),
    red                  integer,
    green                integer,
    blue                 integer,
    speciesname          character varying(80),
    genus                character varying(80),
    species              character varying(80),
    taxongroup           character varying(80),
    workinggroup         character varying(80),
    abreviation          character varying(20),
    concatname           text,
    toppid               character varying(20),
    projectid            integer,
    name                 character varying(80),
    casecomment          text,
    ownerid              integer,
    contactid            integer,
    provisional          boolean
);

