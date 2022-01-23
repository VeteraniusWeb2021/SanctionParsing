--заполняет одну таблицу из файла json к этой таблице(в from нужно указать абсолютный или относительный путь к файлу)

create or replace procedure sanctions.sp_fill_entities_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'путь к локал файлу например G:\database\veteranius\Entities.json';
		insert into sanctions.entities
			(select 
				value->>'caption',
				array[value->>'datasets'],
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array[value->>'referents'],
				value->>'schema',
				value->>'target'
					from temp_json);
end;
$$;