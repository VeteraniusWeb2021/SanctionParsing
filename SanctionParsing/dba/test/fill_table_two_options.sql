--заполняет одну таблицу из файла json к этой таблице(в from нужно указать абсолютный или относительный путь к файлу)

копи в json ,работает с экранированными символами with file type .txt

drop schema sanctions cascade;
create schema sanctions;
delete from sanctions.entities ;

create or replace procedure sanctions.sp_fill_entities_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\test\test_json.txt';
		insert into sanctions.entities(
				caption ,
				datasets  ,
				first_seen ,
				id ,
				last_seen ,
				referents  ,
				schema ,
				target )
			(select 
				value->>'caption',
				array[json_array_elements_text (value->'datasets')],
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array[json_array_elements_text (value->'referents')],
				value->>'schema',
				value->>'target'
					from temp_json);
end;
$$;

call sanctions.sp_fill_entities_with_json();
select * from sanctions.entities e ;


Работает с неэкранированными символами т.е. с одним бэкслешем и с массивом "datasets": ["eu_fsf","eu"]

create or replace procedure sanctions.sp_fill_entities_with_json(in_json_entities json)
language plpgsql as
$$
begin
	insert into sanctions.entities (
	caption,
	datasets,
	first_seen,
	id,
	last_seen,
	referents,
	schema,
	target)
		(select * from json_to_recordset
	($1) as x
	(caption text,
	datasets text array,
	first_seen text,
	id text,
	last_seen text,
	referents text array,
	schema text,
	target text));
end;
$$;
select * from sanctions.entities e ;
call sanctions.sp_fill_entities_with_json('[{"caption": "Vladimir Stepanovich ALEXSEYEV", "datasets": ["eu_fsf"], "first_seen": "2021-09-26T14:52:11", "id": "NK-2ZrGocoY3llAQBHSbpKg5", "last_seen": "2021-12-19T03:03:11", "referents": ["eu-fsf-eu-4908-14"], "schema": "Person", "target": true},
{"caption": "Vladimir Stepnovich ALEXSEYEV", "datasets": ["eu_fsf"], "first_seen": "2021-09-26T14:52:11", "id": "NK-2ZrGJDokkcRYQBHpbpKg5", "last_seen": "2021-12-19T03:03:11", "referents": ["eu-fsf-eu-4908-14"], "schema": "Person", "target": true}]');
