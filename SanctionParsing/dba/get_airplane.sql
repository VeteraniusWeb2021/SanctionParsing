create or replace function fn_get_airplane_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_value($1)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_asset($1,$2)::jsonb);
																						
	pro = jsonb_insert(pro::jsonb,'{properties,3}',fn_get_vehicle($1,$2)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,4}',fn_get_airplane($1,$2)::jsonb);
																							
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--///////////////////////////

create or replace function fn_get_airplane(id text,id_old text)
returns json as
$$
declare
js json;
begin
	js = row_to_json(t) from
	(select * from sanctions.airplane et
		where et.general_id = $1)t;
	
	js = strip_nulls(js);

	return js;
end;
$$ language plpgsql;

--/////////////////////
