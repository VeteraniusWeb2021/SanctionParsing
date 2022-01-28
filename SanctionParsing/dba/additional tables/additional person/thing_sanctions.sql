create table sanctions.thing_sanction
(thing_id varchar,
sanction_id varchar,
primary key(thing_id,sanction_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (sanction_id) references sanctions.sanction(general_id));