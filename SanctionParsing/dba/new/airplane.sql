truncate temp_json;

copy temp_json from 'C:\Essence_files\airplane.txt';

create table air
(general_id text,
icaoCode text array,
manufacturer text array,
serialNumber text array,
controlCount int
);
		insert into air(
				general_id ,
				icaoCode,
				manufacturer ,
				serialNumber,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'icaoCode')),
				array (select json_array_elements_text (value->'manufacturer')),
				array (select json_array_elements_text (value->'serialNumber')),
				(value->>'controlCount')::integer
				from temp_json );
select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from air le
)t where row_number = 1;	
--280

insert into sanctions.airplane(
				general_id ,
				icaoCode,
				manufacturer ,
				serialNumber)
				(select general_id ,
				icaoCode,
				manufacturer ,
				serialNumber from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from air le
)t where row_number = 1);
--280