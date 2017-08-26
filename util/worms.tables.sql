
drop table if exists species_atn_worms_adb;
create table species_atn_worms_adb (
    id                   integer       null,
    locality             varchar(255)  null,
    location_id          varchar(255)  null,
    higher_geograhpy     varchar(255)  null,
    higher_geography_id  varchar(255)  null,
    record_status        varchar(255)  null,
    type_status          varchar(255)  null,
    establishment_means  varchar(255)  null,
    decimal_latitude     float         default 0.0,
    decimal_longitude    float         default 0.0,
    quality_status       varchar(255)
);

# locality,locationID,higherGeography,higherGeographyID,recordStatus,typeStatus,establishmentMeans,decimalLatitude,decimalLongitude,qualityStatus
# insert into species_atn_worms_adb (locality,location_id,higher_geograhpy,higher_geography_id,record_status,type_status,establishment_means,decimal_latitude,decimal_longitude,quality_status)

drop table if exists species_atn_worms_arb;
create table species_atn_worms_arb (
    id                   integer       null,
    aphia_id             integer       null,
    url                  varchar(255)  null,
    scientific_name      varchar(255)  null,
    authority            varchar(255)  null,
    rank                 varchar(255)  null,
    status               varchar(255)  null,
    unaccept_reason      varchar(255)  null,
    valid_aphia_id       integer       null,
    valid_name           varchar(255)  null,
    valid_authority      varchar(255)  null,
    kingdom              varchar(255)  null,
    phylum               varchar(255)  null,
    class                varchar(255)  null,
    order_name           varchar(255)  null,
    family               varchar(255)  null,
    genus                varchar(255)  null,
    citation             varchar(1024) null,
    ls_id                varchar(255)  null,
    is_marine            boolean       null,
    is_freshwater        boolean       null,
    is_terrestrial       boolean       null,
    is_extinct           boolean       null,
    match_type           varchar(255)  null,
    modified             varchar(255)  null
);

# AphiaID,url,scientificname,authority,rank,status,unacceptreason,valid_AphiaID,valid_name,valid_authority,kingdom,phylum,class,order,family,genus,citation,lsid,isMarine,isFreshwater,isTerrestrial,isExtinct,match_type,modified
# insert into species_atn_worms_arb (aphia_id,url,scientific_name,authority,rank,status,unaccept_reason,valid_aphia_id,valid_name,valid_authority,kingdom,phylum,class,order_name,family,genus,citation,ls_id,is_marine,is_freshwater,is_terrestrial,is_extinct,match_type,modified)

drop table if exists species_atn_worms_avb;
create table species_atn_worms_avb (
    id                   integer       null,
    vernacular           varchar(255)  null,
    language_code        varchar(255)  null,
    language             varchar(255)  null
);

# vernacular,language_code,language
# insert into species_atn_worms_avb (vernacular,language_code,language)

