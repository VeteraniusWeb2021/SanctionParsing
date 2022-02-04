

create or replace procedure sanctions.sp_fill_entities_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\entities.txt';
		insert into sanctions.entities(
				caption ,
				datasets  ,
				first_seen ,
				id ,
				last_seen ,
				referents  ,
				schema ,
				target )
			(select 
				value->>'caption',
				array (select json_array_elements_text (value->'datasets')) as dtsets,
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array (select json_array_elements_text (value->'referents')) as rfs,
				value->>'schema',
				(value->>'target')::boolean
					from temp_json ) on conflict(id) do nothing;
end;
$$;

call sanctions.sp_fill_entities_with_json();
select count(*) from sanctions.entities e ;
select * from sanctions.entities e ;
delete from sanctions.entities ;
--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_thing_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\thing.txt';
		insert into sanctions.thing(
				general_id ,
				address,
				addressEntity,
				alias,
				country,
				description,
				keywords,
				modifiedAt,
				name,
				notes,
				previousName,
				program,
				publisher,
				publisherUrl,
				retrievedAt,
				sanctions,
				sourceUrl,
				summary,
				topics,
				unknownLinkFrom,
				unknownLinkTo,
				weakAlias,
				wikidataId,
				wikipediaUrl)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'address')) ,
				array (select json_array_elements_text (value->'addressEntity'))  ,
				array (select json_array_elements_text (value->'alias'))  ,
				array (select json_array_elements_text (value->'country'))  ,
				array (select json_array_elements_text (value->'description'))  ,
				array (select json_array_elements_text (value->'keywords'))  ,
				array (select json_array_elements_text (value->'modifiedAt'))  ,
				array (select json_array_elements_text (value->'name'))  ,
				array (select json_array_elements_text (value->'notes'))  ,
				array (select json_array_elements_text (value->'previousName'))  ,
				array (select json_array_elements_text (value->'program'))  ,
				array (select json_array_elements_text (value->'publisher'))  ,
				array (select json_array_elements_text (value->'publisherUrl'))  ,
				array (select json_array_elements_text (value->'retrievedAt'))  ,
				array (select json_array_elements_text (value->'sanctions'))  ,
				array (select json_array_elements_text (value->'sourceUrl'))  ,
				array (select json_array_elements_text (value->'summary'))  ,
				array (select json_array_elements_text (value->'topics'))  ,
				array (select json_array_elements_text (value->'unknownLinkFrom'))  ,
				array (select json_array_elements_text (value->'unknownLinkTo'))  ,
				array (select json_array_elements_text (value->'weakAlias'))  ,
				array (select json_array_elements_text (value->'wikidataId'))  ,
				array (select json_array_elements_text (value->'wikipediaUrl'))  
					from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_thing_with_json();
delete from sanctions.thing ;
select * from sanctions.thing t ;

--/////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_legal_entity_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\LegalEntity.txt';
		insert into sanctions.legal_entity(
				general_id,
				agencyClient,
				agentRepresentation,
				bvdId,
				classification,
				cryptoWallets,
				directorshipDirector,
				dissolutionDate,
				dunsCode,
				email,
				icijId,
				idNumber,
				identificiation,
				incorporationDate,
				innCode,
				jurisdiction,
				legalForm,
				mainCountry,
				membershipMember,
				okpoCode,
				opencorporatesUrl,
				operatedVehicles,
				ownedVehicles,
				ownershipOwner,
				parent,
				phone,
				registrationNumber,
				sector,
				securities,
				status,
				subsidiaries,
				swiftBic,
				taxNumber,
				taxStatus,
				vatCode,
				website) 
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'agencyClient')),
				array (select json_array_elements_text (value->'agentRepresentation')) ,
				array (select json_array_elements_text (value->'bvdId')) ,
				array (select json_array_elements_text (value->'classification')) ,
				array (select json_array_elements_text (value->'cryptoWallets')) ,
				array (select json_array_elements_text (value->'directorshipDirector')) ,
				array (select json_array_elements_text (value->'dissolutionDate')) ,
				array (select json_array_elements_text (value->'dunsCode')) ,
				array (select json_array_elements_text (value->'email')) ,
				array (select json_array_elements_text (value->'icijId')) ,
				array (select json_array_elements_text (value->'idNumber')) ,
				array (select json_array_elements_text (value->'identificiation')) ,
				array (select json_array_elements_text (value->'incorporationDate')) ,
				array (select json_array_elements_text (value->'innCode')) ,
				array (select json_array_elements_text (value->'jurisdiction')) ,
				array (select json_array_elements_text (value->'legalForm')) ,
				array (select json_array_elements_text (value->'mainCountry')) ,
				array (select json_array_elements_text (value->'membershipMember')) ,
				array (select json_array_elements_text (value->'okpoCode')) ,
				array (select json_array_elements_text (value->'opencorporatesUrl')) ,
				array (select json_array_elements_text (value->'operatedVehicles')) ,
				array (select json_array_elements_text (value->'ownedVehicles')) ,
				array (select json_array_elements_text (value->'ownershipOwner')) ,
				array (select json_array_elements_text (value->'parent')) ,
				array (select json_array_elements_text (value->'phone')) ,
				array (select json_array_elements_text (value->'registrationNumber')) ,
				array (select json_array_elements_text (value->'sector')) ,
				array (select json_array_elements_text (value->'securities')) ,
				array (select json_array_elements_text (value->'status')) ,
				array (select json_array_elements_text (value->'subsidiaries')) ,
				array (select json_array_elements_text (value->'swiftBic')) ,
				array (select json_array_elements_text (value->'taxNumber')) ,
				array (select json_array_elements_text (value->'taxStatus')) ,
				array (select json_array_elements_text (value->'vatCode')) ,
				array (select json_array_elements_text (value->'website'))
				from temp_json ) on conflict(general_id) do nothing;
