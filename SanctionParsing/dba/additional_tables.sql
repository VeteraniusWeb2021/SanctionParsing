create table sanctions.legalEntity_agencyClient
(legalEntity_id varchar,
agencyClient_representation_id varchar,
primary key(legalEntity_id,agencyClient_representation_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (agencyClient_representation_id) references sanctions.representation(general_id));

create table sanctions.legalEntity_agentRepresentation
(legalEntity_id varchar,
agentRepresentation_representation_id varchar,
primary key(legalEntity_id,agentRepresentation_representation_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (agentRepresentation_representation_id) references sanctions.representation(general_id));

create table sanctions.legalEntity_cryptoWallets
(legalEntity_id varchar,
crypto_wallet_id varchar,
primary key(legalEntity_id,crypto_wallet_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (crypto_wallet_id) references sanctions.crypto_wallet(general_id));

create table sanctions.legalEntity_directorships
(legalEntity_id varchar,
directorships_id varchar,
primary key(legalEntity_id,directorships_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (directorships_id) references sanctions.directorships(general_id));

create table sanctions.legalEntity_identification
(legalEntity_id varchar,
identification_id varchar,
primary key(legalEntity_id,identification_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (identification_id) references sanctions.identification(general_id));

create table sanctions.legalEntity_jurisdiction
(legalEntity_id varchar,
jurisdiction_country varchar,
primary key(legalEntity_id,jurisdiction_country),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (jurisdiction_country) references sanctions.country(code));

create table sanctions.legalEntity_mainCountry
(legalEntity_id varchar,
mainCountry_country varchar,
primary key(legalEntity_id,mainCountry_country),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (mainCountry_country) references sanctions.country(code));

create table sanctions.legalEntity_membershipMember
(legalEntity_id varchar,
membershipMember varchar,
primary key(legalEntity_id,membershipMember),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (membershipMember) references sanctions.membership(general_id));

create table sanctions.legalEntity_operatedVehicles
(legalEntity_id varchar,
operatedVehicles varchar,
primary key(legalEntity_id,operatedVehicles),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (operatedVehicles) references sanctions.vehicle(general_id));

create table sanctions.legalEntity_ownedVehicles
(legalEntity_id varchar,
ownedVehicles varchar,
primary key(legalEntity_id,ownedVehicles),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (ownedVehicles) references sanctions.vehicle(general_id));

create table sanctions.legalEntity_ownershipOwner
(legalEntity_id varchar,
ownershipOwner varchar,
primary key(legalEntity_id,ownershipOwner),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (ownershipOwner) references sanctions.ownership(general_id));

create table sanctions.legalEntity_parent
(legalEntity_id varchar,
parent varchar,
primary key(legalEntity_id,parent),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (parent) references sanctions.legal_entity(general_id));

create table sanctions.legalEntity_securities
(legalEntity_id varchar,
securities varchar,
primary key(legalEntity_id,securities),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (securities) references sanctions.security(general_id));

create table sanctions.legalEntity_subsidiaries
(legalEntity_id varchar,
subsidiaries varchar,
primary key(legalEntity_id,subsidiaries),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (subsidiaries) references sanctions.legal_entity(general_id));

create table sanctions.person_associates
(person_id varchar,
associates varchar,
primary key(person_id,associates),
foreign key (person_id) references sanctions.person(general_id),
foreign key (associates) references sanctions.associate(general_id));

create table sanctions.person_associations
(person_id varchar,
associations varchar,
primary key(person_id,associations),
foreign key (person_id) references sanctions.person(general_id),
foreign key (associations) references sanctions.associate(general_id));

create table sanctions.person_country
(person_id varchar,
country_code varchar,
primary key(person_id,country_code),
foreign key (person_id) references sanctions.person(general_id),
foreign key (country_code) references sanctions.country(code));

create table sanctions.person_familyPerson
(person_id varchar,
familyPerson varchar,
primary key(person_id,familyPerson),
foreign key (person_id) references sanctions.person(general_id),
foreign key (familyPerson) references sanctions.family(general_id));

create table sanctions.person_familyRelative
(person_id varchar,
familyRelative varchar,
primary key(person_id,familyRelative),
foreign key (person_id) references sanctions.person(general_id),
foreign key (familyRelative) references sanctions.family(general_id));

create table sanctions.thing_addressEntity
(thing_id varchar,
address_id varchar,
primary key(thing_id,address_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (address_id) references sanctions.address(general_id));

create table sanctions.thing_sanction
(thing_id varchar,
sanction_id varchar,
primary key(thing_id,sanction_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (sanction_id) references sanctions.sanction(general_id));

create table sanctions.thing_unknownLinkFrom
(thing_id varchar,
unknownLinkFrom_id varchar,
primary key(thing_id,unknownLinkFrom_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (unknownLinkFrom_id) references sanctions.other_link(general_id));

create table sanctions.thing_unknownLinkTo
(thing_id varchar,
unknownLinkTo_id varchar,
primary key(thing_id,unknownLinkTo_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (unknownLinkTo_id) references sanctions.other_link(general_id));

