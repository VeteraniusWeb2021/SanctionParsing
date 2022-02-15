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
	js = (select row_to_json(t) from (select * from sanctions."interval" e
		where e.general_id = $1)t);
	
--	js = jsonb_set(js::jsonb,'{properties}',tmp::jsonb);
	return js;
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

	if json_array_length(js::json #>'{unknownLinkFrom}')>0 
		then 
			
			arr = (select array(select json_array_elements_text
				(js::json #>'{unknownLinkFrom}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_other_link_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;
				end loop;
			js = jsonb_set(js::jsonb,'{unknownLinkFrom}',(tmp::json#>'{1}')::jsonb);
	end if;
	if json_array_length(js::json #>'{unknownLinkTo}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{unknownLinkTo}')));
			 foreach elem in array arr
				loop
				if $2 != elem then 
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_other_link_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if; 
				end loop;
			js = jsonb_set(js::jsonb,'{unknownLinkTo}',(tmp::json#>'{1}')::jsonb);
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
																						
	if (json_array_length(js::json #>'{agencyClient}'))>0 
		then 
		
			arr = (select array(select json_array_elements_text
				(js::json #>'{agencyClient}')));
			
			 foreach elem in array arr
			 																							
				loop									
					if $2 != elem then																				
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_representation_head(elem,$2)::jsonb);
																														
																													
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																			
				end loop;
			
			js = jsonb_set(js::jsonb,'{agencyClient}',(tmp::json#>'{1}')::jsonb);
																				
	end if;
				
																						
	if json_array_length(js::json #>'{agentRepresentation}')>0 
																											
		then
			
			arr = (select array(select json_array_elements_text
				(js::json #>'{agentRepresentation}')));
			foreach elem in array arr 
			loop
				if $2 != elem then
					tmp= jsonb_insert(tmp::jsonb,'{1,0}',fn_get_representation_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;																							
				end loop;
					
			js = jsonb_set(js::jsonb,'{agentRepresentation}',(tmp::json#>'{1}')::jsonb);
		
	end if;
	
	if json_array_length(js::json #>'{jurisdiction}')>0 
		then 
			js_country = (select fn_get_country_jurisdiction($1));
			js = jsonb_set(js::jsonb,'{jurisdiction}',(js_country::json#>'{country}')::jsonb);
	end if;

	if json_array_length(js::json #>'{mainCountry}')>0 
		then 
			js_country = (select fn_get_country_mainCountry($1));
			js = jsonb_set(js::jsonb,'{mainCountry}',(js_country::json#>'{country}')::jsonb);
	end if;

	if json_array_length(js::json #>'{cryptoWallets}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{cryptoWallets}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_crypto_wallet_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{cryptoWallets}',(tmp::json#>'{1}')::jsonb);
	end if;
	if json_array_length(js::json #>'{directorshipDirector}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{directorshipDirector}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_directorships_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{directorshipDirector}',(tmp::json#>'{1}')::jsonb);
	end if;
		
	if json_array_length(js::json #>'{identificiation}')>0 
		then 
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

	if json_array_length(js::json #>'{membershipMember}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{membershipMember}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_membership_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{membershipMember}',(tmp::json#>'{1}')::jsonb);
	end if;

	if json_array_length(js::json #>'{operatedVehicles}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{operatedVehicles}')));
			 foreach elem in array arr
				loop
					if $2 != elem then																				
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_vehicle_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;																				
				end loop;
			js = jsonb_set(js::jsonb,'{operatedVehicles}',(tmp::json#>'{1}')::jsonb);
																			
	end if;
																						
	if json_array_length(js::json #>'{ownedVehicles}')>0 
																											
		then
				arr = (select array(select json_array_elements_text
				(js::json #>'{ownedVehicles}')));
			foreach elem in array arr 
			loop
				if $2 != elem then
					tmp= jsonb_insert(tmp::jsonb,'{1,0}',fn_get_vehicle_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;																							
				end loop;
					
			js = jsonb_set(js::jsonb,'{ownedVehicles}',(tmp::json#>'{1}')::jsonb);
		
	end if;

	if json_array_length(js::json #>'{ownershipOwner}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{ownershipOwner}')));
			 foreach elem in array arr
				loop
				if $2 != elem then
				tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_ownership_head(elem,$2)::jsonb);
				else 
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
				end if;	
				end loop;
			js = jsonb_set(js::jsonb,'{ownershipOwner}',(tmp::json#>'{1}')::jsonb);
	end if;
	if json_array_length(js::json #>'{parent}')>0 
		then 
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

	if json_array_length(js::json #>'{familyPerson}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{familyPerson}')));
			 foreach elem in array arr
				loop
					if $2 != elem then																				
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_family_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																			
					end loop;
			js = jsonb_set(js::jsonb,'{familyPerson}',(tmp::json#>'{1}')::jsonb);
																				
	end if;

	if json_array_length(js::json #>'{familyRelative}')>0 
		then 
			arr = (select array(select json_array_elements_text
				(js::json #>'{familyRelative}')));
			 foreach elem in array arr
				loop
					if $2 != elem then																				
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_family_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																			
					end loop;
			js = jsonb_set(js::jsonb,'{familyRelative}',(tmp::json#>'{1}')::jsonb);
																				
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
																				
		if json_array_length(js::json #>'{director}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{director}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_legalentity_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{director}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{organization}')>0 
			then 
				
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
																		
		if json_array_length(js::json #>'{ownershipAsset}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{ownershipAsset}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_ownership_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{ownershipAsset}',(tmp::json#>'{1}')::jsonb);
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

arr text array;
elem text;
tmp json = ('{"1":[]}');
begin
	
	js = row_to_json(t) from
	(select * from sanctions.ownership et
		where et.general_id = $1)t;
																		
		if json_array_length(js::json #>'{asset}')>0 
			then 
				
				arr = (select array(select json_array_elements_text
					(js::json #>'{asset}')));
					 foreach elem in array arr
					loop
						if $2 != elem then   
						
					tmp = jsonb_insert(tmp::jsonb,'{1,0}',fn_get_asset_head(elem,$2)::jsonb);
					else 
						tmp = jsonb_insert(tmp::jsonb,'{1,0}',(to_json(elem))::jsonb);
					end if;																											
					
			end loop;
			js = jsonb_set(js::jsonb,'{asset}',(tmp::json#>'{1}')::jsonb);
	end if;
	
	if json_array_length(js::json #>'{owner}')>0 
			then 
				
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

select fn_get_person_head('NK-cvFkaxVPep3JncUvjeV3FG','NK-cvFkaxVPep3JncUvjeV3FG');














) to 'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\NK-QthD3sQ5gXpBrH3DXvd58m.json';

select * from sanctions.entities_true
where id = 'NK-cvFkaxVPep3JncUvjeV3FG';

select * from sanctions.legalentity;

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
