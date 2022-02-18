truncate temp_json;

copy temp_json from 'C:\Essence_files\value.txt';

create table valu
(general_id text,
amount text ,
amountEur text,
amountUsd text,
currency text array,
controlCount int
);


		insert into valu(
				general_id ,
				amount,
				amountEur ,
				amountUsd ,
				currency ,
				controlCount)
			(select 
				value->>'general_id',
				value->>'amount',
				value->>'amountEur',
				value->>'amountUsd',
				array (select json_array_elements_text (value->'currency')),
				(value->>'controlCount')::integer
					from temp_json ) ;
--					4764
	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from valu le
)t where row_number = 1;
--2105

insert into sanctions.value(
				general_id ,
				amount,
				amountEur ,
				amountUsd ,
				currency )
				(select general_id ,
				amount,
				amountEur ,
				amountUsd ,
				currency from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from valu le
)t where row_number = 1);
--2105











