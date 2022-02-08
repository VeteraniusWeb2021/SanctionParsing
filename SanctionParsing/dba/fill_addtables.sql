
--copy sanctions.country(code,label) from 
--'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\const_data\country_utf-8.csv' (delimiter ';',format csv);
--select * from sanctions.country;
--
--copy sanctions.topics(code,label) from 
--'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\const_data\topics_utf-8.csv' (delimiter ';',format csv);
--select * from sanctions.topics;

--//////////////////////////////
create table sanctions.entities_referents
(entities varchar,
referents varchar,
primary key(entities,referents));

insert into sanctions.entities_referents (select p.id ,unnest (p.referents) from sanctions.entities p) on conflict do nothing;

select * from sanctions.entities_referents t ;
--//////////////////////////////
insert into sanctions.legalEntity_agencyClient (select p.general_id ,unnest (p.agencyClient) from sanctions.legalEntity p) on conflict do nothing;

select * from sanctions.legalEntity_agencyClient t ;