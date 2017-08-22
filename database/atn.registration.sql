
drop table if exists atn_contact;
create table atn_contact (
    id               bigint       not null,
	project_id       bigint           null,
	organisation_id  bigint           null,
	contact_desc     varchar(255)     null,
	primary key (id)
);
drop table if exists atn_user;
create table atn_user (
    id                 bigint       not null,
	role_id            bigint           null,
	project_id         varchar(255)     null,
	organisation_id    varchar(255)     null,
	user_name          varchar(255)     null,
	user_password      varchar(255)     null,
	title              varchar(255)     null,
	address1           varchar(255)     null,
	address2           varchar(255)     null,
	address3           varchar(355)     null,
	email              varchar(64)      null,
	phone              varchar(255)     null,
	user_directory     varchar(255)     null,
	auth_code          varchar(255)     null,
	authorized_status  varchar(8)       null,
	citation           varchar(255)     null,
	registered_date    integer      not null,
	last_update_date   integer      not null,
	primary key (id)
);
drop table if exists atn_user_role;
create table atn_user_role (
    id               bigint       not null,
	role_name        varchar(255) not null,
	primary key (id)
);
drop table if exists atn_organisation;
create table atn_organisation (
    id                 bigint       not null,
	organisation_name  varchar(255) not null,
    fax                varchar(255)     null,
    phone              varchar(255)     null,
	address1           varchar(255)     null,
	address2           varchar(255)     null,
	address3           varchar(255)     null,
    status             varchar(255)     null,
	primary key (id)
);
drop table if exists atn_project;
create table atn_project (
    id               bigint        not null,
	project_name     varchar(255)  not null,
	project_year     bigint        not null,
	primary key (id)
);
drop table if exists atn_organisation_project;
create table atn_organisation_project (
    id                bigint       not null,
	project_id        bigint           null,
	organisation_id   bigint           null,
	primary key (id)
);
drop table if exists atn_project_role;
create table atn_project_role (
    id                bigint       not null,
	project_id        bigint           null,
	user_id           bigint           null,
	user_role_id      bigint           null,
	primary key (id)
);
drop table if exists atn_role;
create table atn_role (
    id                serial       primary key,
	role_desc         varchar(255) not null
);
insert into atn_role(role_desc) values('Principal Investigator'),('Co-Investigator'),
            ('Research Assistant'),('Technical Assistant'),('Administrator'),('Student');

