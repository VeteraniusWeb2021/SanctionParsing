create or replace function fn_get_organization_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2)::jsonb);
																						
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_legalentity($1,$2)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_organization($1,$2)::jsonb);

																							
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--///////////////////////////

create or replace function fn_get_organization(id text,id_old text)
returns json as
$$
declare
js json;
js_country json;
arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	js = row_to_json(t) from
	(select * from sanctions.organization et
		where et.general_id = $1)t;
	js = strip_nulls(js);
		
	
	
	if json_array_length(js::json #>'{directorshiporganization}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{directorshiporganization}')));
			 foreach elem in array arr
				loop
				
			
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_directorships_head(elem,$2,'directorshiporganization')::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;
				end loop;
			js = jsonb_set(js::jsonb,'{directorshiporganization}',(tmp::json#>'{1}')::jsonb);
		
	end if;

	if json_array_length(js::json #>'{membershiporganization}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{membershiporganization}')));
			 foreach elem in array arr
				loop
				
			
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_membership_head(elem,$2,'membershiporganization')::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;
				end loop;
			js = jsonb_set(js::jsonb,'{membershiporganization}',(tmp::json#>'{1}')::jsonb);
		
	end if;
			
	return js;
end;
$$ language plpgsql;

--/////////////////////

create or replace function fn_get_membership_head(id text,id_old text,flag text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
																						
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_interest($1)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_membership($1,$2,$3)::jsonb);

																							
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--///////////////////////////

create or replace function fn_get_directorships_head(id text,id_old text,flag text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
pro_temp json;
begin
	js = fn_get_entity($1);
				
				
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
		
				
				
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_interest($1)::jsonb);
		
	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_directorships($1,$2,$3)::jsonb);

																							
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--///////////////////////////

create or replace function fn_get_membership(id text,id_old text,flag text)
returns json as
$$
declare
js json;
flag text=$3;
arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.membership et
		where et.general_id = $1)t;
	js = strip_nulls(js);
	
		if flag = 'membershiporganization' then																	
			if json_array_length(js::json #>'{member}')>0 
					then 
							
							flag='stop';
							arr = (select array(select json_array_elements_text
							(js::json #>'{member}')));
							 foreach elem in array arr
							loop
								if $2 != elem then   
								
							tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity_head(elem,$2,flag)::jsonb);
							
							else 
								tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
							end if;																											
							
					end loop;
					js = jsonb_set(js::jsonb,'{member}',(tmp::json#>'{1}')::jsonb);
			end if;
		end if;
	
			if $3 = 'membershipmember' then
					flag='stop';
								
					if json_array_length(js::json #>'{organization}')>0 
							then 
								tmp  = ('{"1":[]}');
								arr = (select array(select json_array_elements_text
									(js::json #>'{organization}')));
									 foreach elem in array arr
									loop
										if $2 != elem then   
										
									tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity_head(elem,$2,flag)::jsonb);
									
								else 
										tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
									end if;																											
									
							end loop;
							js = jsonb_set(js::jsonb,'{organization}',(tmp::json#>'{1}')::jsonb);
					end if;
			end if;	
	return js;

end;
$$ language plpgsql;

--///////////////////////////

create or replace function fn_get_directorships(id text,id_old text,flag text)
returns json as
$$
declare
js json;
flag text=$3;
arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.directorships et
		where et.general_id = $1)t;
	js = strip_nulls(js);
	
		if flag = 'directorshiporganization' then																	
			if json_array_length(js::json #>'{director}')>0 
					then 
							
							flag='stop';
							arr = (select array(select json_array_elements_text
							(js::json #>'{director}')));
							 foreach elem in array arr
							loop
								if $2 != elem then   
								
							tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity_head(elem,$2,flag)::jsonb);
							
						
							else 
								tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
							end if;																											
							
					end loop;
					js = jsonb_set(js::jsonb,'{director}',(tmp::json#>'{1}')::jsonb);
			end if;
		end if;
	
			if $3 = 'directorshipdirector' then
					
					flag='stop';
									
					if json_array_length(js::json #>'{organization}')>0 
							then 
								tmp  = ('{"1":[]}');
								arr = (select array(select json_array_elements_text
									(js::json #>'{organization}')));
									 foreach elem in array arr
									loop
										if $2 != elem then   
										
									tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity_head(elem,$2,flag)::jsonb);
									
								else 
										tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
									end if;																											
									
							end loop;
							js = jsonb_set(js::jsonb,'{organization}',(tmp::json#>'{1}')::jsonb);
					end if;
			end if;	
		
	return js;
	
end;
$$ language plpgsql;

--///////////////////////////

