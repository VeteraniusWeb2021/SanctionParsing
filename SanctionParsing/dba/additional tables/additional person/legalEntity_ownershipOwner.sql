create table sanctions.legalEntity_ownershipOwner
(legalEntity_id varchar,
ownershipOwner varchar,
primary key(legalEntity_id,ownershipOwner),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (ownershipOwner) references sanctions.ownership(general_id));