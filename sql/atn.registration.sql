
drop table if exists biologging.atn_user;
create table biologging.atn_user (
    id                serial        primary key,
    user_name         varchar(255)      null,
    user_password     varchar(255)      null,
    title             varchar(255)      null,
    address1          varchar(255)      null,
    address2          varchar(255)      null,
    address3          varchar(355)      null,
    email             varchar(64)       null,
    phone             varchar(255)      null,
    user_directory    varchar(255)      null,
    auth_code         varchar(255)      null,
    auth_status       varchar(8)        null,
    citation          varchar(255)      null,
    registered_date   integer       not null,
    last_update_date  integer       not null
);
drop table if exists biologging.atn_user_role;
create table biologging.atn_user_role (
    id               serial        primary key,
    role_name        varchar(255)  not null
);
insert into biologging.atn_user_role(role_name) values('Principal Investigator'),('Co-Investigator'),
       ('Research Assistant'),('Technical Assistant'),('Administrator'),('Student');

drop table if exists biologging.atn_contact;
create table biologging.atn_contact (
    id               serial        primary key,
    contact_desc     varchar(255)      null
);

drop table if exists biologging.atn_organisation;
create table biologging.atn_organisation (
    id               serial        primary key,
    org_name         varchar(255)  not null,
    fax              varchar(255)      null,
    phone            varchar(255)      null,
    address1         varchar(255)      null,
    address2         varchar(255)      null,
    address3         varchar(255)      null,
    status           varchar(255)      null
);

drop table if exists biologging.atn_project;
create table biologging.atn_project (
    id               serial        primary key,
    project_name     varchar(255)  not null,
    project_year     bigint        not null,
    project_desc     text              null
);

drop table if exists biologging.atn_organisation_project;
create table biologging.atn_organisation_project (
    id               serial       primary key,
    org_id           bigint           null,
    project_id       bigint           null
);
drop table if exists biologging.atn_project_user_role;
create table biologging.atn_project_user_role (
    id               serial       primary key,
    org_project_id   bigint           null,
    user_role_id     bigint           null,
    user_id          bigint           null,
    contact_id       bigint           null
);

