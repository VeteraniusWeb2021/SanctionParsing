truncate temp_json;

copy temp_json from 'C:\Essence_files\ownership.txt';
	
create table own
(general_id text,
asset text array,
legalBasis text array,
owner text array,
ownershipType text array,
percentage text array,
sharesCount text array,
sharesCurrency text array,
sharesType text array,
sharesValue text array,
controlCount int
);
insert into own(
				general_id ,
				asset,
				legalBasis,
				owner,
				ownershipType,
				percentage,
				sharesCount,
				sharesCurrency,
				sharesType,
				sharesValue,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'asset')),
				array (select json_array_elements_text (value->'legalBasis')),
				array (select json_array_elements_text (value->'owner')),
				array (select json_array_elements_text (value->'ownershipType')),
				array (select json_array_elements_text (value->'percentage')),
				array (select json_array_elements_text (value->'sharesCount')),
				array (select json_array_elements_text (value->'sharesCurrency')),
				array (select json_array_elements_text (value->'sharesType')),
				array (select json_array_elements_text (value->'sharesValue')),
				(value->>'controlCount')::integer
				from temp_json );
--				4002
			
	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from own le
)t where row_number = 1;	

--2001
insert into sanctions.ownership(
				general_id ,
				asset,
				legalBasis,
				owner,
				ownershipType,
				percentage,
				sharesCount,
				sharesCurrency,
				sharesType,
				sharesValue)
				(select general_id ,
				asset,
				legalBasis,
				owner,
				ownershipType,
				percentage,
				sharesCount,
				sharesCurrency,
				sharesType,
				sharesValue from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from own le
)t where row_number = 1);
--2001
			
			
			
			
			