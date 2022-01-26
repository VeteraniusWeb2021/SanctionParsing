create database data_ocean_sanction_parsing;

create schema sanctions;

create table sanctions.entities
(id_int serial,
caption text,
datasets text array,
first_seen text,
id text,
last_seen text,
referents text array,
schema text,
target text,
primary key (id),
unique(id_int)
);



create table sanctions.thing
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
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create table sanctions.legal_entity
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
foreign key(general_id) references sanctions.entities(id)
);

create table sanctions.person
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
primary key(general_id),
foreign key(general_id) references sanctions.entities(id)
);

--drop schema sanctions cascade;
--DELETE FROM sanction.entities;

create or replace procedure sanctions.sp_fill_entities_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\Entities.json';
		insert into sanctions.entities
			(select 
				value->>'caption',
				array[value->>'datasets'],
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array[value->>'referents'],
				value->>'schema',
				value->>'target'
					from temp_json);
end;
$$;

--create or replace procedure sanctions.sp_fill_entities_with_text_json()
--language plpgsql as
--$$
--begin
		create  table  temp_json (value text) ;
		copy temp_json from 'G:\database\veteranius\Entities.json';
		insert into sanctions.entities
			(select 
				values->>'caption',
				array[values->>'datasets'],
				values->>'first_seen',
				values->>'id',
				values->>'last_seen',
				values->>'referents',
				values->>'schema',
				values->>'target'
					from (
							select json_array_elements(replace(value,'\','\\')::json) as values 
	           				from   temp_json)a);
--end;
--$$;

drop table temp_json;
--call sanctions.sp_fill_entities_with_json();
--select * from sanctions.entities e ;

--create or replace procedure sanctions.sp_fill_entities_with_json(in_json_entities json)
--language plpgsql as
--$$
--begin
--	insert into sanctions.entities 
--		(select * from json_to_record
--	($1) as x
--	(caption text,
--	datasets text array,
--	first_seen text,
--	id text,
--	last_seen text,
--	referents text,
--	schema text,
--	target text));
--end;
--$$;
--
--create or replace procedure sanctions.sp_fill_thing_with_json(in_json_thing json)
--language plpgsql as
--$$
--begin
--	insert into sanctions.thing 
--		(select * from json_to_record
--	($1) as x
--	(general_id text,
--	address text array,
--	addressEntity text array,
--	alias text array,
--	country text array,
--	description text array,
--	keywords text array,
--	modifiedAt text array,
--	name text array,
--	notes text array,
--	previousName text array,
--	program text array,
--	publisher text array,
--	publisherUrl text array,
--	retrievedAt text array,
--	sanctions text array,
--	sourceUrl text array,
--	summary text array,
--	topics text array,
--	unknownLinkFrom text array,
--	unknownLinkTo text array,
--	weakAlias text array,
--	wikidataId text array,
--	wikipediaUrl text array));
--end;
--$$;
--
--create or replace procedure sanctions.sp_fill_legal_entity_with_json(in_json_legal_entity json)
--language plpgsql as
--$$
--begin
--	insert into sanctions.legal_entity 
--		(general_id text,
--	agencyClient text array,
--	agentRepresentation text array,
--	bvdId text array,
--	classification text array,
--	cryptoWallets text array,
--	directorshipDirector text array,
--	dissolutionDate text array,
--	dunsCode text array,
--	email text array,
--	icijId text array,
--	idNumber text array,
--	identificiation text array,
--	incorporationDate text array,
--	innCode text array,
--	jurisdiction text array,
--	legalForm text array,
--	mainCountry text array,
--	membershipMember text array,
--	okpoCode text array,
--	opencorporatesUrl text array,
--	operatedVehicles text array,
--	ownedVehicles text array,
--	ownershipOwner text array,
--	parent text array,
--	phone text array,
--	registrationNumber text array,
--	sector text array,
--	securities text array,
--	status text array,
--	subsidiaries text array,
--	swiftBic text array,
--	taxNumber text array,
--	taxStatus text array,
--	vatCode text array,
--	website text array));
--end;
--$$;
--
--create or replace procedure sanctions.sp_fill_person_with_json(in_json_person json)
--language plpgsql as
--$$
--begin
--	insert into sanctions.person 
--		(select * from json_to_record
--	($1) as x
--	(general_id text,
--	associates text array,
--	associations text array,
--	birthDate text array,
--	birthPlace text array,
--	deathDate text array,
--	education text array,
--	ethnicity text array,
--	familyPerson text array,
--	familyRelative text array,
--	fatherName text array,
--	firstName text array,
--	gender text array,
--	lastName text array,
--	middleName text array,
--	motherName text array,
--	nationality text array,
--	passportNumber text array,
--	political text array,
--	position text array,
--	religion text array,
--	secondName text array,
--	title text array));
--end;
--$$;
--create or replace procedure sanctions.sp_fill_entities
--(in_caption text,
--in_datasets text array,
--in_first_seen text,
--in_id text,
--in_last_seen text,
--in_referents text,
--in_schema text,
--in_target text)
--language plpgsql as $$
--begin 
--	insert into sanctions.entities
--	(caption,
--	datasets,
--	first_seen,
--	id,
--	last_seen,
--	referents,
--	schema,
--	target) values ($1,$2,$3,$4,$5,$6,$7,$8);
--end;
--$$;
--
--call  sanctions.sp_fill_entities('caption','{data,sets}','first','idsdfjefjejf','last','referen','schema','target');
--call  sanctions.sp_fill_entities('caption','{data,sets}','first','idsdfjejf','last','referen','schema','target');

--create or replace procedure sanctions.sp_fill_thing
--	(in_general_id text,
--	in_address text array,
--	in_addressEntity text array,
--	in_alias text array,
--	in_country text array,
--	in_description text array,
--	in_keywords text array,
--	in_modifiedAt text array,
--	in_name text array,
--	in_notes text array,
--	in_previousName text array,
--	in_program text array,
--	in_publisher text array,
--	in_publisherUrl text array,
--	in_retrievedAt text array,
--	in_sanctions text array,
--	in_sourceUrl text array,
--	in_summary text array,
--	in_topics text array,
--	in_unknownLinkFrom text array,
--	in_unknownLinkTo text array,
--	in_weakAlias text array,
--	in_wikidataId text array,
--	in_wikipediaUrl text array)
--language plpgsql as $$
--begin 
--	insert into sanctions.thing 
--	(general_id,
--	address,
--	addressEntity,
--	alias,
--	country,
--	description,
--	keywords,
--	modifiedAt,
--	name,
--	notes,
--	previousName,
--	program,
--	publisher,
--	publisherUrl,
--	retrievedAt,
--	sanctions,
--	sourceUrl,
--	summary,
--	topics,
--	unknownLinkFrom,
--	unknownLinkTo,
--	weakAlias,
--	wikidataId,
--	wikipediaUrl) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24);
--end;
--$$;
--
--call sanctions.sp_fill_thing('idsdfjefjejf','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}','{data,sets}');
--
--call sanctions.sp_fill_thing('idsdfjejf','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}','{data,sets}');

