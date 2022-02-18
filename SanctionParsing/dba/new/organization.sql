truncate temp_json;
copy temp_json from 'C:\Essence_files\organization.txt';

create table organ
(general_id text,
directorshipOrganization text array,
membershipOrganization text array,
controlCount int
);
		insert into organ(
				general_id ,
				directorshipOrganization,
				membershipOrganization,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'directorshipOrganization')),
				array (select json_array_elements_text (value->'membershipOrganization')),
				(value->>'controlCount')::integer
					from temp_json ) ;
select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from organ le
)t where row_number = 1;		
--3905

insert into sanctions.organization(
				general_id ,
				directorshipOrganization,
				membershipOrganization)
				(select general_id ,
				directorshipOrganization,
				membershipOrganization from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from organ le
)t where row_number = 1);
--3905







