create table sanctions.legalEntity_membershipMember
(legalEntity_id varchar,
membershipMember varchar,
primary key(legalEntity_id,membershipMember),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (membershipMember) references sanctions.membership(general_id));