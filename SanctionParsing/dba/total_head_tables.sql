--create database data_ocean_sanction_parsing;

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
) ;

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

create table sanctions.country 
(code varchar,
label varchar,
primary key (code));

create table sanctions.topics 
(code varchar,
label varchar,
primary key (code));
