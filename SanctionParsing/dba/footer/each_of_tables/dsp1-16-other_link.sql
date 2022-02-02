create table sanctions.other_link
(general_id text,
object text array,
subject text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);