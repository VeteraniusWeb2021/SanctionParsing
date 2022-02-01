create table sanctions.passport
(general_id text,
birthDate text array,
birthPlace text array,
gender text array,
givenName text array,
passportNumber text array,
personalNumber text array,
surname text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create or replace procedure sanctions.sp_fill_passport_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\Passport.json';
		insert into sanctions.passport
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