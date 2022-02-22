create or replace function sanctions.fn_one_new_fill_head_tables()
returns void as
$$
begin
	
	create temporary table  temp_json (value json) on commit drop;
				
		copy temp_json from 'C:\Essence_files\Entities.txt';
			
create table entities
(id_int serial,
caption text,
datasets text array,
first_seen text,
id text,
last_seen text,
referents text array,
schema text,
target boolean,
controlCount int
);

insert into entities(
				caption ,
				datasets  ,
				first_seen ,
				id ,
				last_seen ,
				referents  ,
				schema ,
				target,
				controlCount)
			(select 
				value->>'caption',
				array (select json_array_elements_text (value->'datasets')) as dtsets,
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array (select json_array_elements_text (value->'referents')) as rfs,
				value->>'schema',
				(value->>'target')::boolean,
				(value->>'controlCount')::integer
					from temp_json ) ;

insert into sanctions.entities(
				caption ,
				datasets  ,
				first_seen ,
				id ,
				last_seen ,
				referents  ,
				schema ,
				target
				)
					(select caption ,
							datasets  ,
							first_seen ,
							id ,
							last_seen ,
							referents  ,
							schema ,
							target from 
								(select *,row_number() over(partition by id order by controlCount desc) from entities le)t where row_number = 1
					);
		
insert into sanctions.entities_true (caption ,
									datasets  ,
									first_seen ,
									id ,
									last_seen ,
									referents  ,
									schema 
									
									)	(select caption ,
												datasets  ,
												first_seen ,
												id ,
												last_seen ,
												referents  ,
												schema   from sanctions.entities e where e.target = true 
										);
				
truncate temp_json;		
drop table entities;

copy sanctions.country(code,label) from 
'C:\Essence_files\country_utf-8.csv' (delimiter ';',format csv) ;


copy sanctions.topics(code,label) from 
'C:\Essence_files\topics_utf-8.csv' (delimiter ';',format csv);

copy temp_json from 'C:\Essence_files\address.txt';
	
create table addr
(general_id text,
city text array,
country text array,
"full" text array,
latitude text array,
longitude text array,
postOfficeBox text array,
postalCode text array,
region text array,
remarks text array,
state text array,
street text array,
street2 text array,
things text array,
controlCount int
);	
	
		insert into addr(
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
				things,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'city')),
				array (select json_array_elements_text (value->'country')),
				array (select json_array_elements_text (value->'full')),
				array (select json_array_elements_text (value->'latitude')),
				array (select json_array_elements_text (value->'longitude')),
				array (select json_array_elements_text (value->'postOfficeBox')),
				array (select json_array_elements_text (value->'postalCode')),
				array (select json_array_elements_text (value->'region')),
				array (select json_array_elements_text (value->'remarks')),
				array (select json_array_elements_text (value->'state')),
				array (select json_array_elements_text (value->'street')),
				array (select json_array_elements_text (value->'street2')),
				array (select json_array_elements_text (value->'things')) ,
				(value->>'controlCount')::integer
					from temp_json );
	
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
			( select general_id ,
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
				things from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from addr le
)t where row_number = 1) on conflict (general_id) do update set "full" = excluded.full;

drop table addr;

truncate temp_json;

copy temp_json from 'C:\Essence_files\airplane.txt';

create table air
(general_id text,
icaoCode text array,
manufacturer text array,
serialNumber text array,
controlCount int
);
		insert into air(
				general_id ,
				icaoCode,
				manufacturer ,
				serialNumber,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'icaoCode')),
				array (select json_array_elements_text (value->'manufacturer')),
				array (select json_array_elements_text (value->'serialNumber')),
				(value->>'controlCount')::integer
				from temp_json );

insert into sanctions.airplane(
				general_id ,
				icaoCode,
				manufacturer ,
				serialNumber)
				(select general_id ,
				icaoCode,
				manufacturer ,
				serialNumber from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from air le
)t where row_number = 1);

drop table air;
				
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
				
insert into sanctions.asset(
				general_id ,
				ownershipAsset)
				(select general_id ,
				ownershipAsset from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from ass le
)t where row_number = 1);

drop table ass;
				
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

drop table com;

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

drop table cryp;
			
truncate temp_json;

copy temp_json from 'C:\Essence_files\Directorship.txt';
		
