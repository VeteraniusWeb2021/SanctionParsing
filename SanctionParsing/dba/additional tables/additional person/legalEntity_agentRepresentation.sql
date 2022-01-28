create table sanctions.legalEntity_agentRepresentation
(legalEntity_id varchar,
agentRepresentation_representation_id varchar,
primary key(legalEntity_id,agentRepresentation_representation_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (agentRepresentation_representation_id) references sanctions.representation(general_id));