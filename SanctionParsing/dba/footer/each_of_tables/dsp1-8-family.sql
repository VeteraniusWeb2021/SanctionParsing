create table sanctions.family
(general_id text,
person text array,
relationship text array,
relative text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create or replace procedure sanctions.sp_fill_family_with_json(in_json_family json)
language plpgsql as
$$
begin
	insert into sanctions.family
		(select * from json_to_record
	($1) as x
	(general_id text,
	person text array,
	relationship text array,
	relative text array));
end;
$$;