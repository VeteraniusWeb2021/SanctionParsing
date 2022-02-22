

drop table ee;

create table ee as select * from sanctions.entities;
alter table ee add primary key (id);
alter table ee drop column id_int;
alter table ee add column id_int serial;
alter table ee alter column id_int type int;

delete from ee;
truncate ee;

truncate flat;

create table le as select *  from sanctions.legalentity ; 
--9393 rows;

delete from le;
drop table le;
create table flat(value json);

copy flat from 'C:\Essence_files\legalentity.txt';
--17295 rows;

select * from flat;

where value->>'general_id' = 'NK-L5E9NF2UdERGdkJ3Tepzhu';

select value->>'general_id',count(*) from flat f 
group by value->>'general_id';


select * from 
(select value->>'general_id' as t,f.*,count (*)  over(partition by (value->>'general_id'))
from flat f )t where t.count >1;

select * from le;

-- сюда вставлять значения row count 9393 total count flat 17295
drop table dist_le;

select * from dist_le;

create table dist_le as
(select row_to_json(l) as value from le l);

select * from dist_le;

do
$$
declare
curs cursor for select value  from flat;
cursIn refcursor;
rc record;
r record;
js json;
js_tmp json;
rjs json;
arr text array;
fff text;
item text;
iin int = 0;
outt int = 0;
begin
	open curs;
		loop
		outt = outt+1;
		raise notice 'outt %',outt;
			fetch curs into rc;
		IF NOT FOUND THEN EXIT;END IF;
			js = to_json(rc.value);
			
			arr = (select array(select json_object_keys(js)));
		raise notice 'js %',js;
	open cursIn for select value from dist_le le 
				where (value::json ->> 'general_id') = (js::json->>'general_id');
	fetch cursIn into r;
		foreach item in array arr
			loop
			js_tmp = r.value;
			iin = iin +1;
			raise notice 'iin %',iin;
			raise notice 'item %',item;
						
			raise notice 'r before set %',js_tmp;
					js_tmp = jsonb_set((r.value)::jsonb,array(select item),((rc.value)::json#>array(select item))::jsonb);
			raise notice 'r after set %',js_tmp;
		r.value=js_tmp;
			end loop;
		UPDATE dist_le SET value = r.value WHERE CURRENT OF cursIn;
		close cursIn;
		end loop;
	close curs;	
end;
$$;	
	
do
$$
declare
t text = 'item' ;
arr text array;
js json = '{"value":"n"}';
begin
	js =jsonb_set(js::jsonb,array(select t),js::jsonb);
raise notice 'js %',js;
end;
$$;


select value  from dist_le
	where (value::json ->> 'general_id') = 'NK-QthD3sQ5gXpBrH3DXvd58m';

	js = to_json(r.value);

	
	select value  into r from flat
	where (value::json ->> 'general_id') = 'eu-fsf-eu-2951-42';
	js = to_json(r.value);
	

	
	arr = (select array(select json_object_keys(js)));
	
	fff = arr[1];
	raise notice 'notice r %',js; 

	raise notice 'notice r %',arr; 
	 
end;
$$;

select json_object_keys(to_json(t)) from (select value from flat
	where (value::json ->> 'general_id') = 'eu-fsf-eu-2951-42')t;

select * from flat;

create or replace function gett()
returns json
$$
declare
curs cursor for select value  from flat;
r record;
rjs json;
js json;
arr text array;
begin
	open curs;
		loop
		
		
		
		end loop;
	close curs;
end;
$$ language plpgsql;

--////////////////
rjs = r::jsonb#>'{value}';
	arr = (select array(select jsonb_object_keys(rjs)));
	foreach item in array arr
		loop
		r::json->>''||item||''
		
			where (value::json ->> 'general_id') = 'eu-fsf-eu-2951-42';
			js = to_json(r);
			js = jsonb_set(js::jsonb#>'{value}','{prop}','{"add":"g"}'::jsonb);
			return js; 
--////////////////////////////


select count(*) from flat;


where value->>'id' in (select distinct value->>'id' from flat);

 
51301

select count(distinct value->>'id') from flat;
33931

















do 
$$
begin
		insert into public.ee(
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
				array (select json_array_elements_text ( value->'datasets')) as dtsets,
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array (select json_array_elements_text (value->'referents')) as rfs,
				value->>'schema',
				(value->>'target')::boolean
					from flat )  ;
end;
$$;

create table foo (f int ,b int);
drop table foo;
insert into foo values (1,2),(2,2);
insert into foo values (1,3),(1,5),(3,4),(3,5);
select * from foo
where ;
	