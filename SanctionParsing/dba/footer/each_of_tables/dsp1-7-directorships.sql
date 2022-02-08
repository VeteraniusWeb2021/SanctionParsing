create table sanctions.directorships
(general_id text,
director text array,
organization text array,
secretary text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create table sanctions.interest
(general_id text,
role text array,
status text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create or replace procedure sanctions.sp_fill_directorships_with_json(in_json_directorships json)
language plpgsql as
$$
begin
	insert into sanctions.directorships
		(select * from json_to_record
	($1) as x
	(general_id text,
	director text array,
	organization text array,
	secretary text array));
end;
$$;

create or replace procedure sanctions.sp_fill_interest_with_json(in_json_interest json)
language plpgsql as
$$
begin
	insert into sanctions.interest
		(select * from json_to_record
	($1) as x
	(general_id text,
	role text array,
	status text array));
end;
$$;