create table dir
(general_id text,
director text array,
organization text array,
secretary text array,
controlCount int
);

insert into dir(
				general_id ,
				director,
				organization,
				secretary,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'director')),
				array (select json_array_elements_text (value->'organization')),
				array (select json_array_elements_text (value->'secretary')),
				(value->>'controlCount')::integer
				from temp_json ) ;

insert into sanctions.directorships(
				general_id ,
				director,
				organization,
				secretary)
				(select general_id ,
				director,
				organization,
				secretary from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from dir le
)t where row_number = 1);

drop table dir;						
			
truncate temp_json;

copy temp_json from 'C:\Essence_files\family.txt';
		
create table fam
(general_id text,
person text array,
relationship text array,
relative text array,
controlCount int
);
insert into fam(
				general_id ,
				person ,
				relationship,
				relative,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'person')),
				array (select json_array_elements_text (value->'relationship')),
				array (select json_array_elements_text (value->'relative')),
				(value->>'controlCount')::integer
				from temp_json );
				
insert into sanctions.family(
				general_id ,
				person ,
				relationship,
				relative)
				(select general_id ,
				person ,
				relationship,
				relative from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from fam le
)t where row_number = 1);

drop table fam;		
			
truncate temp_json;

copy temp_json from 'C:\Essence_files\identification.txt';

create table ident
(general_id text,
authority text array,
country text array,
holder text array,
number text array,
type text array,
controlCount int
);
		insert into ident(
				general_id ,
				authority,
				country,
				holder,
				number,
				type,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'authority')),
				array (select json_array_elements_text (value->'country')),
				array (select json_array_elements_text (value->'holder')),
				array (select json_array_elements_text (value->'number')),
				array (select json_array_elements_text (value->'type')),
				(value->>'controlCount')::integer
					from temp_json ) ;

insert into sanctions.identification(
				general_id ,
				authority,
				country,
				holder,
				number,
				type)
				(select general_id ,
				authority,
				country,
				holder,
				number,
				type from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from ident le
)t where row_number = 1);

drop table ident;			
				
truncate temp_json;

copy temp_json from 'C:\Essence_files\interest.txt';

create table inter
(general_id text,
role text array,
status text array,
controlCount int
);
		insert into inter(
				general_id ,
				role ,
				status,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'role')),
				array (select json_array_elements_text (value->'status')),
				(value->>'controlCount')::integer
				from temp_json ) ;

insert into sanctions.interest(
				general_id ,
				role ,
				status)
				(select general_id ,
				role ,
				status from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from inter le
)t where row_number = 1);

drop table inter;							
				
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

drop table inte;
				
truncate temp_json;

	copy temp_json from 'C:\Essence_files\LegalEntity.txt';

create table legalentity
(general_id text,
agencyClient text array,
agentRepresentation text array,
bvdId text array,
classification text array,
cryptoWallets text array,
directorshipDirector text array,
dissolutionDate text array,
dunsCode text array,
email text array,
icijId text array,
idNumber text array,
identificiation text array,
incorporationDate text array,
innCode text array,
jurisdiction text array,
legalForm text array,
mainCountry text array,
membershipMember text array,
okpoCode text array,
opencorporatesUrl text array,
operatedVehicles text array,
ownedVehicles text array,
ownershipOwner text array,
parent text array,
phone text array,
registrationNumber text array,
sector text array,
securities text array,
status text array,
subsidiaries text array,
swiftBic text array,
taxNumber text array,
taxStatus text array,
vatCode text array,
website text array,
controlCount int

);

		insert into legalentity(
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
				website,
				controlCount) 
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
				array (select json_array_elements_text (value->'website')),
				(value->>'controlCount')::integer
				from temp_json );

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
				website
				) 
		(select	general_id,
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
				website from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from legalentity le
)t where row_number = 1
			);

drop table legalentity;
				
truncate temp_json;

copy temp_json from 'C:\Essence_files\membership.txt';
		
create table mem
(general_id text,
member text array,
organization text array,
controlCount int
);
insert into mem(
				general_id ,
				member,
				organization,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'member')),
				array (select json_array_elements_text (value->'organization')),
				(value->>'controlCount')::integer
				from temp_json ) ;
				

