create table sanctions.legalEntity_directorships
(legalEntity_id varchar,
directorships_id varchar,
primary key(legalEntity_id,directorships_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (directorships_id) references sanctions.directorships(general_id));