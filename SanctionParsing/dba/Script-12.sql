	
create or replace function fn_test2_thing(id text)
returns json as 
$$
declare
ar text array;
js json;
jstmp json;
begin
	js = row_to_json(fn_get_entities(1));
	if 
		(select array_length(et.referents,1) from sanctions.entities_true et
			where et.id_int = 1)>0 
	then jstmp =( select array_to_json(array_agg(row_to_json(t))) from fn_test_get_query() t) y;
		return jsonb_set(js::jsonb,'{referents}',jstmp::jsonb);

	end if;
return js;
end;
$$ language plpgsql;

select fn_test2_thing('2');

	
create or replace function fn_test_get_query()
returns setof sanctions.entities as
$$
begin
	return query
	with et as
(select id from sanctions.entities_true 
	where id_int=1),
tmp as
(select unnest(addressentity) as u from sanctions.thing t
	join et e on e.id = t.general_id)
		select id_int,caption,datasets,first_seen,id,last_seen,referents,"schema",target from sanctions.entities ee
			join tmp on tmp.u=ee.id;
			
end;
$$ language plpgsql;

select row_to_json(fn_test_get_query());
select array_to_json(array_agg(row_to_json(t))) from fn_test_get_query() t;
select array_agg(row_to_json(t)) from fn_test_get_query() t;

select array_to_json(array_agg(select id from sanctions.entities_true 
	where id_int=1));

SELECT array_to_json(array_agg(e), FALSE) AS ok_json FROM sanctions.entities e where e.id_int=1;

select array_agg(caption) from sanctions.entities e;

create or replace function fn_get_properties()
returns json as
$$
begin
	
end;
$$;

create or replace function fn_t()
returns json as
$$
declare
j json;
begin
	 j =(select row_to_json(t) from (select * from sanctions.thing 
	 	where general_id = 'eu-fsf-eu-1644-40')t);
	 return j::json#>'{addressentity}';
end;
$$ language plpgsql;
select fn_t();

create or replace function fn_tt()
returns json as
$$
begin
return (select row_to_json(t) from (select * from sanctions.entities_true e 
	where id_int = 21)t);	 	
end;
$$ language plpgsql;

	

select json_array_length ((select row_to_json(t) from (select * from sanctions.entities_true e 
	where id_int = 21)t)::json #>'{referents}'); 
select * from sanctions.thing where general_id='eu-fsf-eu-1644-40';
select row_to_json(public.fn_thing('eu-fsf-eu-1644-40'));
select * from  public.fn_person('eu-fsf-eu-1644-40');

--/////////////////////
create or replace function fn_get_thing_head(id text)
returns json as
$$
declare
js json = fn_get_entity($1);
pro json;
begin
	pro = fn_get_thing($1);
	js = jsonb_set(js::jsonb,'{properties}',pro::jsonb);
	return js;
end;
$$ language plpgsql;
--////////////////////////////////
	 select fn_get_thing_head('eu-fsf-eu-1644-40');
select	 jsonb_pretty((select fn_get_thing_head('eu-fsf-eu-1644-40'))::jsonb);
	
	drop function fn_get_thing_head(int);
	 select * from sanctions.thing;
	
--	//////////////////////////////////////////// 
create or replace function fn_get_entity(id text)
returns json as
$$
begin
	return  row_to_json(t) from (select * from sanctions.entities e
		where e.id = $1)t;
end;
$$ language plpgsql;	
	
	
select array(select json_array_elements_text
	(fn_t())) ;
	
create or replace function fn_get_thing(id text)
returns json as
$$
declare
js json;
js_country json;
i int = 1;
arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	js = row_to_json(t) from
	(select * from sanctions.thing et
		where et.general_id = $1)t;
	if json_array_length(js::json #>'{addressentity}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{addressentity}')));
			 foreach elem in array arr
				loop
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity(elem)::jsonb);
				end loop;
			js = jsonb_set(js::jsonb,'{addressentity}',(tmp::json#>'{1}')::jsonb);
	end if;
		
	if json_array_length(js::json #>'{sanctions}')>0 
		then
			arr = (select array(select json_array_elements_text
				(js::json #>'{sanctions}')));
			foreach elem in array arr 
			loop
			tmp= jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity(elem)::jsonb);
				end loop;
			js = jsonb_set(js::jsonb,'{sanctions}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{country}')>0 
		then 
			js_country = (select fn_get_country_thing($1));
			js = jsonb_set(js::jsonb,'{country}',(js_country::json#>'{country}')::jsonb);
	end if;
	if json_array_length(js::json #>'{unknownLinkFrom}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{unknownLinkFrom}')));
			 foreach elem in array arr
				loop
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity(elem)::jsonb);
				end loop;
			js = jsonb_set(js::jsonb,'{unknownLinkFrom}',(tmp::json#>'{1}')::jsonb);
	end if;
	if json_array_length(js::json #>'{unknownLinkTo}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{unknownLinkTo}')));
			 foreach elem in array arr
				loop
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity(elem)::jsonb);
				end loop;
			js = jsonb_set(js::jsonb,'{unknownLinkTo}',(tmp::json#>'{1}')::jsonb);
	end if;
	return js;
end;
$$ language plpgsql;

select fn_get_thing('NK-8A3QP3QJd4t49Dugcek2LX');

select * from sanctions.entities where id in	
(select unnest(addressentity) from sanctions.thing 
where general_id = 'eu-fsf-eu-1644-40');
select * from sanctions.thing where general_id = 'eu-fsf-eu-1644-40';
	
	select jsonb_insert('{"a": [0,1,2]}', '{a, 1}', '"new_value"');
	
select row_to_json(co) from (select array(select unnest(country)) as country from sanctions.thing
 where general_id = 'eu-fsf-eu-1644-40')co;

select sc."label" from
(select general_id,unnest(country) as country from sanctions.thing)st
	join sanctions.country sc on sc.code=st.country
		 where st.general_id = 'eu-fsf-eu-1644-40';	
drop function fn_get_country_thing( text);

create or replace function fn_get_country_thing(id text)
returns json as
$$

begin
			 		
	return (select row_to_json(ghj) as country from(
	 select array (select sc."label" as country from
					(select general_id,unnest(country) as country from sanctions.thing)st
						join sanctions.country sc on sc.code=st.country
		 					where st.general_id = $1)country)ghj);				
end;
$$ language plpgsql;


select fn_get_country_thing('NK-8A3QP3QJd4t49Dugcek2LX');

select row_to_json(ghj) as country from(
	 select array (select sc."label" as country from
					(select general_id,unnest(country) as country from sanctions.thing)st
						join sanctions.country sc on sc.code=st.country
		 					where st.general_id = 'NK-8A3QP3QJd4t49Dugcek2LX')country)ghj;	
	
	select array(select unnest(country) from sanctions.thing t
	where general_id = 'NK-8A3QP3QJd4t49Dugcek2LX')g;