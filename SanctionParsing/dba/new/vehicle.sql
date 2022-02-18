truncate temp_json;

copy temp_json from 'C:\Essence_files\vehicle.txt';

create table veh
(general_id text,
buildDate text array,
model text array,
operator text array,
owner text array,
registrationDate text array,
registrationNumber text array,
type text array,
controlCount int
);
		insert into veh(
				general_id ,
				buildDate,
				model,
				operator,
				owner,
				registrationDate,
				registrationNumber,
				type,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'buildDate')),
				array (select json_array_elements_text (value->'model')),
				array (select json_array_elements_text (value->'operator')),
				array (select json_array_elements_text (value->'owner')),
				array (select json_array_elements_text (value->'registrationDate')),
				array (select json_array_elements_text (value->'registrationNumber')),
				array (select json_array_elements_text (value->'type')),
				(value->>'controlCount')::integer
				from temp_json ) ;
--				1555

	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from veh le
)t where row_number = 1;	
--698

insert into sanctions.vehicle(
				general_id ,
				buildDate,
				model,
				operator,
				owner,
				registrationDate,
				registrationNumber,
				type)
				(select general_id ,
				buildDate,
				model,
				operator,
				owner,
				registrationDate,
				registrationNumber,
				type from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from veh le
)t where row_number = 1)
--698
			
			
			
			
			
			
			
			
			
			