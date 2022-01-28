create table sanctions.legalEntity_operatedVehicles
(legalEntity_id varchar,
operatedVehicles varchar,
primary key(legalEntity_id,operatedVehicles),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (operatedVehicles) references sanctions.vehicle(general_id));