create table sanctions.legalEntity_parent
(legalEntity_id varchar,
parent varchar,
primary key(legalEntity_id,parent),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (parent) references sanctions.legal_entity(general_id));