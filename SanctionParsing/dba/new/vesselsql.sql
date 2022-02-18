truncate temp_json;

copy temp_json from 'C:\Essence_files\vessel.txt';

create table ves
(general_id text,
callSign text array,
crsNumber text array,
flag text array,
grossRegisteredTonnage text array,
imoNumber text array,
mmsi text array,
nameChangeDate text array,
navigationArea text array,
pastFlags text array,
pastNames text array,
pastTypes text array,
registrationPort text array,
tonnage text array,
controlCount int
);
		insert into ves(
				general_id ,
				callSign,
				crsNumber,
				flag,
				grossRegisteredTonnage,
				imoNumber,
				mmsi,
				nameChangeDate,
				navigationArea,
				pastFlags,
				pastNames,
				pastTypes,
				registrationPort,
				tonnage,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'callSign')),
				array (select json_array_elements_text (value->'crsNumber')),
				array (select json_array_elements_text (value->'flag')),
				array (select json_array_elements_text (value->'grossRegisteredTonnage')),
				array (select json_array_elements_text (value->'imoNumber')),
				array (select json_array_elements_text (value->'mmsi')),
				array (select json_array_elements_text (value->'nameChangeDate')),
				array (select json_array_elements_text (value->'navigationArea')),
				array (select json_array_elements_text (value->'pastFlags')),
				array (select json_array_elements_text (value->'pastNames')),
				array (select json_array_elements_text (value->'pastTypes')),
				array (select json_array_elements_text (value->'registrationPort')),
				array (select json_array_elements_text (value->'tonnage')),
				(value->>'controlCount')::integer
				from temp_json ) ;
--				831
	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from ves le
)t where row_number = 1;
--418

insert into sanctions.vessel(
				general_id ,
				callSign,
				crsNumber,
				flag,
				grossRegisteredTonnage,
				imoNumber,
				mmsi,
				nameChangeDate,
				navigationArea,
				pastFlags,
				pastNames,
				pastTypes,
				registrationPort,
				tonnage)
				(select general_id ,
				callSign,
				crsNumber,
				flag,
				grossRegisteredTonnage,
				imoNumber,
				mmsi,
				nameChangeDate,
				navigationArea,
				pastFlags,
				pastNames,
				pastTypes,
				registrationPort,
				tonnage from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from ves le
)t where row_number = 1);
--418
			
			
			
			
			
			
			
			
			
			
			
			
			
			