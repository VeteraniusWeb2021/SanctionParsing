truncate temp_json;

copy temp_json from 'C:\Essence_files\family.txt';
		
create table fam
(general_id text,
person text array,
relationship text array,
relative text array,
controlCount int
);
insert into fam(
				general_id ,
				person ,
				relationship,
				relative,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'person')),
				array (select json_array_elements_text (value->'relationship')),
				array (select json_array_elements_text (value->'relative')),
				(value->>'controlCount')::integer
				from temp_json );
				
			select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from fam le
)t where row_number = 1;
--9

insert into sanctions.family(
				general_id ,
				person ,
				relationship,
				relative)
				(select general_id ,
				person ,
				relationship,
				relative from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from fam le
)t where row_number = 1);

--9