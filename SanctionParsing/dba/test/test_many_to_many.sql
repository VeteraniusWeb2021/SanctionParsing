--create schema data_oceon_sanction_parsing;
create schema sanctions;

select * from sanctions.entities e ;
delete from sanctions.person;
drop table sanctions.person;

create table sanctions.person 
(caption varchar,
first_seen varchar,
general_id varchar,
country varchar[],
primary key (general_id),
foreign key (general_id) references sanctions.entities(id));

create table sanctions.country 
(code varchar,
label varchar,
primary key (code));

create table sanctions.country_person
(id_person varchar,
code_country varchar,
primary key(id_person,code_country),
foreign key (id_person) references sanctions.person(general_id),
foreign key (code_country) references sanctions.country(code));

insert into sanctions.person values ('Minist?rio do Interior','2021-09-26T14:52:11','NK-2QtbU49vp9LkfKRjd8WQni','{ac,ad}'),
									('Fajr Aviation Composite Industries','2021-09-26T14:52:11','NK-28X5jMopMz2jCXsUDUJczU','{am,ao}');

select  * from sanctions.person;

copy sanctions.country(code,label) from 
'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\country_utf-8.csv' (delimiter ';',format csv);

select * from sanctions.country;
select * from sanctions.country_person cp ;

insert into sanctions.country_person values ('NK-2QtbU49vp9LkfKRjd8WQni','ac'),('NK-2QtbU49vp9LkfKRjd8WQni','ad'),
('NK-28X5jMopMz2jCXsUDUJczU','am'),('NK-28X5jMopMz2jCXsUDUJczU','ao');


copy (select json_agg(t3.*) from
(select * from sanctions.person p
join sanctions.entities e on e.id =p.general_id 
join 
(select c.label as country, t1.general_id from sanctions.country c 
join
(select cp.code_country,p.general_id from sanctions.country_person cp 
join sanctions.person p on p.general_id=cp.id_person)t1 on t1.code_country=c.code)t2 on t2.general_id = e.id)t3)
to 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\test\test_out_json.json' ;