--create or replace procedure sanctions.sp_fill_legal_entity
--	(in_general_id text,
--	in_agencyClient text array,
--	in_agentRepresentation text array,
--	in_bvdId text array,
--	in_classification text array,
--	in_cryptoWallets text array,
--	in_directorshipDirector text array,
--	in_dissolutionDate text array,
--	in_dunsCode text array,
--	in_email text array,
--	in_icijId text array,
--	in_idNumber text array,
--	in_identificiation text array,
--	in_incorporationDate text array,
--	in_innCode text array,
--	in_jurisdiction text array,
--	in_legalForm text array,
--	in_mainCountry text array,
--	in_membershipMember text array,
--	in_okpoCode text array,
--	in_opencorporatesUrl text array,
--	in_operatedVehicles text array,
--	in_ownedVehicles text array,
--	in_ownershipOwner text array,
--	in_parent text array,
--	in_phone text array,
--	in_registrationNumber text array,
--	in_sector text array,
--	in_securities text array,
--	in_status text array,
--	in_subsidiaries text array,
--	in_swiftBic text array,
--	in_taxNumber text array,
--	in_taxStatus text array,
--	in_vatCode text array,
--	in_website text array)
--language plpgsql as $$
--begin 
--	insert into sanctions.legal_entity 
--	(general_id,
--	agencyClient,
--	agentRepresentation,
--	bvdId,
--	classification,
--	cryptoWallets,
--	directorshipDirector,
--	dissolutionDate,
--	dunsCode,
--	email,
--	icijId,
--	idNumber,
--	identificiation,
--	incorporationDate,
--	innCode,
--	jurisdiction,
--	legalForm,
--	mainCountry,
--	membershipMember,
--	okpoCode,
--	opencorporatesUrl,
--	operatedVehicles,
--	ownedVehicles,
--	ownershipOwner,
--	parent,
--	phone,
--	registrationNumber,
--	sector,
--	securities,
--	status,
--	subsidiaries,
--	swiftBic,
--	taxNumber,
--	taxStatus,
--	vatCode,
--	website)
--	 values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,
--	$23,$24,$25,$26,$27,$28,$29,$30,$31,$32,$33,$34,$35,$36);
--end;
--$$;

