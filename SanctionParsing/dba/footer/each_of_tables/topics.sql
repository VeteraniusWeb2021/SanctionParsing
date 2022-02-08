
create table sanctions.topics 
(code varchar,
label varchar,
primary key (code));

copy sanctions.topics(code,label) from 
'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\topics_utf-8.csv' (delimiter ';',format csv);
select * from sanctions.topics;
