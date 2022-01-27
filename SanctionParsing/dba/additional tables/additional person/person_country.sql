create table sanctions.person_country
(person_id varchar,
country_code varchar,
primary key(person_id,country_code),
foreign key (person_id) references sanctions.person(general_id),
foreign key (country_code) references sanctions.country(code));