--call sanctions.sp_fill_legal_entity('idsdfjefjejf','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}'
--,'{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}');

--create or replace procedure sanctions.sp_fill_person
--	(in_general_id text,
--	in_associates text array,
--	in_associations text array,
--	in_birthDate text array,
--	in_birthPlace text array,
--	in_deathDate text array,
--	in_education text array,
--	in_ethnicity text array,
--	in_familyPerson text array,
--	in_familyRelative text array,
--	in_fatherName text array,
--	in_firstName text array,
--	in_gender text array,
--	in_lastName text array,
--	in_middleName text array,
--	in_motherName text array,
--	in_nationality text array,
--	in_passportNumber text array,
--	in_political text array,
--	in_position text array,
--	in_religion text array,
--	in_secondName text array,
--	in_title text array)
--language plpgsql as $$
--begin 
--	insert into sanctions.person 
--	(general_id,
--	associates,
--	associations,
--	birthDate,
--	birthPlace,
--	deathDate,
--	education,
--	ethnicity,
--	familyPerson,
--	familyRelative,
--	fatherName,
--	firstName,
--	gender,
--	lastName,
--	middleName,
--	motherName,
--	nationality,
--	passportNumber,
--	political,
--	position,
--	religion,
--	secondName,
--	title)
--	 values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23);
--end;
--$$;

--call sanctions.sp_fill_person('idsdfjefjejf','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}');
--call sanctions.sp_fill_person('idsdfjejf','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}','{data,sets}',
--'{data,sets}','{data,sets}','{data,sets}');



--test
--call sanctions.sp_fill_entities_with_json('
--{"caption": "Tehran, Pasdaran St., P.O. Box 16765, 1835",
-- "datasets": ["eu_fsf"],
-- "first_seen": "2021-09-27T09:09:30",
--"id": "addr-01759bf323bad9e43e45706563671441de5eade9",
-- "last_seen": "2022-01-20T01:33:01", 
--"properties": {"city": ["Tehran"], 
--	"country": ["ir"], 
--	"full": ["Tehran, Pasdaran St., P.O. Box 16765, 1835"],
--	 "postalCode": ["1835"], 
--	"street": ["Pasdaran St., P.O. Box 16765"]},
-- "referents": ["addr-01759bf323bad9e43e45706563671441de5eade9"],
-- "schema":
-- "Address", "target": false}
--');

--begin;
--create temporary table if not exists temp_json_entities (values json) on commit drop;
--copy temp_json2 from 'G:\database\veteranius\Entities.json';
--insert into sanctions.entities
--(select 
--values->>'caption',
--array[values->>'datasets'],
--values->>'first_seen',
--values->>'id',
--values->>'last_seen',
--values->>'referents',
--values->>'schema',
--values->>'target'
--from temp_json2 t);
--commit;





