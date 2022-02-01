--create schema data_oceon_sanction_parsing;


select * from public.entities e ;
delete from public.person;
drop table public.person;

create table public.person 
(caption varchar,
first_seen varchar,
general_id varchar,
country varchar[],
primary key (general_id),
foreign key (general_id) references public.entities(id));

create table public.entities
(id_int serial,
caption text,
datasets text array,
first_seen text,
id text,
last_seen text,
referents text array,
schema text,
target boolean,
unique(id_int),
primary key (id)
);


create or replace procedure public.sp_fill_entities_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\footer\test\sample_target.txt';
		insert into public.entities(
				caption ,
				datasets  ,
				first_seen ,
				id ,
				last_seen ,
				referents  ,
				schema ,
				target )
			(select 
				value->>'caption',
				array (select json_array_elements_text (value->'datasets')) as dtsets,
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array (select json_array_elements_text (value->'referents')) as rfs,
				value->>'schema',
				(value->>'target')::boolean
					from temp_json );
end;
$$;
rollback;

call public.sp_fill_entities_with_json();

select * from public.entities e ;



create table public.country 
(code varchar,
label varchar,
primary key (code));

create table public.country_person
(id_person varchar,
code_country varchar,
primary key(id_person,code_country),
foreign key (id_person) references public.person(general_id),
foreign key (code_country) references public.country(code));

insert into public.person values ('Minist?rio do Interior','2021-09-26T14:52:11','NK-2QtbU49vp9LkfKRjd8WQni','{ac,ad}'),
									('Fajr Aviation Composite Industries','2021-09-26T14:52:11','NK-2XAfkJ9t2UuWnoRG5EBoYu','{am,ao}');

select  * from public.person;

copy public.country(code,label) from 
'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\country_utf-8.csv' (delimiter ';',format csv);

select * from public.country;
select * from public.country_person cp ;

insert into public.country_person values ('NK-2QtbU49vp9LkfKRjd8WQni','ac'),('NK-2QtbU49vp9LkfKRjd8WQni','ad'),
('NK-28X5jMopMz2jCXsUDUJczU','am'),('NK-28X5jMopMz2jCXsUDUJczU','ao');


--copy (select json_agg(t3.*) from
--(select * from .person p
--join .entities e on e.id =p.general_id 
--join 
--(select c.label as country, t1.general_id from .country c 
--join
--(select cp.code_country,p.general_id from .country_person cp 
--join .person p on p.general_id=cp.id_person)t1 on t1.code_country=c.code)t2 on t2.general_id = e.id)t3)
--to 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\test\test_out_json.json' ;



