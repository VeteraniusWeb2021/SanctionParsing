
call sanctions.sp_fill_entities_with_json();
call sanctions.sp_fill_thing_with_json();
call sanctions.sp_fill_legalentity_with_json();
call sanctions.sp_fill_person_with_json();
call sanctions.sp_fill_address_with_json();
call sanctions.sp_fill_interval_with_json();
call sanctions.sp_fill_value_with_json();
call sanctions.sp_fill_organization_with_json();
call sanctions.sp_fill_identification_with_json();
call sanctions.sp_fill_sanction_with_json();
--call sanctions.sp_fill_security_with_json();
call sanctions.sp_fill_other_link_with_json();
call sanctions.sp_fill_vessel_with_json();
call sanctions.sp_fill_asset_with_json();
call sanctions.sp_fill_vehicle_with_json();
call sanctions.sp_fill_airplane_with_json();
--call sanctions.sp_fill_associate_with_json();
call sanctions.sp_fill_company_with_json();
call sanctions.sp_fill_crypto_wallet_with_json();
call sanctions.sp_fill_directorships_with_json();
call sanctions.sp_fill_interest_with_json();
call sanctions.sp_fill_family_with_json();
call sanctions.sp_fill_membership_with_json();
call sanctions.sp_fill_ownership_with_json();
--call sanctions.sp_fill_passport_with_json();
call sanctions.sp_fill_representation_with_json();
--call sanctions.sp_fill_publicBody_with_json();
copy sanctions.country(code,label) from 
'C:\Essence_files\country_utf-8.csv' (delimiter ';',format csv);
copy sanctions.topics(code,label) from 
'C:\Essence_files\topics_utf-8.csv' (delimiter ';',format csv);