create table sanctions.legalEntity_agencyClient
(legalEntity_id varchar,
agencyClient_representation_id varchar,
primary key(legalEntity_id,agencyClient_representation_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (agencyClient_representation_id) references sanctions.representation(general_id));