create or replace function fn_get_vessel_head(id text,id_old text)
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

	pro = jsonb_insert(pro::jsonb,'{properties,4}',fn_get_vessel($1,$2)::jsonb);
																							
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--///////////////////////////

create or replace function fn_get_vessel(id text,id_old text)
returns json as
$$
declare
js json;
js_country json;


begin
	js = row_to_json(t) from
	(select * from sanctions.vessel et
		where et.general_id = $1)t;
	js = strip_nulls(js);
		
if json_array_length(js::json #>'{flag}')>0 
		then 
			js_country = (select fn_get_flag_vessel($1));
			js = jsonb_set(js::jsonb,'{flag}',(js_country::json#>'{country}')::jsonb);
	end if;	

	return js;
end;
$$ language plpgsql;

--/////////////////////

create or replace function fn_get_flag_vessel(id text)
returns json as
$$

begin
			 		
	return (select row_to_json(ghj) as country from(
	 select array (select sc."label" as country from
					(select general_id,unnest(flag) as country from sanctions.vessel)st
						join sanctions.country sc on sc.code=st.country
		 					where st.general_id = $1)country)ghj);				
end;
$$ language plpgsql;

--//////////////////
