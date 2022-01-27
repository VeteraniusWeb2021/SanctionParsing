create table sanctions.person_familyRelative
(person_id varchar,
familyRelative varchar,
primary key(person_id,familyRelative),
foreign key (person_id) references sanctions.person(general_id),
foreign key (familyRelative) references sanctions.family(general_id));