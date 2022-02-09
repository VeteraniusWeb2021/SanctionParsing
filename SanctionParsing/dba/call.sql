
call sanctions.sp_fill_entities();
call sanctions.sp_fill_thing();
call sanctions.sp_fill_legalentity();
call sanctions.sp_fill_person();
call sanctions.sp_fill_address();
call sanctions.sp_fill_interval();
call sanctions.sp_fill_value();
call sanctions.sp_fill_organization();
call sanctions.sp_fill_identification();
call sanctions.sp_fill_sanction();
--call sanctions.sp_fill_security();
call sanctions.sp_fill_other_link();
call sanctions.sp_fill_vessel();
call sanctions.sp_fill_asset();
call sanctions.sp_fill_vehicle();
call sanctions.sp_fill_airplane();
--call sanctions.sp_fill_associate();
call sanctions.sp_fill_company();
call sanctions.sp_fill_crypto_wallet();
call sanctions.sp_fill_directorships();
call sanctions.sp_fill_interest();
call sanctions.sp_fill_family();
call sanctions.sp_fill_membership();
call sanctions.sp_fill_ownership();
--call sanctions.sp_fill_passport();
call sanctions.sp_fill_representation();
--call sanctions.sp_fill_publicBody();
copy sanctions.country(code,label) from 
'C:\Essence_files\country_utf-8.csv' (delimiter ';',format csv);
copy sanctions.topics(code,label) from 
'C:\Essence_files\topics_utf-8.csv' (delimiter ';',format csv);