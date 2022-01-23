create table sanctions.value
(general_id text,
amount money ,
amountEur money,
amountUsd money,
currency text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create table sanctions.asset
(general_id text,
ownershipAsset text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create table sanctions.vehicle
(general_id text,
buildDate text array,
model text array,
operator text array,
owner text array,
registrationDate text array,
registrationNumber text array,
type text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create table sanctions.airplane
(general_id text,
icaoCode text array,
manufacturer text array,
serialNumber text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create or replace procedure sanctions.sp_fill_asset_with_json(in_json_asset json)
language plpgsql as
$$
begin
	insert into sanctions.asset
		(select * from json_to_record
	($1) as x
	(general_id text,
	ownershipAsset text array));
end;
$$;

create or replace procedure sanctions.sp_fill_value_with_json(in_json_value json)
language plpgsql as
$$
begin
	insert into sanctions.value 
		(select * from json_to_record
	($1) as x
	(general_id text,
	amount money ,
	amountEur money,
	amountUsd money,
	currency text array));
end;
$$;

create or replace procedure sanctions.sp_fill_vehicle_with_json(in_json_vehicle json)
language plpgsql as
$$
begin
	insert into sanctions.vehicle 
		(select * from json_to_record
	($1) as x
	(general_id text,
	buildDate text array,
	model text array,
	operator text array,
	owner text array,
	registrationDate text array,
	registrationNumber text array,
	type text array));
end;
$$;

create or replace procedure sanctions.sp_fill_airplane_with_json(in_json_airplane json)
language plpgsql as
$$
begin
	insert into sanctions.airplane 
		(select * from json_to_record
	($1) as x
	(general_id text,
	icaoCode text array,
	manufacturer text array,
	serialNumber text array));
end;
$$;