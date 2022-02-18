truncate temp_json;

copy temp_json from 'C:\Essence_files\interest.txt';

create table inter
(general_id text,
role text array,
status text array,
controlCount int
);
		insert into inter(
				general_id ,
				role ,
				status,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'role')),
				array (select json_array_elements_text (value->'status')),
				(value->>'controlCount')::integer
				from temp_json ) ;
--				6768
			
select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from inter le
)t where row_number = 1;
--3384

insert into sanctions.interest(
				general_id ,
				role ,
				status)
				(select general_id ,
				role ,
				status from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from inter le
)t where row_number = 1);
--3384