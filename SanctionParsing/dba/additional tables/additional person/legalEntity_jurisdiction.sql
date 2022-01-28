create table sanctions.legalEntity_jurisdiction
(legalEntity_id varchar,
jurisdiction_country varchar,
primary key(legalEntity_id,jurisdiction_country),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (jurisdiction_country) references sanctions.country(code));