create or replace function fn_get_entity(id text)
returns json as
$$
begin
	return  row_to_json(t) from (select * from sanctions.entities e
		where e.id = $1)t;
end;
$$ language plpgsql;	
	
	

	
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

	