

select fn_get_by_id_json(568);

select * from sanctions.entities where id = 'NK-3tCPzE4XpTJF5FmcCQqGMm';

select * from sanctions.vessel where general_id = 'NK-3KadRpv8QzzgiHGqFdda54';

select * from sanctions.entities_true where id = 'NK-aLkCv3cdnDGzsYqiESfZMC';

select * from sanctions.entities_true ;

select * from sanctions.directorships;

copy (

select fn_get_person_head('NK-aLkCv3cdnDGzsYqiESfZMC','NK-aLkCv3cdnDGzsYqiESfZMC')

	) to 'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\person_NK-aLkCv3cdnDGzsYqiESfZMC.json';






select fn_get_person_head('NK-aLkCv3cdnDGzsYqiESfZMC','NK-aLkCv3cdnDGzsYqiESfZMC');

select fn_get_organization_head('NK-3tCPzE4XpTJF5FmcCQqGMm','NK-3tCPzE4XpTJF5FmcCQqGMm');

select fn_get_company_head('NK-5uGUpiQvPfcxJFdV9srsXQ','NK-5uGUpiQvPfcxJFdV9srsXQ');

select fn_get_vessel_head('NK-3KadRpv8QzzgiHGqFdda54','NK-3KadRpv8QzzgiHGqFdda54');

select fn_get_airplane_head('NK-2Dm77ySwRh5BkuNFcKWd47','NK-2Dm77ySwRh5BkuNFcKWd47');

select * from sanctions.directorships where general_id = 'NK-5uGUpiQvPfcxJFdV9srsXQ';

select * from sanctions.entities where id ilike '%q461631';

select * from sanctions.entities where "schema" = 'Airplane';

select * from sanctions.entities where id = 'NK-3KadRpv8QzzgiHGqFdda54';

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
				
			else raise notice 'a %',a;
			end if;
			
		end loop;
	return js;
end;
$$ language plpgsql;

select * from sanctions.value;

select testar(tt.row_to_json) from (select row_to_json(t) from (select * from sanctions.thing where general_id = 'eu-fsf-eu-1644-40')t)tt;
