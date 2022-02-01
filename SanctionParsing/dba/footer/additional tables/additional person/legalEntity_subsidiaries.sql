create table sanctions.legalEntity_subsidiaries
(legalEntity_id varchar,
subsidiaries varchar,
primary key(legalEntity_id,subsidiaries),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (subsidiaries) references sanctions.legal_entity(general_id));