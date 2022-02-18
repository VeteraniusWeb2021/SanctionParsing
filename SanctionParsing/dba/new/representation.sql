truncate temp_json;

copy temp_json from 'C:\Essence_files\representation.txt';
		
create table rep
(general_id text,
agent text array,
client text array,
controlCount int
);

insert into rep(
				general_id ,
				agent,
				client,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'agent')),
				array (select json_array_elements_text (value->'client')),
				(value->>'controlCount')::integer
				from temp_json ) ;
				
--			1652
	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from rep le
)t where row_number = 1;	

--826

insert into sanctions.representation(
				general_id ,
				agent,
				client)
				(select general_id ,
				agent,
				client from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from rep le
)t where row_number = 1);
--826
			
			