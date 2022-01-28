create table sanctions.legalEntity_mainCountry
(legalEntity_id varchar,
mainCountry_country varchar,
primary key(legalEntity_id,mainCountry_country),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (mainCountry_country) references sanctions.country(code));