truncate temp_json;
copy temp_json from 'C:\Essence_files\interval.txt';

create table inte
(general_id text,
date text array,
description text array,
endDate text array,
modifiedAt text array,
publisher text array,
publisherUrl text array,
recordId text array,
retrievedAt text array,
sourceUrl text array,
startDate text array,
summary text array,
controlCount int
);
		insert into inte(
				general_id ,
				date,
				description,
				endDate,
				modifiedAt,
				publisher,
				publisherUrl,
				recordId,
				retrievedAt,
				sourceUrl,
				startDate,
				summary,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'date')),
				array (select json_array_elements_text (value->'description')),
				array (select json_array_elements_text (value->'endDate')),
				array (select json_array_elements_text (value->'modifiedAt')),
				array (select json_array_elements_text (value->'publisher')),
				array (select json_array_elements_text (value->'publisherUrl')),
				array (select json_array_elements_text (value->'recordId')),
				array (select json_array_elements_text (value->'retrievedAt')),
				array (select json_array_elements_text (value->'sourceUrl')),
				array (select json_array_elements_text (value->'startDate')),
				array (select json_array_elements_text (value->'summary')),
				(value->>'controlCount')::integer
					from temp_json );
--					32260

	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from inte le
)t where row_number = 1;			
--	23654

insert into sanctions.interval(
				general_id ,
				date,
				description,
				endDate,
				modifiedAt,
				publisher,
				publisherUrl,
				recordId,
				retrievedAt,
				sourceUrl,
				startDate,
				summary)
				(select general_id ,
				date,
				description,
				endDate,
				modifiedAt,
				publisher,
				publisherUrl,
				recordId,
				retrievedAt,
				sourceUrl,
				startDate,
				summary from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from inte le
)t where row_number = 1);
--23654
				
				
				
				
				
				
				
				