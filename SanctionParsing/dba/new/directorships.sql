truncate temp_json;

copy temp_json from 'C:\Essence_files\Directorship.txt';
		
create table dir
(general_id text,
director text array,
organization text array,
secretary text array,
controlCount int
);

insert into dir(
				general_id ,
				director,
				organization,
				secretary,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'director')),
				array (select json_array_elements_text (value->'organization')),
				array (select json_array_elements_text (value->'secretary')),
				(value->>'controlCount')::integer
				from temp_json ) ;
--				224
			
	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from dir le
)t where row_number = 1;
--112

insert into sanctions.directorships(
				general_id ,
				director,
				organization,
				secretary)
				(select general_id ,
				director,
				organization,
				secretary from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from dir le
)t where row_number = 1);
--112