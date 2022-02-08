
INSERT INTO sanctions.legalEntity_agencyClient
(select e.general_id ,unnest (e.agencyclient) from sanctions.legalentity e); 

INSERT INTO sanctions.legalEntity_agentRepresentation
(select e.general_id ,unnest (e.agentRepresentation) from sanctions.legalentity e); 

INSERT INTO sanctions.legalEntity_cryptoWallets
(select e.general_id ,unnest (e.cryptoWallets) from sanctions.legalentity e); 

INSERT INTO sanctions.legalEntity_directorships
(select e.general_id ,unnest (e.directorshipDirector) from sanctions.legalentity e); 

INSERT INTO sanctions.legalEntity_identification
(select e.general_id ,unnest (e.identificiation) from sanctions.legalentity e);
