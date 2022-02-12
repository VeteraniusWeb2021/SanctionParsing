
create or replace function sanctions.fn_one_fill_add_tables()
returns void as
$$

INSERT INTO sanctions.legalEntity_agencyClient
(select e.general_id ,unnest (e.agencyclient) from sanctions.legalentity e)on conflict do nothing;

INSERT INTO sanctions.legalEntity_agentRepresentation
(select e.general_id ,unnest (e.agentRepresentation) from sanctions.legalentity e)on conflict do nothing;

INSERT INTO sanctions.legalEntity_cryptoWallets
(select e.general_id ,unnest (e.cryptoWallets) from sanctions.legalentity e)on conflict do nothing;

INSERT INTO sanctions.legalEntity_directorships
(select e.general_id ,unnest (e.directorshipDirector) from sanctions.legalentity e)on conflict do nothing;

INSERT INTO sanctions.legalEntity_identification (
	select g_id, ident from (
		select 
			e.general_id as g_id,
			unnest (e.identificiation) as ident
		from sanctions.legalentity e
	) e2
	where ident in (select ee.id from sanctions.entities ee)
) on conflict do nothing;

INSERT INTO sanctions.legalEntity_jurisdiction
(select e.general_id ,unnest (e.jurisdiction) from sanctions.legalentity e) on conflict do nothing;

INSERT INTO sanctions.legalEntity_mainCountry
(select e.general_id ,unnest (e.mainCountry) from sanctions.legalentity e) on conflict do nothing;


INSERT INTO sanctions.legalEntity_membershipMember
(select e.general_id ,unnest (e.membershipMember) from sanctions.legalentity e) on conflict do nothing;

INSERT INTO sanctions.legalEntity_operatedVehicles
(select e.general_id ,unnest (e.operatedVehicles) from sanctions.legalentity e) on conflict do nothing;

INSERT INTO sanctions.legalEntity_ownedVehicles
(select e.general_id ,unnest (e.ownedVehicles) from sanctions.legalentity e) on conflict do nothing;

INSERT INTO sanctions.legalEntity_ownershipOwner
(select e.general_id ,unnest (e.ownershipOwner) from sanctions.legalentity e) on conflict do nothing;

INSERT INTO sanctions.legalEntity_parent
(select e.general_id ,unnest (e.parent) from sanctions.legalentity e) on conflict do nothing;

INSERT INTO sanctions.legalEntity_securities
(select e.general_id ,unnest (e.securities) from sanctions.legalentity e) on conflict do nothing;

INSERT INTO sanctions.legalEntity_subsidiaries
(select e.general_id ,unnest (e.subsidiaries) from sanctions.legalentity e) on conflict do nothing;

INSERT INTO sanctions.person_associates
(select e.general_id ,unnest (e.associates) from sanctions.person e) on conflict do nothing;

INSERT INTO sanctions.person_associations
(select e.general_id ,unnest (e.associations) from sanctions.person e) on conflict do nothing;

INSERT INTO sanctions.person_nationality_country
(select e.general_id ,unnest (e.nationality) from sanctions.person e) on conflict do nothing;

INSERT INTO sanctions.person_familyPerson
(select e.general_id ,unnest (e.familyPerson) from sanctions.person e) on conflict do nothing;

INSERT INTO sanctions.person_familyRelative
(select e.general_id ,unnest (e.familyRelative) from sanctions.person e) on conflict do nothing;

INSERT INTO sanctions.thing_addressEntity
(select e.general_id ,unnest (e.addressEntity) from sanctions.thing e) on conflict do nothing;

INSERT INTO sanctions.thing_sanction
(select e.general_id ,unnest (e.sanctions) from sanctions.thing e) on conflict do nothing;

INSERT INTO sanctions.thing_unknownLinkFrom
(select e.general_id ,unnest (e.unknownLinkFrom) from sanctions.thing e) on conflict do nothing;

INSERT INTO sanctions.thing_unknownLinkTo
(select e.general_id ,unnest (e.unknownLinkTo) from sanctions.thing e) on conflict do nothing;

INSERT INTO sanctions.thing_country
(select e.general_id ,unnest (e.country) from sanctions.thing e) on conflict do nothing;

INSERT INTO sanctions.address_country
(select e.general_id ,unnest (e.country) from sanctions.address e) on conflict do nothing;

