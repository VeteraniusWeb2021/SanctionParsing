truncate temp_json;

copy temp_json from 'C:\Essence_files\identification.txt';

create table ident
(general_id text,
authority text array,
country text array,
holder text array,
number text array,
type text array,
controlCount int
);
		insert into ident(
				general_id ,
				authority,
				country,
				holder,
				number,
				type,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'authority')),
				array (select json_array_elements_text (value->'country')),
				array (select json_array_elements_text (value->'holder')),
				array (select json_array_elements_text (value->'number')),
				array (select json_array_elements_text (value->'type')),
				(value->>'controlCount')::integer
					from temp_json ) ;
--					1159
				

select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from ident le
)t where row_number = 1;				
--				1159

insert into sanctions.identification(
				general_id ,
				authority,
				country,
				holder,
				number,
				type)
				(select general_id ,
				authority,
				country,
				holder,
				number,
				type from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from ident le
)t where row_number = 1);
--	1159			
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				