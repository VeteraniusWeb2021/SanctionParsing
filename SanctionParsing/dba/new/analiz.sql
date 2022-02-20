select * from sanctions.entities e 
join sanctions.thing t on t.general_id = e.id
join sanctions.legalentity le on e.id = le.general_id
join sanctions.person p on p.general_id=e.id 
where e.id = 'NK-QthD3sQ5gXpBrH3DXvd58m';

select * from sanctions.address 
where general_id = 'addr-20e2840d60856294b8a5d1ce298691dabde77048';

create table fooo(aaAA text);
select * from fooo;

select fn_get_person_head('NK-QthD3sQ5gXpBrH3DXvd58m','NK-QthD3sQ5gXpBrH3DXvd58m');



select row_to_json(le) from sanctions.legalentity le where general_id = 'NK-QthD3sQ5gXpBrH3DXvd58m';



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
			if (a != 'general_id' and a!='amount' and  a!='amounteur' and a!='amountusd')
			
				then
					if false = (json_array_length(js::json->a)> 0) then 
					
						js = (js ::jsonb - ('{'||a||'}')::text []);
				else end if;
			end if;
		end loop;
	return js;
end;
$$ language plpgsql;

create or replace function fff()
returns json as 
$$
declare
js json = (select row_to_json(t) from (select * from sanctions.thing where general_id = 'eu-fsf-eu-1644-40')t);
begin
	
return  test_null(js);
end;
$$ language plpgsql;

select fff();

select test_null();


select array['s','f'];

select row_to_json(t) from (select * from sanctions.thing where general_id = 'eu-fsf-eu-1644-40')t;

select array(select json_object_keys(row_to_json(le)) as js from sanctions.legalentity le where general_id = 'NK-QthD3sQ5gXpBrH3DXvd58m')  ;