end;				 					
$$;

call sanctions.sp_fill_legal_entity_with_json();
delete from sanctions.legal_entity ;
select * from sanctions.legal_entity t ;

--////////////////////////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_person_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\person.txt';
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
				array (select json_array_elements_text (value->'title'))  
					from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_person_with_json();
delete from sanctions.person ;
select * from sanctions.person t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_address_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\address.txt';
		insert into sanctions.address(
				general_id ,
				city,
				country,
				"full",
				latitude,
				longitude,
				postOfficeBox,
				postalCode,
				region,
				remarks,
				state,
				street,
				street2,
				things)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'city')),
				array (select json_array_elements_text (value->'country')),
				array (select json_array_elements_text (value->'"full"')),
				array (select json_array_elements_text (value->'latitude')),
				array (select json_array_elements_text (value->'longitude')),
				array (select json_array_elements_text (value->'postOfficeBox')),
				array (select json_array_elements_text (value->'postalCode')),
				array (select json_array_elements_text (value->'region')),
				array (select json_array_elements_text (value->'remarks')),
				array (select json_array_elements_text (value->'state')),
				array (select json_array_elements_text (value->'street')),
				array (select json_array_elements_text (value->'street2')),
				array (select json_array_elements_text (value->'things'))  
					from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_address_with_json();
delete from sanctions.address ;
select * from sanctions.address t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_interval_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\interval.txt';
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
				array (select json_array_elements_text (value->'summary'))
					from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_interval_with_json();
delete from sanctions.interval ;
select * from sanctions.interval t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_value_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\value.txt';
		insert into sanctions.value(
				general_id ,
				amount,
				amountEur ,
				amountUsd ,
				currency )
			(select 
				value->>'general_id',
				value->>'amount',
				value->>'amountEur',
				value->>'amountUsd',
				array (select json_array_elements_text (value->'currency'))
					from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_value_with_json();
delete from sanctions.value ;
select * from sanctions.value t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_organization_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\organization.txt';
		insert into sanctions.organization(
				general_id ,
				directorshipOrganization,
				membershipOrganization)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'directorshipOrganization')),
				array (select json_array_elements_text (value->'membershipOrganization'))
					from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_organization_with_json();
delete from sanctions.organization ;
select * from sanctions.organization t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_identification_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\identification.txt';
		insert into sanctions.identification(
				general_id ,
				authority,
				country,
				holder,
				number,
				type)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'authority')),
				array (select json_array_elements_text (value->'country')),
				array (select json_array_elements_text (value->'holder')),
				array (select json_array_elements_text (value->'number')),
				array (select json_array_elements_text (value->'type'))
					from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_identification_with_json();
