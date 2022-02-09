--create database data_ocean_sanction_parsing;

create or replace procedure public.create_schema_sanctions()
language plpgsql
as $$
begin
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
target boolean,
unique(id_int),
primary key (id)
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
create table sanctions.legalentity
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
create table sanctions.address
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
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.interval
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
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.value
(general_id text,
amount text ,
amountEur text,
amountUsd text,
currency text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.asset
(general_id text,
ownershipAsset text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.vehicle
(general_id text,
buildDate text array,
model text array,
operator text array,
owner text array,
registrationDate text array,
registrationNumber text array,
type text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.airplane
(general_id text,
icaoCode text array,
manufacturer text array,
serialNumber text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.associate
(general_id text,
associate text array,
person text array,
relationship text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.company
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
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.organization
(general_id text,
directorshipOrganization text array,
membershipOrganization text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.crypto_wallet
(general_id text,
balance text array,
balanceDate text array,
creationDate text array,
currencySymbol text array,
holder text array,
mangingExchange text array,
privateKey text array,
publicKey text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.directorships
(general_id text,
director text array,
organization text array,
secretary text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.interest
(general_id text,
role text array,
status text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.family
(general_id text,
person text array,
relationship text array,
relative text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.identification
(general_id text,
authority text array,
country text array,
holder text array,
number text array,
type text array,
primary key(general_id),
foreign key(general_id) references sanctions.entities(id)
);
create table sanctions.membership
(general_id text,
member text array,
organization text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.ownership
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
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.passport
(general_id text,
birthDate text array,
birthPlace text array,
gender text array,
givenName text array,
passportNumber text array,
personalNumber text array,
surname text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.representation
(general_id text,
agent text array,
client text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.sanction
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
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.security
(general_id text,
classification text array,
collateral text array,
isin text array,
issueDate text array,
issuer text array,
ticker text array,
type text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.other_link
(general_id text,
object text array,
subject text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.vessel
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
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);
create table sanctions.publicBody
(general_id text,
directorshipOrganization text array,
membershipOrganization text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create table sanctions.country 
(code varchar,
label varchar,
primary key (code));

create table sanctions.topics 
(code varchar,
label varchar,
primary key (code));


create table sanctions.legalEntity_agencyClient
(legalEntity_id varchar,
agencyClient_representation_id varchar,
primary key(legalEntity_id,agencyClient_representation_id),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (agencyClient_representation_id) references sanctions.entities(id));

create table sanctions.legalEntity_agentRepresentation
(legalEntity_id varchar,
agentRepresentation_representation_id varchar,
primary key(legalEntity_id,agentRepresentation_representation_id),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (agentRepresentation_representation_id) references sanctions.entities(id));

create table sanctions.legalEntity_cryptoWallets
(legalEntity_id varchar,
crypto_wallet_id varchar,
primary key(legalEntity_id,crypto_wallet_id),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (crypto_wallet_id) references sanctions.entities(id));

create table sanctions.legalEntity_directorships
(legalEntity_id varchar,
directorships_id varchar,
primary key(legalEntity_id,directorships_id),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (directorships_id) references sanctions.entities(id));

create table sanctions.legalEntity_identification
(legalEntity_id varchar,
identification_id varchar,
primary key(legalEntity_id,identification_id),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (identification_id) references sanctions.entities(id));

create table sanctions.legalEntity_jurisdiction
(legalEntity_id varchar,
jurisdiction_country varchar,
primary key(legalEntity_id,jurisdiction_country),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (jurisdiction_country) references sanctions.country(code));

create table sanctions.legalEntity_mainCountry
(legalEntity_id varchar,
mainCountry_country varchar,
primary key(legalEntity_id,mainCountry_country),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (mainCountry_country) references sanctions.country(code));

create table sanctions.legalEntity_membershipMember
(legalEntity_id varchar,
membershipMember varchar,
primary key(legalEntity_id,membershipMember),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (membershipMember) references sanctions.entities(id));

create table sanctions.legalEntity_operatedVehicles
(legalEntity_id varchar,
operatedVehicles varchar,
primary key(legalEntity_id,operatedVehicles),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (operatedVehicles) references sanctions.entities(id));

create table sanctions.legalEntity_ownedVehicles
(legalEntity_id varchar,
ownedVehicles varchar,
primary key(legalEntity_id,ownedVehicles),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (ownedVehicles) references sanctions.entities(id));

create table sanctions.legalEntity_ownershipOwner
(legalEntity_id varchar,
ownershipOwner varchar,
primary key(legalEntity_id,ownershipOwner),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (ownershipOwner) references sanctions.entities(id));

create table sanctions.legalEntity_parent
(legalEntity_id varchar,
parent varchar,
primary key(legalEntity_id,parent),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (parent) references sanctions.entities(id));
create table sanctions.legalEntity_securities
(legalEntity_id varchar,
securities varchar,
primary key(legalEntity_id,securities),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (securities) references sanctions.entities(id));
create table sanctions.legalEntity_subsidiaries
(legalEntity_id varchar,
subsidiaries varchar,
primary key(legalEntity_id,subsidiaries),
foreign key (legalEntity_id) references sanctions.legalEntity(general_id),
foreign key (subsidiaries) references sanctions.entities(id));
create table sanctions.person_associates
(person_id varchar,
associates varchar,
primary key(person_id,associates),
foreign key (person_id) references sanctions.person(general_id),
foreign key (associates) references sanctions.entities(id));
create table sanctions.person_associations
(person_id varchar,
associations varchar,
primary key(person_id,associations),
foreign key (person_id) references sanctions.person(general_id),
foreign key (associations) references sanctions.entities(id));
create table sanctions.person_nationality_country
(person_id varchar,
nationality_country varchar,
primary key(person_id,nationality_country),
foreign key (person_id) references sanctions.person(general_id),
foreign key (nationality_country) references sanctions.country(code));
create table sanctions.person_familyPerson
(person_id varchar,
familyPerson varchar,
primary key(person_id,familyPerson),
foreign key (person_id) references sanctions.person(general_id),
foreign key (familyPerson) references sanctions.entities(id));
create table sanctions.person_familyRelative
(person_id varchar,
familyRelative varchar,
primary key(person_id,familyRelative),
foreign key (person_id) references sanctions.person(general_id),
foreign key (familyRelative) references sanctions.entities(id));
create table sanctions.thing_addressEntity
(thing_id varchar,
address_id varchar,
primary key(thing_id,address_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (address_id) references sanctions.entities(id));
create table sanctions.thing_sanction
(thing_id varchar,
sanction_id varchar,
primary key(thing_id,sanction_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (sanction_id) references sanctions.entities(id));
create table sanctions.thing_unknownLinkFrom
(thing_id varchar,
unknownLinkFrom_id varchar,
primary key(thing_id,unknownLinkFrom_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (unknownLinkFrom_id) references sanctions.entities(id));
create table sanctions.thing_unknownLinkTo
(thing_id varchar,
unknownLinkTo_id varchar,
primary key(thing_id,unknownLinkTo_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (unknownLinkTo_id) references sanctions.entities(id));
create table sanctions.thing_country
(thing_id varchar,
country_code varchar,
primary key(thing_id,country_code),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (country_code) references sanctions.country(code));
create table sanctions.address_country
(address_id varchar,
country_code varchar,
primary key(address_id,country_code),
foreign key (address_id) references sanctions.address(general_id),
foreign key (country_code) references sanctions.country(code));
create table sanctions.address_things
(address_id varchar,
things varchar,
primary key(address_id,things),
foreign key (address_id) references sanctions.address(general_id),
foreign key (things) references sanctions.entities(id));
create table sanctions.asset_ownershipAsset
(asset_id varchar,
ownershipAsset varchar,
primary key(asset_id,ownershipAsset),
foreign key (asset_id) references sanctions.asset(general_id),
foreign key (ownershipAsset) references sanctions.entities(id));
create table sanctions.vehicle_operator
(vehicle_id varchar,
operator varchar,
primary key(vehicle_id,operator),
foreign key (vehicle_id) references sanctions.vehicle(general_id),
foreign key (operator) references sanctions.entities(id));
create table sanctions.vehicle_owner
(vehicle_id varchar,
owner varchar,
primary key(vehicle_id,owner),
foreign key (vehicle_id) references sanctions.vehicle(general_id),
foreign key (owner) references sanctions.entities(id));
create table sanctions.associate_associate
(associate_id varchar,
associate varchar,
primary key(associate_id,associate),
foreign key (associate_id) references sanctions.associate(general_id),
foreign key (associate) references sanctions.entities(id));
create table sanctions.associate_person
(associate_id varchar,
person varchar,
primary key(associate_id,person),
foreign key (associate_id) references sanctions.associate(general_id),
foreign key (person) references sanctions.entities(id));
create table sanctions.organization_directorshipOrganization
(organization_id varchar,
directorshipOrganization varchar,
primary key(organization_id,directorshipOrganization),
foreign key (organization_id) references sanctions.organization(general_id),
foreign key (directorshipOrganization) references sanctions.entities(id));
create table sanctions.organization_membershipOrganization
(organization_id varchar,
membershipOrganization varchar,
primary key(organization_id,membershipOrganization),
foreign key (organization_id) references sanctions.organization(general_id),
foreign key (membershipOrganization) references sanctions.entities(id));
create table sanctions.crypto_wallet_holder
(crypto_wallet_id varchar,
holder varchar,
primary key(crypto_wallet_id,holder),
foreign key (crypto_wallet_id) references sanctions.crypto_wallet(general_id),
foreign key (holder) references sanctions.entities(id));
create table sanctions.directorships_director
(directorships_id varchar,
director varchar,
primary key(directorships_id,director),
foreign key (directorships_id) references sanctions.directorships(general_id),
foreign key (director) references sanctions.entities(id));
create table sanctions.directorships_organization
(directorships_id varchar,
organization varchar,
primary key(directorships_id,organization),
foreign key (directorships_id) references sanctions.directorships(general_id),
foreign key (organization) references sanctions.entities(id));
create table sanctions.family_person
(family_id varchar,
person varchar,
primary key(family_id,person),
foreign key (family_id) references sanctions.family(general_id),
foreign key (person) references sanctions.entities(id));
create table sanctions.family_relative
(family_id varchar,
relative varchar,
primary key(family_id,relative),
foreign key (family_id) references sanctions.family(general_id),
foreign key (relative) references sanctions.entities(id));
create table sanctions.identification_holder
(identification_id varchar,
holder varchar,
primary key(identification_id,holder),
foreign key (identification_id) references sanctions.identification(general_id),
foreign key (holder) references sanctions.entities(id));
create table sanctions.identification_country
(identification_id varchar,
country_code varchar,
primary key(identification_id,country_code),
foreign key (identification_id) references sanctions.identification(general_id),
foreign key (country_code) references sanctions.country(code));
create table sanctions.membership_member
(membership_id varchar,
member varchar,
primary key(membership_id,member),
foreign key (membership_id) references sanctions.membership(general_id),
foreign key (member) references sanctions.entities(id));
create table sanctions.membership_organization
(membership_id varchar,
organization varchar,
primary key(membership_id,organization),
foreign key (membership_id) references sanctions.membership(general_id),
foreign key (organization) references sanctions.entities(id));
create table sanctions.ownership_asset
(ownership_id varchar,
asset varchar,
primary key(ownership_id,asset),
foreign key (ownership_id) references sanctions.ownership(general_id),
foreign key (asset) references sanctions.entities(id));
create table sanctions.ownership_owner
(ownership_id varchar,
owner varchar,
primary key(ownership_id,owner),
foreign key (ownership_id) references sanctions.ownership(general_id),
foreign key (owner) references sanctions.entities(id));
create table sanctions.publicBody_directorshipOrganization
(publicBody_id varchar,
directorshipOrganization varchar,
primary key(publicBody_id,directorshipOrganization),
foreign key (publicBody_id) references sanctions.publicBody(general_id),
foreign key (directorshipOrganization) references sanctions.entities(id));
create table sanctions.publicBody_membershipOrganization
(publicBody_id varchar,
membershipOrganization varchar,
primary key(publicBody_id,membershipOrganization),
foreign key (publicBody_id) references sanctions.publicBody(general_id),
foreign key (membershipOrganization) references sanctions.entities(id));
create table sanctions.representation_agent
(representation_id varchar,
agent varchar,
primary key(representation_id,agent),
foreign key (representation_id) references sanctions.representation(general_id),
foreign key (agent) references sanctions.entities(id));
create table sanctions.representation_client
(representation_id varchar,
client varchar,
primary key(representation_id,client),
foreign key (representation_id) references sanctions.representation(general_id),
foreign key (client) references sanctions.entities(id));
create table sanctions.sanction_entity
(sanction_id varchar,
entity varchar,
primary key(sanction_id,entity),
foreign key (sanction_id) references sanctions.sanction(general_id),
foreign key (entity) references sanctions.entities(id));
create table sanctions.sanction_country
(sanction_id varchar,
country_code varchar,
primary key(sanction_id,country_code),
foreign key (sanction_id) references sanctions.sanction(general_id),
foreign key (country_code) references sanctions.country(code));
create table sanctions.security_issuer
(security_id varchar,
issuer varchar,
primary key(security_id,issuer),
foreign key (security_id) references sanctions.security(general_id),
foreign key (issuer) references sanctions.entities(id));
create table sanctions.other_link_object
(other_link_id varchar,
object varchar,
primary key(other_link_id,object),
foreign key (other_link_id) references sanctions.other_link(general_id),
foreign key (object) references sanctions.entities(id));
create table sanctions.other_link_subject
(other_link_id varchar,
subject varchar,
primary key(other_link_id,subject),
foreign key (other_link_id) references sanctions.other_link(general_id),
foreign key (subject) references sanctions.entities(id));
create table sanctions.vessel_flag_country
(vessel_id varchar,
flag varchar,
primary key(vessel_id,flag),
foreign key (vessel_id) references sanctions.vessel(general_id),
foreign key (flag) references sanctions.country(code));

create table sanctions.thing_topics
(thing_id varchar,
topics varchar,
primary key(thing_id,topics),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (topics) references sanctions.topics(code));
end;
$$;
call public.create_schema_sanctions();