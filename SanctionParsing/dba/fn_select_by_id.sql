create or replace function sanctions.fn_select_by_id(id_person text)
returns table (
caption text,
datasets text array,
first_seen text,
id text,
last_seen text,
referents text array,
schema text,
target boolean,
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
"position" text array,
religion text array,
secondName text array,
title text array) as
$$
begin
	return query
	select 
	e.caption ,
	e.datasets,
	e.first_seen ,
	e.id ,
	e.last_seen ,
	e.referents,
	e.schema ,
	e.target ,
	t.address,
	t.addressEntity,
	t.alias,
	t.country,
	t.description,
	t.keywords,
	t.modifiedAt,
	t.name,
	t.notes,
	t.previousName,
	t.program,
	t.publisher,
	t.publisherUrl,
	t.retrievedAt,
	t.sanctions,
	t.sourceUrl,
	t.summary,
	t.topics,
	t.unknownLinkFrom,
	t.unknownLinkTo,
	t.weakAlias,
	t.wikidataId,
	t.wikipediaUrl,
	l.agencyClient,
	l.agentRepresentation,
	l.bvdId,
	l.classification,
	l.cryptoWallets,
	l.directorshipDirector,
	l.dissolutionDate,
	l.dunsCode,
	l.email,
	l.icijId,
	l.idNumber,
	l.identificiation,
	l.incorporationDate,
	l.innCode,
	l.jurisdiction,
	l.legalForm,
	l.mainCountry,
	l.membershipMember,
	l.okpoCode,
	l.opencorporatesUrl,
	l.operatedVehicles,
	l.ownedVehicles,
	l.ownershipOwner,
	l.parent,
	l.phone,
	l.registrationNumber,
	l.sector,
	l.securities,
	l.status,
	l.subsidiaries,
	l.swiftBic,
	l.taxNumber,
	l.taxStatus,
	l.vatCode,
	l.website,
	p.associates,
	p.associations,
	p.birthDate,
	p.birthPlace,
	p.deathDate,
	p.education,
	p.ethnicity,
	p.familyPerson,
	p.familyRelative,
	p.fatherName,
	p.firstName,
	p.gender,
	p.lastName,
	p.middleName,
	p.motherName,
	p.nationality,
	p.passportNumber,
	p.political,
	p.position,
	p.religion,
	p.secondName,
	p.title
	from sanctions.entities e 
	join sanctions.thing t on t.general_id = e.id 
	join sanctions.legalentity l on l.general_id = e.id 
	join sanctions.person p on p.general_id = e.id 
where e.id = $1;
end;
$$language plpgsql;

select * from sanctions.fn_select_by_id('NK-22HtK7WrxZ2sU3rmhz6PuZ');