--	//////////////////////////////////////////// 

create or replace function fn_get_entity(id text)
returns json as
$$
begin
																						
	return  row_to_json(t) from (select * from sanctions.entities e
		where e.id = $1)t;
end;
$$ language plpgsql;	
--////////////////////////	
drop function fn_get_interval(text);

create or replace function fn_get_interval(id text)
returns json as
$$
declare
js json;
tmp json = ('{"1":[]}');
begin
--	js = fn_get_entity($1);
	js = (select row_to_json(t) from (select * from sanctions.interval e
		where e.general_id = $1)t);
	
--	js = jsonb_set(js::jsonb,'{properties}',tmp::jsonb);
	return test_null(js);
end;
$$ language plpgsql;

--//////////////////

create or replace function fn_get_address(id text,id_old text)
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
	(select * from sanctions.address et
		where et.general_id = $1)t;
	js = test_null(js);
		
	if json_array_length(js::json #>'{country}')>0 
		then 
			js_country = (select fn_get_country_address($1));
			js = jsonb_set(js::jsonb,'{country}',(js_country::json#>'{country}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{things}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{things}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_thing_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;
				end loop;
			js = jsonb_set(js::jsonb,'{things}',(tmp::json#>'{1}')::jsonb);
		
	end if;
	
	return js;
end;
$$ language plpgsql;

--//////////////////////////////

create or replace function fn_get_thing(id text,id_old text)
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
	(select * from sanctions.thing et
		where et.general_id = $1)t;
	js = test_null(js);
																						
	if json_array_length(js::json #>'{addressentity}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{addressentity}')));
			 foreach elem in array arr
				loop
					if $2 != elem then		
					
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_addresses_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;
				
				end loop;
			js = jsonb_set(js::jsonb,'{addressentity}',(tmp::json#>'{1}')::jsonb);
																				
	end if;
				
																						
	if json_array_length(js::json #>'{sanctions}')>0 
																											
		then
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{sanctions}')));
			foreach elem in array arr 
			loop
				if $2 != elem then
			tmp= jsonb_insert(tmp::jsonb,'{1,0}',fn_get_sanctions_head(elem,$2)::jsonb);
			
				else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																					

				end loop;
					
			js = jsonb_set(js::jsonb,'{sanctions}',(tmp::json#>'{1}')::jsonb);
		
	end if;
	
	if json_array_length(js::json #>'{country}')>0 
		then 
			js_country = (select fn_get_country_thing($1));
			js = jsonb_set(js::jsonb,'{country}',(js_country::json#>'{country}')::jsonb);
	end if;

	if json_array_length(js::json #>'{unknownlinkfrom}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{unknownlinkfrom}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_other_link_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;
				end loop;
			js = jsonb_set(js::jsonb,'{unknownlinkfrom}',(tmp::json#>'{1}')::jsonb);
	end if;
	if json_array_length(js::json #>'{unknownlinkto}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{unknownlinkto}')));
			 foreach elem in array arr
				loop
				if $2 != elem then 
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_other_link_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if; 
				end loop;
			js = jsonb_set(js::jsonb,'{unknownlinkto}',(tmp::json#>'{1}')::jsonb);
	end if;
		
	return js;
end;
$$ language plpgsql;

--///////////////////////////////////////////////////////////////////////
select fn_get_thing_head('eu-fsf-eu-1644-40','eu-fsf-eu-1644-40');

select * from sanctions.address
where general_id = 'NK-iesSZjZZh88GNPE993NEoM';
select * from sanctions.entities 
where id in (
select unnest(addressentity) from sanctions.thing 
	where general_id = 'eu-fsf-eu-1644-40');

--/////////////

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
--//////////////////

create or replace function fn_get_country_address(id text)
returns json as
$$

begin
			 		
	return (select row_to_json(ghj) as country from(
	 select array (select sc."label" as country from
					(select general_id,unnest(country) as country from sanctions.address)st
						join sanctions.country sc on sc.code=st.country
		 					where st.general_id = $1)country)ghj);				
end;
$$ language plpgsql;

--/////////////

create or replace function fn_get_addresses_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
																					
	js = fn_get_entity($1);
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_address($1,$2)::jsonb);
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	

	return js;
end;
$$ language plpgsql;

--/////////////////////////////

create or replace function fn_get_thing_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	
																						
	js = fn_get_entity($1);
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2)::jsonb);
																						
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);

	
	return js;
end;
$$ language plpgsql;

--//////////////////

create or replace function fn_get_other_link(id text,id_old text)
returns json as
$$
declare
js json;
arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	js = row_to_json(t) from
	(select * from sanctions.other_link et
		where et.general_id = $1)t;
	js = test_null(js);
			
	if json_array_length(js::json #>'{object}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{object}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_thing_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;
				end loop;
			js = jsonb_set(js::jsonb,'{object}',(tmp::json#>'{1}')::jsonb);
	end if;

	if json_array_length(js::json #>'{subject}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{subject}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_thing_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;
				end loop;
			js = jsonb_set(js::jsonb,'{subject}',(tmp::json#>'{1}')::jsonb);
	end if;

	return js;
end;
$$ language plpgsql;

--/////////////////////

create or replace function fn_get_other_link_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_interest($1)::jsonb);
	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_other_link($1,$2)::jsonb);
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);

	return js;
end;
$$ language plpgsql;

--//////////////////////////

create or replace function fn_get_sanctions(id text,id_old text)
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
	(select * from sanctions.sanction et
		where et.general_id = $1)t;
	js = test_null(js);
																								
	if json_array_length(js::json #>'{country}')>0 
		then 
			js_country = (select fn_get_country_sanctions($1));
			js = jsonb_set(js::jsonb,'{country}',(js_country::json#>'{country}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{entity}')>0 
		then 
			
			arr = (select array(select json_array_elements_text
				(js::json #>'{entity}')));
				 foreach elem in array arr
				loop
					if $2 != elem then   
					
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_thing_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;																											
				
			end loop;
			js = jsonb_set(js::jsonb,'{entity}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	return js;
end;
$$ language plpgsql;

--//////////////////

create or replace function fn_get_country_sanctions(id text)
returns json as
$$

begin
			 		
	return (select row_to_json(ghj) as country from(
	 select array (select sc."label" as country from
					(select general_id,unnest(country) as country from sanctions.sanction)st
						join sanctions.country sc on sc.code=st.country
		 					where st.general_id = $1)country)ghj);	
		 				
end;
$$ language plpgsql;

--/////////////////////////////


--/////////////////////////////////


--////////////////////////////

create or replace function fn_get_sanctions_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_sanctions($1,$2)::jsonb);
																							
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--//////////////////////////

drop function fn_get_legalentity(text,text);


create or replace function fn_get_legalentity(id text,id_old text)
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
	(select * from sanctions.legalentity et
		where et.general_id = $1)t;
	js = test_null(js);
																						
	if (json_array_length(js::json #>'{agencyclient}'))>0 
		then 
		
			arr = (select array(select json_array_elements_text
				(js::json #>'{agencyclient}')));
			
			 foreach elem in array arr
			 																							
				loop									
					if $2 != elem then	
					
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_representation_head(elem,$2,'agencyclient')::jsonb);
--							raise notice 'row 445 %',tmp;																							
																													
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																			
				end loop;
			
			js = jsonb_set(js::jsonb,'{agencyclient}',(tmp::json#>'{1}')::jsonb);
																				
	end if;
				
																						
	if json_array_length(js::json #>'{agentrepresentation}')>0 
																											
		then
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{agentrepresentation}')));
			foreach elem in array arr 
			loop
				if $2 != elem then
					tmp= jsonb_insert(tmp::jsonb,'{1,0}',fn_get_representation_head(elem,$2,'agentrepresentation')::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;																							
				end loop;
					
			js = jsonb_set(js::jsonb,'{agentrepresentation}',(tmp::json#>'{1}')::jsonb);
		
	end if;
	
	if json_array_length(js::json #>'{jurisdiction}')>0 
		then 
			
			js_country = (select fn_get_country_jurisdiction($1));
			js = jsonb_set(js::jsonb,'{jurisdiction}',(js_country::json#>'{country}')::jsonb);
	end if;

	if json_array_length(js::json #>'{maincountry}')>0 
		then 
			js_country = (select fn_get_country_mainCountry($1));
			js = jsonb_set(js::jsonb,'{maincountry}',(js_country::json#>'{country}')::jsonb);
	end if;

	if json_array_length(js::json #>'{cryptowallets}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{cryptowallets}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_crypto_wallet_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{cryptowallets}',(tmp::json#>'{1}')::jsonb);
	end if;
	if json_array_length(js::json #>'{directorshipdirector}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{directorshipdirector}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_directorships_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{directorshipdirector}',(tmp::json#>'{1}')::jsonb);
	end if;
		
	if json_array_length(js::json #>'{identificiation}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{identificiation}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_identification_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{identificiation}',(tmp::json#>'{1}')::jsonb);
	end if;

	if json_array_length(js::json #>'{membershipmember}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{membershipmember}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_membership_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{membershipmember}',(tmp::json#>'{1}')::jsonb);
	end if;

	if json_array_length(js::json #>'{operatedvehicles}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{operatedvehicles}')));
			 foreach elem in array arr
				loop
					if $2 != elem then																				
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_vehicle_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;																				
				end loop;
			js = jsonb_set(js::jsonb,'{operatedvehicles}',(tmp::json#>'{1}')::jsonb);
																			
	end if;
																						
	if json_array_length(js::json #>'{ownedvehicles}')>0 
																											
		then
			tmp  = ('{"1":[]}');
				arr = (select array(select json_array_elements_text
				(js::json #>'{ownedvehicles}')));
			foreach elem in array arr 
			loop
				if $2 != elem then
					tmp= jsonb_insert(tmp::jsonb,'{1,0}',fn_get_vehicle_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;																							
				end loop;
					
			js = jsonb_set(js::jsonb,'{ownedvehicles}',(tmp::json#>'{1}')::jsonb);
		
	end if;

	if json_array_length(js::json #>'{ownershipowner}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{ownershipowner}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_ownership_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{ownershipowner}',(tmp::json#>'{1}')::jsonb);
	end if;
	if json_array_length(js::json #>'{parent}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{parent}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{parent}',(tmp::json#>'{1}')::jsonb);
	end if;

	if json_array_length(js::json #>'{securities}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{securities}')));
			 foreach elem in array arr
				loop
					if $2 != elem then																				
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_security_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;																				
				end loop;
			js = jsonb_set(js::jsonb,'{securities}',(tmp::json#>'{1}')::jsonb);
																			
	end if;
																						
	if json_array_length(js::json #>'{subsidiaries}')>0 
																											
		then
			tmp  = ('{"1":[]}');
				arr = (select array(select json_array_elements_text
				(js::json #>'{subsidiaries}')));
			foreach elem in array arr 
			loop
				if $2 != elem then
					tmp= jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;																							
				end loop;
					
			js = jsonb_set(js::jsonb,'{subsidiaries}',(tmp::json#>'{1}')::jsonb);
		
	end if;
	return js;
end;
$$ language plpgsql;

--///////////////////

create or replace function fn_get_person(id text,id_old text)
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
	(select * from sanctions.person et
		where et.general_id = $1)t;
	js = test_null(js);
		
	if json_array_length(js::json #>'{nationality}')>0 
		then 
			js_country = (select fn_get_country_person($1));
			js = jsonb_set(js::jsonb,'{nationality}',(js_country::json#>'{country}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{associates}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{associates}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_associate_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;
				end loop;
			js = jsonb_set(js::jsonb,'{associates}',(tmp::json#>'{1}')::jsonb);
		
	end if;

	if json_array_length(js::json #>'{associations}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{associations}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_associate_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;
				end loop;
			js = jsonb_set(js::jsonb,'{associations}',(tmp::json#>'{1}')::jsonb);
		
	end if;

	if json_array_length(js::json #>'{familyperson}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{familyperson}')));
			 foreach elem in array arr
				loop
					if $2 != elem then																				
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_family_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																			
					end loop;
			js = jsonb_set(js::jsonb,'{familyperson}',(tmp::json#>'{1}')::jsonb);
																				
	end if;

	if json_array_length(js::json #>'{familyrelative}')>0 
		then 
			tmp  = ('{"1":[]}');
			arr = (select array(select json_array_elements_text
				(js::json #>'{familyrelative}')));
			 foreach elem in array arr
				loop
					if $2 != elem then																				
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_family_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																			
					end loop;
			js = jsonb_set(js::jsonb,'{familyrelative}',(tmp::json#>'{1}')::jsonb);
																				
	end if;
		
	return js;
end;
$$ language plpgsql;

--/////////////////////

create or replace function fn_get_person_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2)::jsonb);
																						
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_legalentity($1,$2)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_person($1,$2)::jsonb);

																							
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--///////////////////////////

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

--//////////////////////////////////

create or replace function fn_get_country_mainCountry(id text)
returns json as
$$

begin
			 		
	return (select row_to_json(ghj) as country from(
	 select array (select sc."label" as country from
					(select general_id,unnest(mainCountry) as country from sanctions.legalentity)st
						join sanctions.country sc on sc.code=st.country
		 					where st.general_id = $1)country)ghj);				
end;
$$ language plpgsql;

--//////////////////

create or replace function fn_get_country_jurisdiction(id text)
returns json as
$$

begin
			 		
	return (select row_to_json(ghj) as country from(
	 select array (select sc."label" as country from
					(select general_id,unnest(jurisdiction) as country from sanctions.legalentity)st
						join sanctions.country sc on sc.code=st.country
		 					where st.general_id = $1)country)ghj);				
end;
$$ language plpgsql;

--///////////////////////

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
	js = test_null(js);
																				
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
				tmp  = ('{"1":[]}');
				arr = (select array(select json_array_elements_text
					(js::json #>'{client}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					raise notice '875 %',tmp;
				else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{client}',(tmp::json#>'{1}')::jsonb);
	end if;
	return js;
end;
$$ language plpgsql;

--////////////

create or replace function fn_get_representation_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_representation($1,$2)::jsonb);
																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--////////////////

create or replace function fn_get_crypto_wallet(id text,id_old text)
returns json as
$$
declare
js json;

arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.crypto_wallet et
		where et.general_id = $1)t;
	js = test_null(js);
																				
		if json_array_length(js::json #>'{holder}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{holder}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{holder}',(tmp::json#>'{1}')::jsonb);
	end if;
		
	return js;
end;
$$ language plpgsql;

--//////

create or replace function fn_get_value(id text)
returns json as
$$
declare
js json;
begin
	
	js = row_to_json(t) from
	(select * from sanctions.value et
		where et.general_id = $1)t;
	js = test_null(js);
								
			
	return js;
end;
$$ language plpgsql;

--///////////////


create or replace function fn_get_interest(id text)
returns json as
$$
declare
js json;
begin
	
	js = row_to_json(t) from
	(select * from sanctions.interest et
		where et.general_id = $1)t;
	js = test_null(js);
								
			
	return js;
end;
$$ language plpgsql;

--////////////

create or replace function fn_get_crypto_wallet_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_value($1)::jsonb);
	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_crypto_wallet($1,$2)::jsonb);

																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--///////////////

create or replace function fn_get_directorships(id text,id_old text)
returns json as
$$
declare
js json;
arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.directorships et
		where et.general_id = $1)t;
	js = test_null(js);
																				
		if json_array_length(js::json #>'{director}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{director}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						raise 'stop director';
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{director}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{organization}')>0 
			then 
				tmp  = ('{"1":[]}');
				arr = (select array(select json_array_elements_text
					(js::json #>'{organization}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						raise 'stop organiz';
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_organization_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{organization}',(tmp::json#>'{1}')::jsonb);
	end if;
	return js;
end;
$$ language plpgsql;

--////////

create or replace function fn_get_directorships_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_interest($1)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_directorships($1,$2)::jsonb);

																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--//////////////

create or replace function fn_get_identification(id text,id_old text)
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
	(select * from sanctions.identification et
		where et.general_id = $1)t;
	js = test_null(js);
			
	if json_array_length(js::json #>'{country}')>0 
		then 
			js_country = (select fn_get_country_identification($1));
			js = jsonb_set(js::jsonb,'{country}',(js_country::json#>'{country}')::jsonb);
	end if;

			if json_array_length(js::json #>'{holder}')>0 
				then 
					
					arr = (select array(select json_array_elements_text
						(js::json #>'{holder}')));
						 foreach elem in array arr
						loop
							if $2 != elem then   
							
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
						else 
							tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
						end if;																											
						
				end loop;
				js = jsonb_set(js::jsonb,'{holder}',(tmp::json#>'{1}')::jsonb);
	end if;
		
	return js;
end;
$$ language plpgsql;
--//////////////////

create or replace function fn_get_country_identification(id text)
returns json as
$$

begin
			 		
	return (select row_to_json(ghj) as country from(
	 select array (select sc."label" as country from
					(select general_id,unnest(country) as country from sanctions.identification)st
						join sanctions.country sc on sc.code=st.country
		 					where st.general_id = $1)country)ghj);				
end;
$$ language plpgsql;

--////////////////////

create or replace function fn_get_identification_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_identification($1,$2)::jsonb);

																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--///////////////////

create or replace function fn_get_membership(id text,id_old text)
returns json as
$$
declare
js json;

arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.membership et
		where et.general_id = $1)t;
	js = test_null(js);
																				
		if json_array_length(js::json #>'{member}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{member}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{member}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{organization}')>0 
			then 
				tmp  = ('{"1":[]}');
				arr = (select array(select json_array_elements_text
					(js::json #>'{organization}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_organization_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{organization}',(tmp::json#>'{1}')::jsonb);
	end if;
	return js;
end;
$$ language plpgsql;
--///////////////////////////////////

create or replace function fn_get_membership_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_interest($1)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_membership($1,$2)::jsonb);

																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;
--///////////////////////////////

create or replace function fn_get_vehicle(id text,id_old text)
returns json as
$$
declare
js json;

arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.vehicle et
		where et.general_id = $1)t;
	js = test_null(js);
																		
		if json_array_length(js::json #>'{operator}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{operator}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{operator}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{owner}')>0 
			then 
				tmp  = ('{"1":[]}');
				arr = (select array(select json_array_elements_text
					(js::json #>'{owner}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{owner}',(tmp::json#>'{1}')::jsonb);
	end if;
	return js;
end;
$$ language plpgsql;
--///////////////////////////////////

create or replace function fn_get_vehicle_head(id text,id_old text)
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
																							
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;
--///////////////////////////////

create or replace function fn_get_asset(id text,id_old text)
returns json as
$$
declare
js json;

arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.asset et
		where et.general_id = $1)t;
	js = test_null(js);
																		
		if json_array_length(js::json #>'{ownershipasset}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{ownershipasset}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_ownership_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{ownershipasset}',(tmp::json#>'{1}')::jsonb);
	end if;
		
	return js;
end;
$$ language plpgsql;
--///////////////////////////////

create or replace function fn_get_ownership(id text,id_old text)
returns json as
$$
declare
js json;
flag text;
arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.ownership et
		where et.general_id = $1)t;
	js = test_null(js);
																		
		if json_array_length(js::json #>'{asset}')>0 
			then 
				flag = 'stop';
				arr = (select array(select json_array_elements_text
					(js::json #>'{asset}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_asset_head(elem,$2,flag)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{asset}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{owner}')>0 
			then 
				tmp  = ('{"1":[]}');
				arr = (select array(select json_array_elements_text
					(js::json #>'{owner}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{owner}',(tmp::json#>'{1}')::jsonb);
	end if;
	return js;
end;
$$ language plpgsql;
--///////////////////////////////////

create or replace function fn_get_ownership_head(id text,id_old text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_interest($1)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_ownership($1,$2)::jsonb);
																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;
--///////////////////////////////////

create or replace function fn_get_asset_head(id text,id_old text)
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
																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;
--///////////////////////////////

create or replace function fn_get_security(id text,id_old text)
returns json as
$$
declare
js json;

arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.security et
		where et.general_id = $1)t;
	js = test_null(js);
																		
		if json_array_length(js::json #>'{issuer}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{issuer}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{issuer}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	return js;
end;
$$ language plpgsql;
--///////////////////////////////////

create or replace function fn_get_security_head(id text,id_old text)
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
	pro = jsonb_insert(pro::jsonb,'{properties,3}',fn_get_security($1,$2)::jsonb);
																							
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;
--/////////////

create or replace function fn_get_country_person(id text)
returns json as
$$

begin
			 		
	return (select row_to_json(ghj) as country from(
	 select array (select sc."label" as country from
					(select general_id,unnest(nationality) as country from sanctions.person)st
						join sanctions.country sc on sc.code=st.country
		 					where st.general_id = $1)country)ghj);				
end;
$$ language plpgsql;

--////////////

create or replace function fn_get_representation_head(id text,id_old text,flag text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_interval($1)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_representation($1,$2,flag)::jsonb);
																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

--///////////////////////

create or replace function fn_get_representation(id text,id_old text,flag text)
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
	(select * from sanctions.representation et
		where et.general_id = $1)t;
	js = test_null(js);
	
		if flag != 'agencyclient' then																	
			if json_array_length(js::json #>'{agent}')>0 
					then 
							
							flag='stop';
							arr = (select array(select json_array_elements_text
							(js::json #>'{agent}')));
							 foreach elem in array arr
							loop
								if $2 != elem then   
								
							tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity_head(elem,$2,flag)::jsonb);
							
							else 
								tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
							end if;																											
							
					end loop;
					js = jsonb_set(js::jsonb,'{agent}',(tmp::json#>'{1}')::jsonb);
			end if;
		end if;
	
			if $3 = 'agencyclient' then
					flag='stop';
									
					if json_array_length(js::json #>'{client}')>0 
							then 
								tmp  = ('{"1":[]}');
								arr = (select array(select json_array_elements_text
									(js::json #>'{client}')));
									 foreach elem in array arr
									loop
										if $2 != elem then   
										
									tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_entity_head(elem,$2,flag)::jsonb);
									raise notice 'elem %',elem;
									raise notice 'tmp %',tmp;
								else 
										tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
									end if;																											
									
							end loop;
							js = jsonb_set(js::jsonb,'{client}',(tmp::json#>'{1}')::jsonb);
					end if;
			end if;	
	return js;
raise '1629';
end;
$$ language plpgsql;

--///////////////////////////

create or replace function fn_get_legalentity_head(id text,id_old text,flag text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2,$3)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_legalentity($1,$2,$3)::jsonb);
																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

create or replace function fn_get_legalentity(id text,id_old text,flag text)
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
	(select * from sanctions.legalentity et
		where et.general_id = $1)t;
																								
	js = test_null(js);
	
	
	
	return js;
end;
$$ language plpgsql;

create or replace function fn_get_thing(id text,id_old text,flag text)
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
	(select * from sanctions.thing et
		where et.general_id = $1)t;
	js = test_null(js);																							



	return js;
end;
$$ language plpgsql;

create or replace function fn_get_asset_head(id text,id_old text,flag text)
returns json as
$$
declare
js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2,flag)::jsonb);
																							
	pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_value($1)::jsonb);

	pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_asset($1,$2,flag)::jsonb);
																								
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);
	
	
	return js;
end;
$$ language plpgsql;

create or replace function fn_get_asset(id text,id_old text,flag text)
returns json as
$$
declare
js json;

arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.asset et
		where et.general_id = $1)t;
		js = test_null(js);																
		
		
	return js;
end;
$$ language plpgsql;

create or replace function test_null(_js json)
returns json as
$$
declare 
arr text array;
js json = _js;
a text;
begin
	
	arr = (select array(select json_object_keys(js) )) ;
	foreach a in array arr
		loop
			if a != any(array[ 'amount',
								'amounteur',
								'amountusd',
								'general_id']) then
				if false = (json_array_length(js::json->a)> 0) then 
				
					js = (js ::jsonb - ('{'||a||'}')::text []);
				else end if;
			end if;
		end loop;
	return js;
end;
$$ language plpgsql;


create or replace function fn_get_entity_head(id text,id_old text,flag text)
returns json as
$$
declare 

js json;
pro json = ('{"properties":[]}');
begin
	js = fn_get_entity($1);

	if (js::json->>'schema') = 'Person' then
																							
		pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2,$3)::jsonb);
																								
		pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_legalentity($1,$2,$3)::jsonb);
	
		pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_person($1,$2,$3)::jsonb);
	
	raise notice 'pro %',pro;
	
	elsif (js::json->>'schema') = 'Organization' then
	
		pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2,$3)::jsonb);
																								
		pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_legalentity($1,$2,$3)::jsonb);
	
		pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_organization($1,$2,$3)::jsonb);
	
	elsif (js::json->>'schema') = 'Company' then
	
		pro = jsonb_insert(pro::jsonb,'{properties,0}',fn_get_thing($1,$2,$3)::jsonb);
																								
		pro = jsonb_insert(pro::jsonb,'{properties,1}',fn_get_legalentity($1,$2,$3)::jsonb);
	
		pro = jsonb_insert(pro::jsonb,'{properties,2}',fn_get_organization($1,$2,$3)::jsonb);
	
		pro = jsonb_insert(pro::jsonb,'{properties,3}',fn_get_value($1)::jsonb);
																								
		pro = jsonb_insert(pro::jsonb,'{properties,4}',fn_get_asset($1,$2,$3)::jsonb);
	
		pro = jsonb_insert(pro::jsonb,'{properties,5}',fn_get_company($1,$2,$3)::jsonb);
	
	
		
	end if;
	js = jsonb_set(js::jsonb,'{properties}',(pro::json #> '{properties}')::jsonb);

	return js;

end;
$$ language plpgsql;

create or replace function fn_get_person(id text,id_old text,flag text)
returns json as
$$
declare
js json;
begin
	
	js = row_to_json(t) from
	(select * from sanctions.person et
		where et.general_id = $1)t;
																								
	js = test_null(js);

return js;
end;
$$ language plpgsql;

create or replace function fn_get_organization(id text,id_old text,flag text)
returns json as
$$
declare
js json;
begin
	
	js = row_to_json(t) from
	(select * from sanctions.organization et
		where et.general_id = $1)t;
																								
	js = test_null(js);

return js;
end;
$$ language plpgsql;

create or replace function fn_get_company(id text,id_old text,flag text)
returns json as
$$
declare
js json;
begin
	
	js = row_to_json(t) from
	(select * from sanctions.company et
		where et.general_id = $1)t;
																								
	js = test_null(js);

return js;
end;
$$ language plpgsql;


















select fn_entity_head('NK-2vVMGmwbuV8cG7hs6gfzEG','NK-2vVMGmwbuV8cG7hs6gfzEG','stop');













create or replace function ff()
returns text as
$$
declare
js json = fn_get_person_head('NK-QthD3sQ5gXpBrH3DXvd58m','NK-QthD3sQ5gXpBrH3DXvd58m');
begin
			 		
	if(json_array_length(js::json #>'{referents}')>0) then return 'true';
	 	
	 end if;
	return 'false';
end;
$$ language plpgsql;

select ff();

select * from sanctions.entities where id = 'NK-CVhKekzCmPUGBKhtLermdJ';
select * from sanctions.legalentity where general_id = 'NK-QthD3sQ5gXpBrH3DXvd58m';
select * from sanctions.representation where general_id = 'ofac-1aaabfcb2cf211ba998d636a2303e15ad091d3da';




select fn_get_person_head('NK-QthD3sQ5gXpBrH3DXvd58m','NK-QthD3sQ5gXpBrH3DXvd58m');

copy(
select fn_get_person_head('NK-QthD3sQ5gXpBrH3DXvd58m','NK-QthD3sQ5gXpBrH3DXvd58m')
	) to 'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\NICOLAU_NEW.json';





select json_strip_nulls(fn_get_person_head('NK-QthD3sQ5gXpBrH3DXvd58m','NK-QthD3sQ5gXpBrH3DXvd58m'));








) to 'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\NK-QthD3sQ5gXpBrH3DXvd58m.json';

select * from sanctions.entities_true
where id = 'NK-cvFkaxVPep3JncUvjeV3FG';

select * except(e.general_id) from sanctions.legalentity e;

where general_id = 'NK-QthD3sQ5gXpBrH3DXvd58m';

'NK-22HtK7WrxZ2sU3rmhz6PuZ'
--create or replace function fn_test2_thing(id text)
--returns json as 
--$$
--declare
--ar text array;
--js json;
--jstmp json;
--begin
--	js = row_to_json(fn_get_entities(1));
--	if 
--		(select array_length(et.referents,1) from sanctions.entities_true et
--			where et.id_int = 1)>0 
--	then jstmp =( select array_to_json(array_agg(row_to_json(t))) from fn_test_get_query() t) y;
--		return jsonb_set(js::jsonb,'{referents}',jstmp::jsonb);
--
--	end if;
--return js;
--end;
--$$ language plpgsql;
--
--select fn_test2_thing('2');

	
--create or replace function fn_test_get_query()
--returns setof sanctions.entities as
--$$
--begin
--	return query
--	with et as
--(select id from sanctions.entities_true 
--	where id_int=1),
--tmp as
--(select unnest(addressentity) as u from sanctions.thing t
--	join et e on e.id = t.general_id)
--		select id_int,caption,datasets,first_seen,id,last_seen,referents,"schema",target from sanctions.entities ee
--			join tmp on tmp.u=ee.id;
--			
--end;
--$$ language plpgsql;

--select row_to_json(fn_test_get_query());
--select array_to_json(array_agg(row_to_json(t))) from fn_test_get_query() t;
--select array_agg(row_to_json(t)) from fn_test_get_query() t;
--
--select array_to_json(array_agg(select id from sanctions.entities_true 
--	where id_int=1));
--
--SELECT array_to_json(array_agg(e), FALSE) AS ok_json FROM sanctions.entities e where e.id_int=1;
--
--select array_agg(caption) from sanctions.entities e;

--create or replace function fn_get_properties()
--returns json as
--$$
--begin
--	
--end;
--$$;
--
--create or replace function fn_t()
--returns json as
--$$
--declare
--j json;
--begin
--	 j =(select row_to_json(t) from (select * from sanctions.thing 
--	 	where general_id = 'eu-fsf-eu-1644-40')t);
--	 return j::json#>'{addressentity}';
--end;
--$$ language plpgsql;
--select fn_t();
--
--create or replace function fn_tt()
--returns json as
--$$
--begin
--return (select row_to_json(t) from (select * from sanctions.entities_true e 
--	where id_int = 21)t);	 	
--end;
--$$ language plpgsql;
--
--	

--select json_array_length ((select row_to_json(t) from (select * from sanctions.entities_true e 
--	where id_int = 21)t)::json #>'{referents}'); 
--select * from sanctions.thing where general_id='eu-fsf-eu-1644-40';
--select row_to_json(public.fn_thing('eu-fsf-eu-1644-40'));
--select * from  public.fn_person('eu-fsf-eu-1644-40');
--
----/////////////////////
--
--drop function fn_get_thing_head(text);

--create or replace function fn_get_thing_head(id text)
--returns json as
--$$
--declare
--js json = fn_get_entity($1);
--pro json;
--begin
--	pro = fn_get_thing($1);
--	js = jsonb_set(js::jsonb,'{properties}',pro::jsonb);
--	return js;
--end;
--$$ language plpgsql;
--drop function fn_get_thing_head(text);
----////////////////////////////////
--	 select fn_get_thing_head('eu-fsf-eu-1644-40');
--select	 jsonb_pretty((select fn_get_thing_head('eu-fsf-eu-1644-40'))::jsonb);
--	
--	drop function fn_get_thing_head(int);
--	 select * from sanctions.thing;
--
--select * from sanctions.entities_true where id = 'eu-fsf-eu-1644-40';

--select fn_get_thing('NK-8A3QP3QJd4t49Dugcek2LX');
--
--select * from sanctions.entities where id in	
--(select unnest(addressentity) from sanctions.thing 
--where general_id = 'eu-fsf-eu-1644-40');
--select * from sanctions.thing where general_id = 'eu-fsf-eu-1644-40';
--	
--	select jsonb_insert('{"a": [0,1,2]}', '{a, 1}', '"new_value"');
--	
--select row_to_json(co) from (select array(select unnest(country)) as country from sanctions.thing
-- where general_id = 'eu-fsf-eu-1644-40')co;
--
--select sc."label" from
--(select general_id,unnest(country) as country from sanctions.thing)st
--	join sanctions.country sc on sc.code=st.country
--		 where st.general_id = 'eu-fsf-eu-1644-40';	
--drop function fn_get_country_thing( text);




--
--select * from sanctions.entities_true where id = 'eu-fsf-eu-1644-40';
--select * from sanctions.sanction where general_id = 'NK-Nnqh4qNjU32XiTWhh6XyxR';
--select fn_get_country_address('addr-0f7ba87c19b87cc02bac862e30c353ba240f6260');



--
--select fn_get_country_thing('NK-8A3QP3QJd4t49Dugcek2LX');
--
--select row_to_json(ghj) as country from(
--	 select array (select sc."label" as country from
--					(select general_id,unnest(country) as country from sanctions.thing)st
--						join sanctions.country sc on sc.code=st.country
--		 					where st.general_id = 'NK-8A3QP3QJd4t49Dugcek2LX')country)ghj;	
--	
--	select array(select unnest(country) from sanctions.thing t
--	where general_id = 'NK-8A3QP3QJd4t49Dugcek2LX')g;
--	
--select * from sanctions.sanction;

--create or replace function fn_get_test_double_insert(id text,id_old text)
--returns json as
--$$
--declare
--js json;
--js_country json;
--arr text array;
--elem text;
--tmp json = ('{"1":[]}');
--begin
--	
--	js = row_to_json(t) from
--	(select * from sanctions.sanction et
--		where et.general_id = $1)t;
--																								
--	if json_array_length(js::json #>'{country}')>0 
--		then 
--			js_country = (select fn_get_country_sanctions($1));
--			js = jsonb_set(js::jsonb,'{country}',(js_country::json#>'{country}')::jsonb);
--	end if;
--	
--	if json_array_length(js::json #>'{entity}')>0 
--		then 
--			
--			arr = (select array(select json_array_elements_text
--				(js::json #>'{entity}')));
--				 foreach elem in array arr
--				loop
--					if $2 != elem then                                                       																				
--				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_thing_head(elem,$2)::jsonb);
--				else tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);																										
--				end if;
--			end loop;
--			js = jsonb_set(js::jsonb,'{entity}',(tmp::json#>'{1}')::jsonb);
--	end if;
--	
--	return js;
--end;
--$$ language plpgsql;
--
--select fn_get_test_double_insert('eu-fsf-88734b4951229bda8d11d077b16851a2f3630ee2','eu-fsf-88734b4951229bda8d11d077b16851a2f3630ee2');
--
--eu-fsf-88734b4951229bda8d11d077b16851a2f3630ee2
--
--eu-fsf-767f1099fec1f44dda54ab82ebfbcebbdf861eb3
--
--(to_json(elem))::jsonb
