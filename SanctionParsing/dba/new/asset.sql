truncate temp_json;

copy temp_json from 'C:\Essence_files\asset.txt';

create table ass
(general_id text,
ownershipAsset text array,
controlCount int
);
		insert into ass(
				general_id ,
				ownershipAsset,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'ownershipAsset')),
				(value->>'controlCount')::integer
				from temp_json );
				
select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from ass le
)t where row_number = 1;	
--1935

insert into sanctions.asset(
				general_id ,
				ownershipAsset)
				(select general_id ,
				ownershipAsset from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from ass le
)t where row_number = 1);
--1935