
INSERT INTO sanctions.legalEntity_agencyClient
(select e.general_id ,unnest (e.agencyclient) from sanctions.legalentity e); 