INSERT INTO sanctions.address_things
(select e.general_id ,unnest (e.things) from sanctions.address e) on conflict do nothing;

INSERT INTO sanctions.asset_ownershipAsset
(select e.general_id ,unnest (e.ownershipAsset) from sanctions.asset e) on conflict do nothing;


INSERT INTO sanctions.vehicle_operator
(select e.general_id ,unnest (e.operator) from sanctions.vehicle e) on conflict do nothing;

INSERT INTO sanctions.vehicle_owner
(select e.general_id ,unnest (e.owner) from sanctions.vehicle e) on conflict do nothing;

INSERT INTO sanctions.associate_associate
(select e.general_id ,unnest (e.associate) from sanctions.associate e) on conflict do nothing;

INSERT INTO sanctions.associate_person
(select e.general_id ,unnest (e.person) from sanctions.associate e) on conflict do nothing;

INSERT INTO sanctions.organization_directorshipOrganization
(select e.general_id ,unnest (e.directorshipOrganization) from sanctions.organization e) on conflict do nothing;

INSERT INTO sanctions.organization_membershipOrganization
(select e.general_id ,unnest (e.membershipOrganization) from sanctions.organization e) on conflict do nothing;

INSERT INTO sanctions.crypto_wallet_holder
(select e.general_id ,unnest (e.holder) from sanctions.crypto_wallet e) on conflict do nothing;

INSERT INTO sanctions.directorships_director
(select e.general_id ,unnest (e.director) from sanctions.directorships e) on conflict do nothing;

INSERT INTO sanctions.directorships_organization
(select e.general_id ,unnest (e.organization) from sanctions.directorships e) on conflict do nothing;

INSERT INTO sanctions.family_person
(select e.general_id ,unnest (e.person) from sanctions.family e) on conflict do nothing;

INSERT INTO sanctions.family_relative
(select e.general_id ,unnest (e.relative) from sanctions.family e) on conflict do nothing;

INSERT INTO sanctions.identification_holder
(select e.general_id ,unnest (e.holder) from sanctions.identification e) on conflict do nothing;

INSERT INTO sanctions.identification_country
(select e.general_id ,unnest (e.country) from sanctions.identification e) on conflict do nothing;

INSERT INTO sanctions.membership_member
(select e.general_id ,unnest (e.member) from sanctions.membership e) on conflict do nothing;

INSERT INTO sanctions.membership_organization
(select e.general_id ,unnest (e.organization) from sanctions.membership e) on conflict do nothing;

INSERT INTO sanctions.ownership_asset
(select e.general_id ,unnest (e.asset) from sanctions.ownership e) on conflict do nothing;

INSERT INTO sanctions.ownership_owner
(select e.general_id ,unnest (e.owner) from sanctions.ownership e) on conflict do nothing;

INSERT INTO sanctions.publicBody_directorshipOrganization
(select e.general_id ,unnest (e.directorshipOrganization) from sanctions.publicBody e) on conflict do nothing;

INSERT INTO sanctions.publicBody_membershipOrganization
(select e.general_id ,unnest (e.membershipOrganization) from sanctions.publicBody e) on conflict do nothing;

INSERT INTO sanctions.representation_agent
(select e.general_id ,unnest (e.agent) from sanctions.representation e) on conflict do nothing;

INSERT INTO sanctions.representation_client
(select e.general_id ,unnest (e.client) from sanctions.representation e) on conflict do nothing;

INSERT INTO sanctions.sanction_entity
(select e.general_id ,unnest (e.entity) from sanctions.sanction e) on conflict do nothing;

INSERT INTO sanctions.sanction_country
(select e.general_id ,unnest (e.country) from sanctions.sanction e) on conflict do nothing;

INSERT INTO sanctions.security_issuer
(select e.general_id ,unnest (e.issuer) from sanctions.security e) on conflict do nothing;

INSERT INTO sanctions.other_link_object
(select e.general_id ,unnest (e.object) from sanctions.other_link e) on conflict do nothing;

INSERT INTO sanctions.other_link_subject
(select e.general_id ,unnest (e.subject) from sanctions.other_link e) on conflict do nothing;

INSERT INTO sanctions.vessel_flag_country
(select e.general_id ,unnest (e.flag) from sanctions.vessel e) on conflict do nothing;

INSERT INTO sanctions.thing_topics
(select e.general_id ,unnest (e.topics) from sanctions.thing e) on conflict do nothing;

$$ language sql;





