insert into sanctions.membership(
				general_id ,
				member,
				organization)
				(select general_id ,
				member,
				organization from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from mem le
)t where row_number = 1);

drop table mem;				
				
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

insert into sanctions.organization(
				general_id ,
				directorshipOrganization,
				membershipOrganization)
				(select general_id ,
				directorshipOrganization,
				membershipOrganization from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from organ le
)t where row_number = 1);

drop table organ;

truncate temp_json;

copy temp_json from 'C:\Essence_files\UnknownLink.txt';

create table other
(general_id text,
object text array,
subject text array,
controlCount int
);
		insert into other(
				general_id ,
				object,
				subject,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'object')),
				array (select json_array_elements_text (value->'subject')),
				(value->>'controlCount')::integer
				from temp_json ) ;
			

insert into sanctions.other_link(
				general_id ,
				object,
				subject)
				(select general_id ,
				object,
				subject from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from other le
)t where row_number = 1);

drop table other;

truncate temp_json;

copy temp_json from 'C:\Essence_files\ownership.txt';
	
create table own
(general_id text,
asset text array,
legalBasis text array,
owner text array,
ownershipType text array,
percentage text array,
sharesCount text array,
sharesCurrency text array,
sharesType text array,
sharesValue text array,
controlCount int
);
insert into own(
				general_id ,
				asset,
				legalBasis,
				owner,
				ownershipType,
				percentage,
				sharesCount,
				sharesCurrency,
				sharesType,
				sharesValue,
				controlCount)
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
				array (select json_array_elements_text (value->'sharesValue')),
				(value->>'controlCount')::integer
				from temp_json );
			

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
				(select general_id ,
				asset,
				legalBasis,
				owner,
				ownershipType,
				percentage,
				sharesCount,
				sharesCurrency,
				sharesType,
				sharesValue from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from own le
)t where row_number = 1);

drop table own;
			
truncate temp_json;

copy temp_json from 'C:\Essence_files\passport.txt';
	
create table pas
(general_id text,
birthDate text array,
birthPlace text array,
gender text array,
givenName text array,
passportNumber text array,
personalNumber text array,
surname text array,
controlCount int
);

insert into pas(
				general_id ,
				birthDate,
				birthPlace,
				gender,
				givenName,
				passportNumber,
				personalNumber,
				surname,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'birthDate')),
				array (select json_array_elements_text (value->'birthPlace')),
				array (select json_array_elements_text (value->'gender')),
				array (select json_array_elements_text (value->'givenName')),
				array (select json_array_elements_text (value->'passportNumber')),
				array (select json_array_elements_text (value->'personalNumber')),
				array (select json_array_elements_text (value->'surname')),
				(value->>'controlCount')::integer
				from temp_json ) ;

insert into sanctions.passport(
				general_id ,
				birthDate,
				birthPlace,
				gender,
				givenName,
				passportNumber,
				personalNumber,
				surname)
				(select general_id ,
				birthDate,
				birthPlace,
				gender,
				givenName,
				passportNumber,
				personalNumber,
				surname from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from pas le
)t where row_number = 1);

drop table pas;

truncate temp_json;

create table pers
(general_id text,
associates text array,
associations text array,
birthDate text array,
birthPlace text array,
deathDate text array,
education text array,
ethnicity text array,
familyPerson text array,
familyRelative text array,
fatherName text array,
firstName text array,
gender text array,
lastName text array,
middleName text array,
motherName text array,
nationality text array,
passportNumber text array,
political text array,
position text array,
religion text array,
secondName text array,
title text array,
controlCount int
);

copy temp_json from 'C:\Essence_files\person.txt';

		insert into pers(
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
				title,
				controlCount)
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
				array (select json_array_elements_text (value->'title')) ,
				(value->>'controlCount')::integer
					from temp_json ) ;

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
			(select general_id ,
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
				title from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from pers le
)t where row_number = 1
				 ) ;
				
drop table pers;		
				
truncate temp_json;

copy temp_json from 'C:\Essence_files\representation.txt';
		
create table rep
(general_id text,
agent text array,
client text array,
controlCount int
);

insert into rep(
				general_id ,
				agent,
				client,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'agent')),
				array (select json_array_elements_text (value->'client')),
				(value->>'controlCount')::integer
				from temp_json ) ;
				

