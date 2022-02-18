truncate temp_json;

copy temp_json from 'C:\Essence_files\CryptoWallet.txt';

create table cryp
(general_id text,
balance text array,
balanceDate text array,
creationDate text array,
currencySymbol text array,
holder text array,
mangingExchange text array,
privateKey text array,
publicKey text array,
controlCount int
);
		insert into cryp(
				general_id ,
				balance,
				balanceDate,
				creationDate,
				currencySymbol,
				holder,
				mangingExchange,
				privateKey,
				publicKey,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'balance')),
				array (select json_array_elements_text (value->'balanceDate')),
				array (select json_array_elements_text (value->'creationDate')),
				array (select json_array_elements_text (value->'currencySymbol')),
				array (select json_array_elements_text (value->'holder')),
				array (select json_array_elements_text (value->'mangingExchange')),
				array (select json_array_elements_text (value->'privateKey')),
				array (select json_array_elements_text (value->'publicKey')),
				(value->>'controlCount')::integer
				from temp_json ) ;
	select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from cryp le
)t where row_number = 1;	
--170

insert into sanctions.crypto_wallet(
				general_id ,
				balance,
				balanceDate,
				creationDate,
				currencySymbol,
				holder,
				mangingExchange,
				privateKey,
				publicKey)
				(select general_id ,
				balance,
				balanceDate,
				creationDate,
				currencySymbol,
				holder,
				mangingExchange,
				privateKey,
				publicKey from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from cryp le
)t where row_number = 1);
--170
			
			