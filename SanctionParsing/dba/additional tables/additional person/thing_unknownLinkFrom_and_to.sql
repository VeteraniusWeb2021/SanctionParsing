create table sanctions.thing_unknownLinkFrom
(thing_id varchar,
unknownLinkFrom_id varchar,
primary key(thing_id,unknownLinkFrom_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (unknownLinkFrom_id) references sanctions.other_link(general_id));

create table sanctions.thing_unknownLinkTo
(thing_id varchar,
unknownLinkTo_id varchar,
primary key(thing_id,unknownLinkTo_id),
foreign key (thing_id) references sanctions.thing(general_id),
foreign key (unknownLinkTo_id) references sanctions.other_link(general_id));
