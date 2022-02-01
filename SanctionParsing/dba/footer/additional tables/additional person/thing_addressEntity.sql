create table sanctions.thing_addressEntity
(thing_id varchar,
address_id varchar,
primary key(thing_id,address_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (address_id) references sanctions.address(general_id));
