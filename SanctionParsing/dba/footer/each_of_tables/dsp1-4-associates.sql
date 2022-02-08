create table sanctions.associate
(general_id text,
associate text array,
person text array,
relationship text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create or replace procedure sanctions.sp_fill_associate_with_json(in_json_associate json)
language plpgsql as
$$
begin
	insert into sanctions.associate
		(select * from json_to_record
	($1) as x
	(general_id text,
	associate text array,
	person text array,
	relationship text array));
end;
$$;
