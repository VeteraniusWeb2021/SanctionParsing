create table sanctions.person_familyPerson
(person_id varchar,
familyPerson varchar,
primary key(person_id,familyPerson),
foreign key (person_id) references sanctions.person(general_id),
foreign key (familyPerson) references sanctions.family(general_id));