delete from sanctions.identification ;
select * from sanctions.identification t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_sanction_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\sanction.txt';
		insert into sanctions.sanction(
				general_id ,
				authority,
				authorityId,
				country,
				duration,
				entity,
				listingDate,
				program,
				provisions,
				reason,
				status,
				unscId)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'authority')),
				array (select json_array_elements_text (value->'authorityId')),
				array (select json_array_elements_text (value->'country')),
				array (select json_array_elements_text (value->'duration')),
				array (select json_array_elements_text (value->'entity')),
				array (select json_array_elements_text (value->'listingDate')),
				array (select json_array_elements_text (value->'program')),
				array (select json_array_elements_text (value->'provisions')),
				array (select json_array_elements_text (value->'reason')),
				array (select json_array_elements_text (value->'status')),
				array (select json_array_elements_text (value->'unscId'))
					from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_sanction_with_json();
delete from sanctions.sanction ;
select * from sanctions.sanction t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_security_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\security.txt';
		insert into sanctions.security(
				general_id ,
				classification,
				collateral,
				isin,
				issueDate,
				issuer,
				ticker,
				type)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'classification')),
				array (select json_array_elements_text (value->'collateral')),
				array (select json_array_elements_text (value->'isin')),
				array (select json_array_elements_text (value->'issueDate')),
				array (select json_array_elements_text (value->'issuer')),
				array (select json_array_elements_text (value->'ticker')),
				array (select json_array_elements_text (value->'type'))
					from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_security_with_json();
