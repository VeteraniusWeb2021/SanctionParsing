--create schema data_oceon_sanction_parsing;
create schema sanctions;

create table sanctions.person 
(caption varchar,
first_seen varchar,
id varchar,
country varchar[],
primary key (id));

create table sanctions.country 
(code varchar,
label varchar,
primary key (code));

create table sanctions.country_person
(id_person varchar,
code_country varchar,
primary key(id_person,code_country),
foreign key (id_person) references sanctions.person(id),
foreign key (code_country) references sanctions.country(code));



copy sanctions.country(code,label) from 
'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\country_utf-8.csv' (delimiter ';',format csv);
select * from sanctions.country;