insert into sanctions.representation(
				general_id ,
				agent,
				client)
				(select general_id ,
				agent,
				client from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from rep le
)t where row_number = 1);

drop table rep;
			
truncate temp_json;

copy temp_json from 'C:\Essence_files\sanction.txt';

create table sanct
(general_id text,
authority text array,
authorityId text array,
country text array,
duration text array,
entity text array,
listingDate text array,
program text array,
provisions text array,
reason text array,
status text array,
unscId text array,
controlCount int
);
		insert into sanct(
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
				unscId,
				controlCount)
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
				array (select json_array_elements_text (value->'unscId')),
				(value->>'controlCount')::integer
					from temp_json );

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
				(select general_id ,
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
				unscId from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from sanct le
)t where row_number = 1);

drop table sanct;

truncate temp_json;

copy temp_json from 'C:\Essence_files\Thing.txt';

create table thi
(general_id text,
address text array,
addressEntity text array,
alias text array,
country text array,
description text array,
keywords text array,
modifiedAt text array,
name text array,
notes text array,
previousName text array,
program text array,
publisher text array,
publisherUrl text array,
retrievedAt text array,
sanctions text array,
sourceUrl text array,
summary text array,
topics text array,
unknownLinkFrom text array,
unknownLinkTo text array,
weakAlias text array,
wikidataId text array,
wikipediaUrl text array,
controlCount int
);

insert into thi(
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
				wikipediaUrl,
				controlCount )
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
				array (select json_array_elements_text (value->'wikipediaUrl')) ,
				(value->>'controlCount')::integer
					from temp_json ) ;
					
				
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
			( select general_id ,
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
				wikipediaUrl from (	
select *,row_number() over(partition by general_id order by controlCount desc) from thi le
)t where row_number = 1) ;			

drop table thi;		
								
truncate temp_json;

copy temp_json from 'C:\Essence_files\Value.txt';

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

drop table valu;

truncate temp_json;

copy temp_json from 'C:\Essence_files\vehicle.txt';

create table veh
(general_id text,
buildDate text array,
model text array,
operator text array,
owner text array,
registrationDate text array,
registrationNumber text array,
type text array,
controlCount int
);
		insert into veh(
				general_id ,
				buildDate,
				model,
				operator,
				owner,
				registrationDate,
				registrationNumber,
				type,
				controlCount)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'buildDate')),
				array (select json_array_elements_text (value->'model')),
				array (select json_array_elements_text (value->'operator')),
				array (select json_array_elements_text (value->'owner')),
				array (select json_array_elements_text (value->'registrationDate')),
				array (select json_array_elements_text (value->'registrationNumber')),
				array (select json_array_elements_text (value->'type')),
				(value->>'controlCount')::integer
				from temp_json ) ;

insert into sanctions.vehicle(
				general_id ,
				buildDate,
				model,
				operator,
				owner,
				registrationDate,
				registrationNumber,
				type)
				(select general_id ,
				buildDate,
				model,
				operator,
				owner,
				registrationDate,
				registrationNumber,
				type from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from veh le
)t where row_number = 1);

drop table veh;
			
truncate temp_json;

copy temp_json from 'C:\Essence_files\vessel.txt';

create table ves
(general_id text,
callSign text array,
crsNumber text array,
flag text array,
grossRegisteredTonnage text array,
imoNumber text array,
mmsi text array,
nameChangeDate text array,
navigationArea text array,
pastFlags text array,
pastNames text array,
pastTypes text array,
registrationPort text array,
tonnage text array,
controlCount int
);
		insert into ves(
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
				tonnage,
				controlCount)
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
				array (select json_array_elements_text (value->'tonnage')),
				(value->>'controlCount')::integer
				from temp_json ) ;

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
				(select general_id ,
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
				tonnage from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from ves le
)t where row_number = 1);

drop table ves;

end;
$$ language plpgsql;
			
			
			
			
			
			
			
			
			
			
			
			
			
						
			
			
			
			
			
			
			
			









				
				
				
				
				
				
				
				
										
				
				
				
				
				
				
				
				
				
				
				
				
				
				
			
			
			
			
			
			
			
			
			
			
						
			
			
			



								
				
				
				
				
				
				
				
				
				
				
				
							
			
			
			
			
							
				
				
				
				
				
				
				
				
				
				
				
				