delete from sanctions.security ;
select * from sanctions.security t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_other_link_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\UnknownLink.txt';
		insert into sanctions.other_link(
				general_id ,
				object,
				subject)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'object')),
				array (select json_array_elements_text (value->'subject'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_other_link_with_json();
delete from sanctions.other_link ;
select * from sanctions.other_link t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_vessel_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\vessel.txt';
		insert into sanctions.vessel(
				general_id ,
				callSign,
				crsNumber,
				flag,
				grossRegisteredTonnage,
				imoNumber,
				mmsi,
				nameChangeDate,
				navigationArea,
				pastFlags,
				pastNames,
				pastTypes,
				registrationPort,
				tonnage)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'callSign')),
				array (select json_array_elements_text (value->'crsNumber')),
				array (select json_array_elements_text (value->'flag')),
				array (select json_array_elements_text (value->'grossRegisteredTonnage')),
				array (select json_array_elements_text (value->'imoNumber')),
				array (select json_array_elements_text (value->'mmsi')),
				array (select json_array_elements_text (value->'nameChangeDate')),
				array (select json_array_elements_text (value->'navigationArea')),
				array (select json_array_elements_text (value->'pastFlags')),
				array (select json_array_elements_text (value->'pastNames')),
				array (select json_array_elements_text (value->'pastTypes')),
				array (select json_array_elements_text (value->'registrationPort')),
				array (select json_array_elements_text (value->'tonnage'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_vessel_with_json();
delete from sanctions.vessel ;
select * from sanctions.vessel t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_asset_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\asset.txt';
		insert into sanctions.asset(
				general_id ,
				ownershipAsset)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'ownershipAsset'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_asset_with_json();
delete from sanctions.asset ;
select * from sanctions.asset t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_vehicle_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\vehicle.txt';
		insert into sanctions.vehicle(
				general_id ,
				buildDate,
				model,
				operator,
				owner,
				registrationDate,
				registrationNumber,
				type)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'buildDate')),
				array (select json_array_elements_text (value->'model')),
				array (select json_array_elements_text (value->'operator')),
				array (select json_array_elements_text (value->'owner')),
				array (select json_array_elements_text (value->'registrationDate')),
				array (select json_array_elements_text (value->'registrationNumber')),
				array (select json_array_elements_text (value->'type'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_vehicle_with_json();
delete from sanctions.vehicle ;
select * from sanctions.vehicle t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_airplane_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\airplane.txt';
		insert into sanctions.airplane(
				general_id ,
				icaoCode,
				manufacturer ,
				serialNumber)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'icaoCode')),
				array (select json_array_elements_text (value->'manufacturer')),
				array (select json_array_elements_text (value->'serialNumber'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_airplane_with_json();
delete from sanctions.airplane ;
select * from sanctions.airplane t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_associate_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\associate.txt';
		insert into sanctions.associate(
				general_id ,
				associate ,
				person ,
				relationship)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'associate')),
				array (select json_array_elements_text (value->'person')),
				array (select json_array_elements_text (value->'relationship'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_associate_with_json();
delete from sanctions.associate ;
select * from sanctions.associate t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_company_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\company.txt';
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
				array (select json_array_elements_text (value->'voenCode'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_company_with_json();
delete from sanctions.company ;
select * from sanctions.company t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_crypto_wallet_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\crypto_wallet.txt';
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
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'balance')),
				array (select json_array_elements_text (value->'balanceDate')),
				array (select json_array_elements_text (value->'creationDate')),
				array (select json_array_elements_text (value->'currencySymbol')),
				array (select json_array_elements_text (value->'holder')),
				array (select json_array_elements_text (value->'mangingExchange')),
				array (select json_array_elements_text (value->'privateKey')),
				array (select json_array_elements_text (value->'publicKey'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_crypto_wallet_with_json();
delete from sanctions.crypto_wallet ;
select * from sanctions.crypto_wallet t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_directorships_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\directorships.txt';
		insert into sanctions.directorships(
				general_id ,
				director,
				organization,
				secretary)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'director')),
				array (select json_array_elements_text (value->'organization')),
				array (select json_array_elements_text (value->'secretary'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_directorships_with_json();
delete from sanctions.directorships ;
select * from sanctions.directorships t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_interest_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\interest.txt';
		insert into sanctions.interest(
				general_id ,
				role ,
				status)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'role')),
				array (select json_array_elements_text (value->'status'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_interest_with_json();
delete from sanctions.interest ;
select * from sanctions.interest t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_family_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\family.txt';
		insert into sanctions.family(
				general_id ,
				person ,
				relationship,
				relative)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'person')),
				array (select json_array_elements_text (value->'relationship')),
				array (select json_array_elements_text (value->'relative'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_family_with_json();
delete from sanctions.family ;
select * from sanctions.family t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_membership_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\membership.txt';
		insert into sanctions.membership(
				general_id ,
				member,
				organization)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'member')),
				array (select json_array_elements_text (value->'organization'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_membership_with_json();
delete from sanctions.membership ;
select * from sanctions.membership t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_ownership_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\ownership.txt';
		insert into sanctions.ownership(
				general_id ,
				asset,
				legalBasis,
				owner,
				ownershipType,
				percentage,
				sharesCount,
				sharesCurrency,
				sharesType,
				sharesValue)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'asset')),
				array (select json_array_elements_text (value->'legalBasis')),
				array (select json_array_elements_text (value->'owner')),
				array (select json_array_elements_text (value->'ownershipType')),
				array (select json_array_elements_text (value->'percentage')),
				array (select json_array_elements_text (value->'sharesCount')),
				array (select json_array_elements_text (value->'sharesCurrency')),
				array (select json_array_elements_text (value->'sharesType')),
				array (select json_array_elements_text (value->'sharesValue'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_ownership_with_json();
delete from sanctions.ownership ;
select * from sanctions.ownership t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_passport_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\passport.txt';
		insert into sanctions.passport(
				general_id ,
				birthDate,
				birthPlace,
				gender,
				givenName,
				passportNumber,
				personalNumber,
				surname)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'birthDate')),
				array (select json_array_elements_text (value->'birthPlace')),
				array (select json_array_elements_text (value->'gender')),
				array (select json_array_elements_text (value->'givenName')),
				array (select json_array_elements_text (value->'passportNumber')),
				array (select json_array_elements_text (value->'personalNumber')),
				array (select json_array_elements_text (value->'surname'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_passport_with_json();
delete from sanctions.passport ;
select * from sanctions.passport t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_representation_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\representation.txt';
		insert into sanctions.representation(
				general_id ,
				agent,
				client)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'agent')),
				array (select json_array_elements_text (value->'client'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_representation_with_json();
delete from sanctions.representation ;
select * from sanctions.representation t ;

--/////////////////////////////////////////////////////////////////////

create or replace procedure sanctions.sp_fill_publicBody_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\publicBody.txt';
		insert into sanctions.publicBody(
				general_id ,
				directorshipOrganization,
				membershipOrganization)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'directorshipOrganization')),
				array (select json_array_elements_text (value->'membershipOrganization'))
				from temp_json ) on conflict(general_id) do nothing;
end;
$$;

call sanctions.sp_fill_publicBody_with_json();
delete from sanctions.publicBody ;
select * from sanctions.publicBody t ;

copy sanctions.country(code,label) from 
'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\const_data\country_utf-8.csv' (delimiter ';',format csv);

select * from sanctions.country;

copy sanctions.topics(code,label) from 
'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\const_data\topics_utf-8.csv' (delimiter ';',format csv);

select * from sanctions.topics;
