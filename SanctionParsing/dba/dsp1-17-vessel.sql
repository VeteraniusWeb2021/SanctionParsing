create table sanctions.vessel
(general_id text,
callSign text array,
crsNumber text array,
flag text array,
grossRegisteredTonnage text array,
imoNumber text array,
mmsi text array,
nameChangeDate text array,
navigationArea text array,
pastFlags text array,
pastNames text array,
pastTypes text array,
registrationPort text array,
tonnage text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);