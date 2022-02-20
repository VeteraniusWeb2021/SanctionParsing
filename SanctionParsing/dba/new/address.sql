truncate temp_json;

		copy temp_json from 'C:\Essence_files\address.txt';
	
create table addr
(general_id text,
city text array,
country text array,
full text array,
latitude text array,
longitude text array,
postOfficeBox text array,
postalCode text array,
region text array,
remarks text array,
state text array,
street text array,
street2 text array,
things text array,
controlCount int
);	
	truncate addr;

		insert into addr(
				general_id ,
				city,
				country,
				"full",
				latitude,
				longitude,
				postOfficeBox,
				postalCode,
				region,
				remarks,
				state,
				street,
				street2,
				things,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'city')),
				array (select json_array_elements_text (value->'country')),
				array (select json_array_elements_text (value->'full')),
				array (select json_array_elements_text (value->'latitude')),
				array (select json_array_elements_text (value->'longitude')),
				array (select json_array_elements_text (value->'postOfficeBox')),
				array (select json_array_elements_text (value->'postalCode')),
				array (select json_array_elements_text (value->'region')),
				array (select json_array_elements_text (value->'remarks')),
				array (select json_array_elements_text (value->'state')),
				array (select json_array_elements_text (value->'street')),
				array (select json_array_elements_text (value->'street2')),
				array (select json_array_elements_text (value->'things')) ,
				(value->>'controlCount')::integer
					from temp_json );
--				12626

	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from addr le
)t where row_number = 1;			
--	7525
insert into sanctions.address(
				general_id ,
				city,
				country,
				"full",
				latitude,
				longitude,
				postOfficeBox,
				postalCode,
				region,
				remarks,
				state,
				street,
				street2,
				things)
			( select general_id ,
				city,
				country,
				"full",
				latitude,
				longitude,
				postOfficeBox,
				postalCode,
				region,
				remarks,
				state,
				street,
				street2,
				things from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from addr le
)t where row_number = 1) on conflict (general_id) do update set "full" = excluded.full;
--7525
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				