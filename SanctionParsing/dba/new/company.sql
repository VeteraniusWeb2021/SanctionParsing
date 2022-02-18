truncate temp_json;

copy temp_json from 'C:\Essence_files\company.txt';

create table com
(general_id text,
bikCode text array,
caemCode text array,
capital text array,
cikCode text array,
coatoCode text array,
fnsCode text array,
fssCode text array,
ibcRuc text array,
ipoCode text array,
irsCode text array,
jibCode text array,
kppCode text array,
mbsCode text array,
ogrnCode text array,
okopfCode text array,
oksmCode text array,
okvedCode text array,
pfrNumber text array,
voenCode text array,
controlCount int
);
		insert into com(
				general_id ,
				bikCode,
				caemCode,
				capital,
				cikCode,
				coatoCode,
				fnsCode,
				fssCode,
				ibcRuc,
				ipoCode,
				irsCode,
				jibCode,
				kppCode,
				mbsCode,
				ogrnCode,
				okopfCode,
				oksmCode,
				okvedCode,
				pfrNumber,
				voenCode,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'bikCode')),
				array (select json_array_elements_text (value->'caemCode')),
				array (select json_array_elements_text (value->'capital')),
				array (select json_array_elements_text (value->'cikCode')),
				array (select json_array_elements_text (value->'coatoCode')),
				array (select json_array_elements_text (value->'fnsCode')),
				array (select json_array_elements_text (value->'fssCode')),
				array (select json_array_elements_text (value->'ibcRuc')),
				array (select json_array_elements_text (value->'ipoCode')),
				array (select json_array_elements_text (value->'irsCode')),
				array (select json_array_elements_text (value->'jibCode')),
				array (select json_array_elements_text (value->'kppCode')),
				array (select json_array_elements_text (value->'mbsCode')),
				array (select json_array_elements_text (value->'ogrnCode')),
				array (select json_array_elements_text (value->'okopfCode')),
				array (select json_array_elements_text (value->'oksmCode')),
				array (select json_array_elements_text (value->'okvedCode')),
				array (select json_array_elements_text (value->'pfrNumber')),
				array (select json_array_elements_text (value->'voenCode')),
				(value->>'controlCount')::integer
				from temp_json ) ;
--				3039
select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from com le
)t where row_number = 1;	
--1237

insert into sanctions.company(
				general_id ,
				bikCode,
				caemCode,
				capital,
				cikCode,
				coatoCode,
				fnsCode,
				fssCode,
				ibcRuc,
				ipoCode,
				irsCode,
				jibCode,
				kppCode,
				mbsCode,
				ogrnCode,
				okopfCode,
				oksmCode,
				okvedCode,
				pfrNumber,
				voenCode)
				(select general_id ,
				bikCode,
				caemCode,
				capital,
				cikCode,
				coatoCode,
				fnsCode,
				fssCode,
				ibcRuc,
				ipoCode,
				irsCode,
				jibCode,
				kppCode,
				mbsCode,
				ogrnCode,
				okopfCode,
				oksmCode,
				okvedCode,
				pfrNumber,
				voenCode from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from com le
)t where row_number = 1);
--1237

			
			
			
			
			
			
			
			
			
			