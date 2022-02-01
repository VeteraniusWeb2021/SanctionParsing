create table sanctions.security
(general_id text,
classification text array,
collateral text array,
isin text array,
issueDate text array,
issuer text array,
ticker text array,
type text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create or replace procedure sanctions.sp_fill_security_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\Security.json';
		insert into sanctions.security
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