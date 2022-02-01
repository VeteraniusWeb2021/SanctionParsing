create table sanctions.person_associations
(person_id varchar,
associations varchar,
primary key(person_id,associations),
foreign key (person_id) references sanctions.person(general_id),
foreign key (associations) references sanctions.associate(general_id));