truncate temp_json;

copy temp_json from 'C:\Essence_files\UnknownLink.txt';

create table other
(general_id text,
object text array,
subject text array,
controlCount int
);
		insert into other(
				general_id ,
				object,
				subject,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'object')),
				array (select json_array_elements_text (value->'subject')),
				(value->>'controlCount')::integer
				from temp_json ) ;
--				1004
			
select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from other le
)t where row_number = 1;	
--502
insert into sanctions.other_link(
				general_id ,
				object,
				subject)
				(select general_id ,
				object,
				subject from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from other le
)t where row_number = 1);
--502