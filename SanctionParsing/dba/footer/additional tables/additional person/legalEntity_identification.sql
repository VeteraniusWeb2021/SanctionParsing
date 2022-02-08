create table sanctions.legalEntity_identification
(legalEntity_id varchar,
identification_id varchar,
primary key(legalEntity_id,identification_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (identification_id) references sanctions.identification(general_id));