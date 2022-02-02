create table sanctions.address
(general_id text,
city text array,
country text array,
full text array,
latitude text array,
longitude text array,
postOfficeBox text array,
postalCode text array,
region text array,
remarks text array,
state text array,
street text array,
street2 text array,
things text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create table sanctions.interval
(general_id text,
date text array,
description text array,
endDate text array,
modifiedAt text array,
publisher text array,
publisherUrl text array,
recordId text array,
retrievedAt text array,
sourceUrl text array,
startDate text array,
summary text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create or replace procedure sanctions.sp_fill_address_with_json(in_json_address json)
language plpgsql as
$$
begin
	insert into sanctions.address 
		(select * from json_to_record
	($1) as x
	(general_id text,
	city text array,
	country text array,
	full text array,
	latitude text array,
	longitude text array,
	postOfficeBox text array,
	postalCode text array,
	region text array,
	remarks text array,
	state text array,
	street text array,
	street2 text array,
	things text array));
end;
$$;

create or replace procedure sanctions.sp_fill_interval_with_json(in_json_interval json)
language plpgsql as
$$
begin
	insert into sanctions.interval 
		(select * from json_to_record
	($1) as x
	(general_id text,
	date text array,
	description text array,
	endDate text array,
	modifiedAt text array,
	publisher text array,
	publisherUrl text array,
	recordId text array,
	retrievedAt text array,
	sourceUrl text array,
	startDate text array,
	summary text array));
end;
$$;
