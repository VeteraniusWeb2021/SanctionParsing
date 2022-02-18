truncate temp_json;

copy temp_json from 'C:\Essence_files\sanction.txt';

create table sanct
(general_id text,
authority text array,
authorityId text array,
country text array,
duration text array,
entity text array,
listingDate text array,
program text array,
provisions text array,
reason text array,
status text array,
unscId text array,
controlCount int
);
		insert into sanct(
				general_id ,
				authority,
				authorityId,
				country,
				duration,
				entity,
				listingDate,
				program,
				provisions,
				reason,
				status,
				unscId,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'authority')),
				array (select json_array_elements_text (value->'authorityId')),
				array (select json_array_elements_text (value->'country')),
				array (select json_array_elements_text (value->'duration')),
				array (select json_array_elements_text (value->'entity')),
				array (select json_array_elements_text (value->'listingDate')),
				array (select json_array_elements_text (value->'program')),
				array (select json_array_elements_text (value->'provisions')),
				array (select json_array_elements_text (value->'reason')),
				array (select json_array_elements_text (value->'status')),
				array (select json_array_elements_text (value->'unscId')),
				(value->>'controlCount')::integer
					from temp_json );
--	11465

	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from sanct le
)t where row_number = 1;
--11465
insert into sanctions.sanction(
				general_id ,
				authority,
				authorityId,
				country,
				duration,
				entity,
				listingDate,
				program,
				provisions,
				reason,
				status,
				unscId)
				(select general_id ,
				authority,
				authorityId,
				country,
				duration,
				entity,
				listingDate,
				program,
				provisions,
				reason,
				status,
				unscId from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from sanct le
)t where row_number = 1);
--11465

				
				
				
				
				
				
				
				
				
				