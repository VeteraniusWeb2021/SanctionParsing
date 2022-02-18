truncate temp_json;

copy temp_json from 'C:\Essence_files\passport.txt';
	
create table pas
(general_id text,
birthDate text array,
birthPlace text array,
gender text array,
givenName text array,
passportNumber text array,
personalNumber text array,
surname text array,
controlCount int
);

insert into pas(
				general_id ,
				birthDate,
				birthPlace,
				gender,
				givenName,
				passportNumber,
				personalNumber,
				surname,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'birthDate')),
				array (select json_array_elements_text (value->'birthPlace')),
				array (select json_array_elements_text (value->'gender')),
				array (select json_array_elements_text (value->'givenName')),
				array (select json_array_elements_text (value->'passportNumber')),
				array (select json_array_elements_text (value->'personalNumber')),
				array (select json_array_elements_text (value->'surname')),
				(value->>'controlCount')::integer
				from temp_json ) ;
--				387
			
	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from pas le
)t where row_number = 1;	
--387
insert into sanctions.passport(
				general_id ,
				birthDate,
				birthPlace,
				gender,
				givenName,
				passportNumber,
				personalNumber,
				surname)
				(select general_id ,
				birthDate,
				birthPlace,
				gender,
				givenName,
				passportNumber,
				personalNumber,
				surname from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from pas le
)t where row_number = 1);
--387


			
			
			
			
			
			
			
			
			
			
			