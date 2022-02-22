

create or replace function sanctions.fn_one_fill_head_tables()
returns void as
$$
begin

		create temporary table  temp_json1 (value json) on commit drop;
		copy temp_json1 from 'C:\Essence_files\entities.txt';
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
					from temp_json1 ) on conflict(id) do nothing;



		create temporary table  temp_json2 (value json) on commit drop;
		copy temp_json2 from 'C:\Essence_files\thing.txt';
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
					from temp_json2 ) on conflict(general_id) do nothing;



		create temporary table  temp_json3 (value json) on commit drop;
		copy temp_json3 from 'C:\Essence_files\LegalEntity.txt';
		insert into sanctions.legalentity(
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
				from temp_json3 ) on conflict(general_id) do nothing;
				 					


		create temporary table  temp_json4 (value json) on commit drop;
		copy temp_json4 from 'C:\Essence_files\person.txt';
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
					from temp_json4 ) on conflict(general_id) do nothing;



		create temporary table  temp_json5 (value json) on commit drop;
		copy temp_json5 from 'C:\Essence_files\address.txt';
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
					from temp_json5 ) on conflict(general_id) do nothing;



		create temporary table  temp_json6 (value json) on commit drop;
		copy temp_json6 from 'C:\Essence_files\interval.txt';
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
					from temp_json6 ) on conflict(general_id) do nothing;



		create temporary table  temp_json7 (value json) on commit drop;
		copy temp_json7 from 'C:\Essence_files\value.txt';
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
					from temp_json7 ) on conflict(general_id) do nothing;



		create temporary table  temp_json8 (value json) on commit drop;
		copy temp_json8 from 'C:\Essence_files\organization.txt';
		insert into sanctions.organization(
				general_id ,
				directorshipOrganization,
				membershipOrganization)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'directorshipOrganization')),
				array (select json_array_elements_text (value->'membershipOrganization'))
					from temp_json8 ) on conflict(general_id) do nothing;



		create temporary table  temp_json9 (value json) on commit drop;
		copy temp_json9 from 'C:\Essence_files\identification.txt';
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
					from temp_json9 ) on conflict(general_id) do nothing;



		create temporary table  temp_json10 (value json) on commit drop;
		copy temp_json10 from 'C:\Essence_files\sanction.txt';
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
					from temp_json10 ) on conflict(general_id) do nothing;


--begin
--		create temporary table  temp_json11 (value json) on commit drop;
--		copy temp_json11 from 'C:\Essence_files\security.txt';
--		insert into sanctions.security(
--				general_id ,
--				classification,
--				collateral,
--				isin,
--				issueDate,
--				issuer,
--				ticker,
--				type)
--			(select 
--				value->>'general_id',
--				array (select json_array_elements_text (value->'classification')),
--				array (select json_array_elements_text (value->'collateral')),
--				array (select json_array_elements_text (value->'isin')),
--				array (select json_array_elements_text (value->'issueDate')),
--				array (select json_array_elements_text (value->'issuer')),
--				array (select json_array_elements_text (value->'ticker')),
--				array (select json_array_elements_text (value->'type'))
--					from temp_json11 ) on conflict(general_id) do nothing;
--


		create temporary table  temp_json12 (value json) on commit drop;
		copy temp_json12 from 'C:\Essence_files\UnknownLink.txt';
		insert into sanctions.other_link(
				general_id ,
				object,
				subject)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'object')),
				array (select json_array_elements_text (value->'subject'))
				from temp_json12 ) on conflict(general_id) do nothing;



		create temporary table  temp_json13 (value json) on commit drop;
		copy temp_json13 from 'C:\Essence_files\vessel.txt';
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
				from temp_json13 ) on conflict(general_id) do nothing;



		create temporary table  temp_json14 (value json) on commit drop;
		copy temp_json14 from 'C:\Essence_files\asset.txt';
		insert into sanctions.asset(
				general_id ,
				ownershipAsset)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'ownershipAsset'))
				from temp_json14 ) on conflict(general_id) do nothing;



		create temporary table  temp_json15 (value json) on commit drop;
		copy temp_json15 from 'C:\Essence_files\vehicle.txt';
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
				from temp_json15 ) on conflict(general_id) do nothing;



		create temporary table  temp_json16 (value json) on commit drop;
		copy temp_json16 from 'C:\Essence_files\airplane.txt';
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
				from temp_json16 ) on conflict(general_id) do nothing;


