

		create  table if not exists temp_json (value json) ;
	
		copy temp_json from 'C:\Essence_files\LegalEntity.txt';
	
	select * from temp_json;

drop table temp_json;

drop table legalentity;

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

select count(*) from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from legalentity le
)t where row_number = 1;
--9398
--select * from (
--select le.*,rank() over(partition by general_id order by controlCount desc) from legalentity le
--)t where rank >5;
--
--select count(*) from (
--select le.*,rank() over(partition by general_id order by controlCount desc) from legalentity le
--)t where rank = 1;
--count 11886

select count(*) from sanctions.legalentity;
--count 9393

drop table le;

create table le
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
primary key(general_id),
foreign key(general_id) references ent(id)
);

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
--	insert 9398	
	and t.general_id in (select e.id from sanctions.entities e)
			);
-- insert 9378 old data

		select * from le where general_id = 'NK-QthD3sQ5gXpBrH3DXvd58m';
	
	copy (
select t.general_id from (	
select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from legalentity le
)t where row_number = 1
	except
		(select	general_id
			 from (	
					select *,row_number() over(partition by general_id order by controlCount desc),count(*) over(partition by general_id) from legalentity le
					)t where row_number = 1
						and t.general_id in (select e.id from sanctions.entities e)
								)
		) to 'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\footer\copmare.txt';
		
	select * from sanctions.entities where id = 'NK-4pngvNPGMMv4NJk9dH6eEj';