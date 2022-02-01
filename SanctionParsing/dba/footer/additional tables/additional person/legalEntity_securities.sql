create table sanctions.legalEntity_securities
(legalEntity_id varchar,
securities varchar,
primary key(legalEntity_id,securities),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (securities) references sanctions.security(general_id));