truncate temp_json;

copy temp_json from 'C:\Essence_files\membership.txt';
		
create table mem
(general_id text,
member text array,
organization text array,
controlCount int
);
insert into mem(
				general_id ,
				member,
				organization,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'member')),
				array (select json_array_elements_text (value->'organization')),
				(value->>'controlCount')::integer
				from temp_json ) ;
				
			select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from mem le
)t where row_number = 1;
--55

insert into sanctions.membership(
				general_id ,
				member,
				organization)
				(select general_id ,
				member,
				organization from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from mem le
)t where row_number = 1);
--55