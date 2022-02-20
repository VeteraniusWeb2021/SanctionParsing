
		create  table if not exists temp_json (value json) ;
	
		copy temp_json from 'C:\Essence_files\Entities.txt';
	
	select * from temp_json;
	
create table entities
(id_int serial,
caption text,
datasets text array,
first_seen text,
id text,
last_seen text,
referents text array,
schema text,
target boolean,
controlCount int
);

insert into entities(
				caption ,
				datasets  ,
				first_seen ,
				id ,
				last_seen ,
				referents  ,
				schema ,
				target,
				controlCount)
			(select 
				value->>'caption',
				array (select json_array_elements_text (value->'datasets')) as dtsets,
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array (select json_array_elements_text (value->'referents')) as rfs,
				value->>'schema',
				(value->>'target')::boolean,
				(value->>'controlCount')::integer
					from temp_json ) ;
					
select count(*) from (	
select *,row_number() over(partition by id order by controlCount desc) from entities le
)t where row_number = 1;
-- 33920

select * from entities where controlCount = 8;

create table ent
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

insert into sanctions.entities(
				caption ,
				datasets  ,
				first_seen ,
				id ,
				last_seen ,
				referents  ,
				schema ,
				target
				)
					(select caption ,
							datasets  ,
							first_seen ,
							id ,
							last_seen ,
							referents  ,
							schema ,
							target from 
								(select *,row_number() over(partition by id order by controlCount desc) from entities le)t where row_number = 1
					);
--	insert 33920				
					
truncate temp_json;		


copy sanctions.country(code,label) from 
'C:\Essence_files\country_utf-8.csv' (delimiter ';',format csv) ;


copy sanctions.topics(code,label) from 
'C:\Essence_files\topics_utf-8.csv' (delimiter ';',format csv);
