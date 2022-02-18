truncate temp_json;

create table pers
(general_id text,
associates text array,
associations text array,
birthDate text array,
birthPlace text array,
deathDate text array,
education text array,
ethnicity text array,
familyPerson text array,
familyRelative text array,
fatherName text array,
firstName text array,
gender text array,
lastName text array,
middleName text array,
motherName text array,
nationality text array,
passportNumber text array,
political text array,
position text array,
religion text array,
secondName text array,
title text array,
controlCount int
);

copy temp_json from 'C:\Essence_files\person.txt';

		insert into pers(
				general_id ,
				associates,
				associations,
				birthDate,
				birthPlace,
				deathDate,
				education,
				ethnicity,
				familyPerson,
				familyRelative,
				fatherName,
				firstName,
				gender,
				lastName,
				middleName,
				motherName,
				nationality,
				passportNumber,
				political,
				position,
				religion,
				secondName,
				title,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'associates')),
				array (select json_array_elements_text (value->'associations')),
				array (select json_array_elements_text (value->'birthDate')),
				array (select json_array_elements_text (value->'birthPlace')),
				array (select json_array_elements_text (value->'deathDate')),
				array (select json_array_elements_text (value->'education')),
				array (select json_array_elements_text (value->'ethnicity')),
				array (select json_array_elements_text (value->'familyPerson')),
				array (select json_array_elements_text (value->'familyRelative')),
				array (select json_array_elements_text (value->'fatherName')),
				array (select json_array_elements_text (value->'firstName')),
				array (select json_array_elements_text (value->'gender')),
				array (select json_array_elements_text (value->'lastName')),
				array (select json_array_elements_text (value->'middleName')),
				array (select json_array_elements_text (value->'motherName')),
				array (select json_array_elements_text (value->'nationality')),
				array (select json_array_elements_text (value->'passportNumber')),
				array (select json_array_elements_text (value->'political')),
				array (select json_array_elements_text (value->'position')),
				array (select json_array_elements_text (value->'religion')),
				array (select json_array_elements_text (value->'secondName')),
				array (select json_array_elements_text (value->'title')) ,
				(value->>'controlCount')::integer
					from temp_json ) ;
--					8648
				
	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from pers le
)t where row_number = 1;			
--				5491

insert into sanctions.person(
				general_id ,
				associates,
				associations,
				birthDate,
				birthPlace,
				deathDate,
				education,
				ethnicity,
				familyPerson,
				familyRelative,
				fatherName,
				firstName,
				gender,
				lastName,
				middleName,
				motherName,
				nationality,
				passportNumber,
				political,
				position,
				religion,
				secondName,
				title)
			(select general_id ,
				associates,
				associations,
				birthDate,
				birthPlace,
				deathDate,
				education,
				ethnicity,
				familyPerson,
				familyRelative,
				fatherName,
				firstName,
				gender,
				lastName,
				middleName,
				motherName,
				nationality,
				passportNumber,
				political,
				position,
				religion,
				secondName,
				title from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from pers le
)t where row_number = 1
				 ) ;
				
--	5491			
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				