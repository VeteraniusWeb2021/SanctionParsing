create table sanctions.ownership
(general_id text,
asset text array,
legalBasis text array,
owner text array,
ownershipType text array,
percentage text array,
sharesCount text array,
sharesCurrency text array,
sharesType text array,
sharesValue text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
) ;

create or replace procedure sanctions.sp_fill_ownership_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\Ownership.json';
		insert into sanctions.ownership
			(select 
				value->>'caption',
				array[value->>'datasets'],
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				value->>'referents',
				value->>'schema',
				value->>'target'
					from temp_json);
end;
$$;