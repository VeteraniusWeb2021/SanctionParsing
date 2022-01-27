create table sanctions.country 
(code varchar,
label varchar,
primary key (code));

copy sanctions.country(code,label) from 
'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\country_utf-8.csv' (delimiter ';',format csv);
select * from sanctions.country;

