
copy sanctions.country(code,label) from 
'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\country_utf-8.csv' (delimiter ';',format csv);
select * from sanctions.country;

copy sanctions.topics(code,label) from 
'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\topics_utf-8.csv' (delimiter ';',format csv);
select * from sanctions.topics;

--//////////////////////////////
create table public.test_entities_referents
(entities varchar,
referents varchar,
primary key(entities,referents));

insert into public.test_entities_referents (select p.id ,unnest (p.referents) from sanctions.entities p) on conflict do nothing;

select *, from public.test_entities_referents t ;
--//////////////////////////////
