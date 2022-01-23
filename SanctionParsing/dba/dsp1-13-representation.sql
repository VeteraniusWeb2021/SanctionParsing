create table sanctions.representation
(general_id text,
agent text array,
client text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
) ;

create or replace procedure sanctions.sp_fill_representation_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\Representation.json';
		insert into sanctions.representation
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