create table sanctions.company
(general_id text,
bikCode text array,
caemCode text array,
capital text array,
cikCode text array,
coatoCode text array,
fnsCode text array,
fssCode text array,
ibcRuc text array,
ipoCode text array,
irsCode text array,
jibCode text array,
kppCode text array,
mbsCode text array,
ogrnCode text array,
okopfCode text array,
oksmCode text array,
okvedCode text array,
pfrNumber text array,
voenCode text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create table sanctions.organization
(general_id text,
directorshipOrganization text array,
membershipOrganization text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create or replace procedure sanctions.sp_fill_company_with_json(in_json_company json)
language plpgsql as
$$
begin
	insert into sanctions.company
		(select * from json_to_record
	($1) as x
	(general_id text,
	bikCode text array,
	caemCode text array,
	capital text array,
	cikCode text array,
	coatoCode text array,
	fnsCode text array,
	fssCode text array,
	ibcRuc text array,
	ipoCode text array,
	irsCode text array,
	jibCode text array,
	kppCode text array,
	mbsCode text array,
	ogrnCode text array,
	okopfCode text array,
	oksmCode text array,
	okvedCode text array,
	pfrNumber text array,
	voenCode text array
	));
end;
$$;

create or replace procedure sanctions.sp_fill_organization_with_json(in_json_organization json)
language plpgsql as
$$
begin
	insert into sanctions.organization
		(select * from json_to_record
	($1) as x
	(general_id text,
	directorshipOrganization text array,
	membershipOrganization text array));
end;
$$;
