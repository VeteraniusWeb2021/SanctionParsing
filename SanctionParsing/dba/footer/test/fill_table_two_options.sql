--заполняет одну таблицу из файла json к этой таблице(в from нужно указать абсолютный или относительный путь к файлу)

копи в json ,работает с экранированными символами with file type .txt
предусмотреть on conflict и удаление temp_json при не удачной загрузке

drop schema sanctions cascade;
create schema sanctions;
delete from sanctions.entities ;

create or replace procedure sanctions.sp_fill_entities_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\test\test_entities.txt';
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
				array (select json_array_elements_text (value->'datasets')) as dtsets,
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array (select json_array_elements_text (value->'referents')) as rfs,
				value->>'schema',
				(value->>'target')::boolean
					from temp_json );
end;
$$;
rollback;

call sanctions.sp_fill_entities_with_json();
select * from sanctions.entities e ;
select * from public.test_json;

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
select * from sanctions.entities e 
where id = 'NK-26Wuf6B9yzZ95N89D6ZGoD';
call sanctions.sp_fill_entities_with_json('[{"caption": "Vladimir Stepanovich ALEXSEYEV", "datasets": ["eu_fsf"], "first_seen": "2021-09-26T14:52:11", "id": "NK-2ZrGocoY3AQBHSbpKg5", "last_seen": "2021-12-19T03:03:11", "referents": ["eu-fsf-eu-4908-14"], "schema": "Person", "target": true},
{"caption": "Vladimir Stepnovich ALEXSEYEV", "datasets": ["eu_fsf","eu"], "first_seen": "2021-09-26T14:52:11", "id": "NK-2ZrGJDokkcRQBHpbpKg5", "last_seen": "2021-12-19T03:03:11", "referents": ["eu-fsf-eu-4908-14"], "schema": "Person", "target": true}]');


rollback;
begin;
		create table  temp_json (value json);
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\test\test_entities.txt';
	select count(*) from public.temp_json;

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
				array_agg(ds) lateral from json_array_elements_text (value->'datasets') as ds,
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array_agg (re) lateral from json_array_elements_text (value->'referents') as re,
				value->>'schema',
				value->>'target'
					from temp_json);
					
				
select array_agg(t) from json_array_elements_text('{"b":["c","foo"]}'::json->'b') as t;
select array_agg(json_array_elements_text('{"b":["c","foo"]}'::json->'b')) ;

select string_agg(t::text) from json_array_elements_text('{"b":["c","foo"]}'::json->'b') as t;

create table tbl (tbl_id int,data json);
create table tb2 (id int,list text array);
insert into tbl values (1,'{
    "name": "foo",
    "tags": ["foo", "bar"]
}');
drop table tbl;

SELECT t.tbl_id, d.list
FROM   tbl t
CROSS  JOIN LATERAL (
   SELECT string_agg(d.elem::text, ', ') AS list
   FROM   json_array_elements_text(t.data->'tags') AS d(elem)
   ) d;

SELECT tbl_id, ARRAY(SELECT json_array_elements_text(t.data->'tags')) AS txt_arr
FROM   tbl t;

create table ttt (id int,tex boolean);insert into ttt values (1,'true'::boolean),(2,'false'::boolean);
select * from ttt ;
