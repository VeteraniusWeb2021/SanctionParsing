select * from sanctions.entities e 
join sanctions.thing t on t.general_id = e.id
join sanctions.legalentity le on e.id = le.general_id
join sanctions.person p on p.general_id=e.id 
where e.id = 'NK-QthD3sQ5gXpBrH3DXvd58m';

select * from sanctions.address 
where general_id = 'addr-20e2840d60856294b8a5d1ce298691dabde77048';

create table fooo(aaAA text);
select * from fooo;

select * from sanctions.entities where id = 'NK-3BVtJzAjEC2abSYriTd2Xg';

copy (

select fn_get_organization_head('Q461631','Q461631')

	) to 'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\new_Q461631.json';


select row_to_json(le) from sanctions.legalentity le where general_id = 'NK-QthD3sQ5gXpBrH3DXvd58m';

select fn_get_person_head('eu-fsf-eu-2409-29','eu-fsf-eu-2409-29');

select fn_get_organization_head('Q461631','Q461631');

select fn_get_company_head('NK-2jgGmJaCam25UVaLGFrL4y','NK-2jgGmJaCam25UVaLGFrL4y');

select * from sanctions.directorships where general_id = 'ofac-ae9b8e62f30f76b0830042e346d309092b0ca111';

select * from sanctions.entities where id ilike '%q461631';

select * from sanctions.entities where "schema" = 'Company';

create or replace function test_null(_js json)
returns json as
$$
declare 
arr text array;
js json = _js;
a text;
value_array text array = array['general_id','amount','amounteur','amountusd'];
begin
	
	arr = (select array(select json_object_keys(js) )) ;
	foreach a in array arr
		loop
			if false =(a = any(value_array)) then 
				if
				 false = (json_array_length(js::json->a)> 0) then 
					
						js = (js ::jsonb - ('{'||a||'}')::text []);
					
				end if;
			
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


create or replace function testar (_js json)
returns json as 
$$
declare
js json = _js;
arr text array;
value_array text array; 
a text;
begin
	value_array = array['general_id','amount','amounteur','amountusd'];
	arr = (select array(select json_object_keys(js) )) ;
	js = _js;
	foreach a in array arr
		loop
			if a != any(value_array) then
				raise notice 'a %',a;
				raise 'stop';
			else raise notice 'a %',a;
			end if;
			
		end loop;
	return js;
end;
$$ language plpgsql;

select * from sanctions.value;

select testar(tt.row_to_json) from (select row_to_json(t) from (select * from sanctions.thing where general_id = 'eu-fsf-eu-1644-40')t)tt;
