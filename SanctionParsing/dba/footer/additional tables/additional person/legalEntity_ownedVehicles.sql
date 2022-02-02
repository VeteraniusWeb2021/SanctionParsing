create table sanctions.legalEntity_ownedVehicles
(legalEntity_id varchar,
ownedVehicles varchar,
primary key(legalEntity_id,ownedVehicles),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (ownedVehicles) references sanctions.vehicle(general_id));