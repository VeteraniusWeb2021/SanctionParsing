--////////////////person/////////////////////////////

create table sanctions.entities_referents
(entities varchar,
referents varchar,
primary key(entities,referents),
foreign key (entities) references sanctions.entities(id),
foreign key (referents) references sanctions.entities(id));


create table sanctions.legalEntity_agencyClient
(legalEntity_id varchar,
agencyClient_representation_id varchar,
primary key(legalEntity_id,agencyClient_representation_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (agencyClient_representation_id) references sanctions.entities(id));

create table sanctions.legalEntity_agentRepresentation
(legalEntity_id varchar,
agentRepresentation_representation_id varchar,
primary key(legalEntity_id,agentRepresentation_representation_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (agentRepresentation_representation_id) references sanctions.entities(id));

create table sanctions.legalEntity_cryptoWallets
(legalEntity_id varchar,
crypto_wallet_id varchar,
primary key(legalEntity_id,crypto_wallet_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (crypto_wallet_id) references sanctions.entities(id));

create table sanctions.legalEntity_directorships
(legalEntity_id varchar,
directorships_id varchar,
primary key(legalEntity_id,directorships_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (directorships_id) references sanctions.entities(id));

create table sanctions.legalEntity_identification
(legalEntity_id varchar,
identification_id varchar,
primary key(legalEntity_id,identification_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (identification_id) references sanctions.entities(id));

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

create table sanctions.legalEntity_jurisdiction
(legalEntity_id varchar,
jurisdiction_country varchar,
primary key(legalEntity_id,jurisdiction_country),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (jurisdiction_country) references sanctions.country(code));

create table sanctions.legalEntity_membershipMember
(legalEntity_id varchar,
membershipMember varchar,
primary key(legalEntity_id,membershipMember),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (membershipMember) references sanctions.entities(id));

create table sanctions.legalEntity_operatedVehicles
(legalEntity_id varchar,
operatedVehicles varchar,
primary key(legalEntity_id,operatedVehicles),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (operatedVehicles) references sanctions.entities(id));

create table sanctions.legalEntity_ownedVehicles
(legalEntity_id varchar,
ownedVehicles varchar,
primary key(legalEntity_id,ownedVehicles),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (ownedVehicles) references sanctions.entities(id));

create table sanctions.legalEntity_ownershipOwner
(legalEntity_id varchar,
ownershipOwner varchar,
primary key(legalEntity_id,ownershipOwner),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (ownershipOwner) references sanctions.entities(id));

create table sanctions.legalEntity_parent
(legalEntity_id varchar,
parent varchar,
primary key(legalEntity_id,parent),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (parent) references sanctions.entities(id));

create table sanctions.legalEntity_securities
(legalEntity_id varchar,
securities varchar,
primary key(legalEntity_id,securities),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (securities) references sanctions.entities(id));

create table sanctions.legalEntity_subsidiaries
(legalEntity_id varchar,
subsidiaries varchar,
primary key(legalEntity_id,subsidiaries),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
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

--////////////////address/////////////////////////////

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

--////////////////airplane/////////////////////////////

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

--////////////////associate/////////////////////////////

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

--////////////////company/////////////////////////////

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

--////////////////cryptocurrency wallets/////////////////////////////

create table sanctions.crypto_wallet_holder
(crypto_wallet_id varchar,
holder varchar,
primary key(crypto_wallet_id,holder),
foreign key (crypto_wallet_id) references sanctions.crypto_wallet(general_id),
foreign key (holder) references sanctions.entities(id));

--////////////////directorships/////////////////////////////

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

--////////////////family/////////////////////////////

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

--////////////////identification/////////////////////////////

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

--////////////////membership/////////////////////////////

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

--////////////////ownership/////////////////////////////


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

--////////////////passport/////////////////////////////

create table sanctions.identification_country
(identification_id varchar,
country_code varchar,
primary key(identification_id,country_code),
foreign key (identification_id) references sanctions.identification(general_id),
foreign key (country_code) references sanctions.country(code));


create table sanctions.identification_holder
(identification_id varchar,
holder varchar,
primary key(identification_id,holder),
foreign key (identification_id) references sanctions.identification(general_id),
foreign key (holder) references sanctions.entities(id));

--////////////////publicBody/////////////////////////////

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

--////////////////representation/////////////////////////////


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

--////////////////sanction/////////////////////////////

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

--////////////////security/////////////////////////////

create table sanctions.security_issuer
(security_id varchar,
issuer varchar,
primary key(security_id,issuer),
foreign key (security_id) references sanctions.security(general_id),
foreign key (issuer) references sanctions.entities(id));

--////////////////other_link/////////////////////////////

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

--////////////////vessel/////////////////////////////

create table sanctions.vessel_flag_country
(vessel_id varchar,
flag varchar,
primary key(vessel_id,flag),
foreign key (vessel_id) references sanctions.vessel(general_id),
foreign key (flag) references sanctions.country(code));