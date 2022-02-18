select fn_get_test_double_insert('eu-fsf-88734b4951229bda8d11d077b16851a2f3630ee2','eu-fsf-88734b4951229bda8d11d077b16851a2f3630ee2');

--///////////////////////////////////

create or replace function fn_get_legalentity_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_legalentity($1,$2)::jsonb);
																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;


--///////////////////////////////

create or replace function fn_get_representation(id text,id_old text)
returns json as
$$
declare
js json;

arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.representation et
		where et.general_id = $1)t;
																		
		if json_array_length(js::json #>'{agent}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{agent}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{agent}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{client}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{client}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{client}',(tmp::json#>'{1}')::jsonb);
	end if;
	return js;
end;
$$ language plpgsql;
