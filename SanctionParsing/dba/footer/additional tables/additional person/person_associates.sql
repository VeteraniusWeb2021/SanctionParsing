create table sanctions.person_associates
(person_id varchar,
associates varchar,
primary key(person_id,associates),
foreign key (person_id) references sanctions.person(general_id),
foreign key (associates) references sanctions.associate(general_id));