--begin
--		create temporary table  temp_json17 (value json) on commit drop;
--		copy temp_json17 from 'C:\Essence_files\associate.txt';
--		insert into sanctions.associate(
--				general_id ,
--				associate ,
--				person ,
--				relationship)
--			(select 
--				value->>'general_id',
--				array (select json_array_elements_text (value->'associate')),
--				array (select json_array_elements_text (value->'person')),
--				array (select json_array_elements_text (value->'relationship'))
--				from temp_json17 ) on conflict(general_id) do nothing;
--


		create temporary table  temp_json18 (value json) on commit drop;
		copy temp_json18 from 'C:\Essence_files\company.txt';
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
				from temp_json18 ) on conflict(general_id) do nothing;



		create temporary table  temp_json19 (value json) on commit drop;
		copy temp_json19 from 'C:\Essence_files\CryptoWallet.txt';
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
				from temp_json19 ) on conflict(general_id) do nothing;



		create temporary table  temp_json20 (value json) on commit drop;
		copy temp_json20 from 'C:\Essence_files\Directorship.txt';
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
				from temp_json20 ) on conflict(general_id) do nothing;



		create temporary table  temp_json21 (value json) on commit drop;
		copy temp_json21 from 'C:\Essence_files\interest.txt';
		insert into sanctions.interest(
				general_id ,
				role ,
				status)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'role')),
				array (select json_array_elements_text (value->'status'))
				from temp_json21 ) on conflict(general_id) do nothing;



		create temporary table  temp_json22 (value json) on commit drop;
		copy temp_json22 from 'C:\Essence_files\family.txt';
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
				from temp_json22 ) on conflict(general_id) do nothing;



		create temporary table  temp_json23 (value json) on commit drop;
		copy temp_json23 from 'C:\Essence_files\membership.txt';
		insert into sanctions.membership(
				general_id ,
				member,
				organization)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'member')),
				array (select json_array_elements_text (value->'organization'))
				from temp_json23 ) on conflict(general_id) do nothing;



		create temporary table  temp_json24 (value json) on commit drop;
		copy temp_json24 from 'C:\Essence_files\ownership.txt';
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
				from temp_json24 ) on conflict(general_id) do nothing;



		create temporary table  temp_json25 (value json) on commit drop;
		copy temp_json25 from 'C:\Essence_files\passport.txt';
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
				from temp_json25 ) on conflict(general_id) do nothing;



		create temporary table  temp_json26 (value json) on commit drop;
		copy temp_json26 from 'C:\Essence_files\representation.txt';
		insert into sanctions.representation(
				general_id ,
				agent,
				client)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'agent')),
				array (select json_array_elements_text (value->'client'))
				from temp_json26 ) on conflict(general_id) do nothing;


--begin
--		create temporary table  temp_json27 (value json) on commit drop;
--		copy temp_json27 from 'C:\Essence_files\publicBody.txt';
--		insert into sanctions.publicBody(
--				general_id ,
--				directorshipOrganization,
--				membershipOrganization)
--			(select 
--				value->>'general_id',
--				array (select json_array_elements_text (value->'directorshipOrganization')),
--				array (select json_array_elements_text (value->'membershipOrganization'))
--				from temp_json27 ) on conflict(general_id) do nothing;
--

delete from sanctions.country;
copy sanctions.country(code,label) from 
'C:\Essence_files\country_utf-8.csv' (delimiter ';',format csv) ;

delete from sanctions.topics;
copy sanctions.topics(code,label) from 
'C:\Essence_files\topics_utf-8.csv' (delimiter ';',format csv);


end;
$$ language plpgsql;

