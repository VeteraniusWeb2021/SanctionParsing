create table sanctions.sanction
(general_id text,
authority text array,
authorityId text array,
country text array,
duration text array,
entity text array,
listingDate text array,
program text array,
provisions text array,
reason text array,
status text array,
unscId text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
) ;

create or replace procedure sanctions.sp_fill_sanction_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\Sanction.json';
		insert into sanctions.sanction
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