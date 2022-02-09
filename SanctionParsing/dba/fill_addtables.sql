
INSERT INTO sanctions.legalEntity_agencyClient
(select e.general_id ,unnest (e.agencyclient) from sanctions.legalentity e); 

INSERT INTO sanctions.legalEntity_agentRepresentation
(select e.general_id ,unnest (e.agentRepresentation) from sanctions.legalentity e); 

INSERT INTO sanctions.legalEntity_cryptoWallets
(select e.general_id ,unnest (e.cryptoWallets) from sanctions.legalentity e); 

INSERT INTO sanctions.legalEntity_directorships
(select e.general_id ,unnest (e.directorshipDirector) from sanctions.legalentity e); 

--INSERT INTO sanctions.legalEntity_identification
--(select e.general_id ,unnest (e.identificiation) from sanctions.legalentity e);

INSERT INTO sanctions.legalEntity_jurisdiction
(select e.general_id ,unnest (e.jurisdiction) from sanctions.legalentity e);

INSERT INTO sanctions.legalEntity_mainCountry
(select e.general_id ,unnest (e.mainCountry) from sanctions.legalentity e);


INSERT INTO sanctions.legalEntity_membershipMember
(select e.general_id ,unnest (e.membershipMember) from sanctions.legalentity e);

INSERT INTO sanctions.legalEntity_operatedVehicles
(select e.general_id ,unnest (e.operatedVehicles) from sanctions.legalentity e);

INSERT INTO sanctions.legalEntity_ownedVehicles
(select e.general_id ,unnest (e.ownedVehicles) from sanctions.legalentity e);

INSERT INTO sanctions.legalEntity_ownershipOwner
(select e.general_id ,unnest (e.ownershipOwner) from sanctions.legalentity e);


