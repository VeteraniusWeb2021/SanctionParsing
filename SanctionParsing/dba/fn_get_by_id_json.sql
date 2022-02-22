--
--with t as
--(select * from  fn_get(10060))
--
--select json_build_array(fn_get(10060));
--
--create or replace function fn_get(id_int int)
--returns table entities_true as
--$$
--begin
--	return query
--	(select * from sanctions.entities_true et
--		where et.id_int=$1);
--end;
--$$ language plpgsql;



--
--select id from  fn_get(1);
--
--create or replace function fn_person(id text)
--returns text as
--$$
--begin
--	return 
--	(select row(et.*) from sanctions.entities_true et
--		where et.id = $1);
--end;
--$$ language plpgsql;
--
--select row(fn_person('NK-22HtK7WrxZ2sU3rmhz6PuZ'));
--
--fn_thing('NK-22HtK7WrxZ2sU3rmhz6PuZ'));
----
--
--create or replace function fn_get_by_id(id_int int)
--returns text as
--$$
--declare
--s text = (select schema from fn_get_entities($1));
--id text = (select id from fn_get_entities($1));
--begin
--		case (s)
--		when 'Person' then return (select fn_person(id));
--		end case;
--	
--end;
--$$ language plpgsql;
----/////////////////////////////
--
--
----/////////////////////////////////


--create or replace function fn_get_json_test(id_int int)
--returns  json as
--$$
--declare
--myrow sanctions.entities%ROWTYPE;
--begin
--	return 
--	row_to_json(fn_get_entities(1));
--end;
--$$ language plpgsql;
--
--
----				
--select  json_build_object(row(fn_get(10060)), row(fn_get(2)));
--select row_to_json(fn_get_entities(1));

--////////////////////

create or replace function fn_get_entities(id_int int)
returns setof sanctions.entities_true as
$$
begin
	return query
	(select * from sanctions.entities_true et
		where et.id_int=$1);
end;
$$ language plpgsql;
--/////////////////////////
--///////////////////////////////
--////////////////////////////////////
create or replace function fn_get_by_id_json(id_int int)
returns json as
$$
declare
s text = (select schema from fn_get_entities($1));
id text = (select id from fn_get_entities($1));
begin
	
		case s
		when 'Person' then return fn_get_person_head(id,id);
			
		when 'Company' then return 
			json_build_array
				(row_to_json(fn_get_entities($1)),
				 row_to_json(fn_get_thing(id)),
				 row_to_json(fn_get_value(id)),
				 row_to_json(fn_get_asset(id)),
				 row_to_json(fn_get_legalentity(id)),
				 row_to_json(fn_get_organization(id)),
				 row_to_json(fn_get_company(id))
				 );
		when 'Vessel' then return 
			json_build_array
				(row_to_json(fn_get_entities($1)),
		 		 row_to_json(fn_get_thing(id)),
		 		 row_to_json(fn_get_value(id)),
				 row_to_json(fn_get_asset(id)),
				 row_to_json(fn_get_vehicle(id)),
				 row_to_json(fn_get_vessel(id))
				 );
		when 'Airplane' then return 
			json_build_array
				(row_to_json(fn_get_entities($1)),
				 row_to_json(fn_get_thing(id)),
				 row_to_json(fn_get_value(id)),
				 row_to_json(fn_get_asset(id)),
				 row_to_json(fn_get_vehicle(id)),
				 row_to_json(fn_get_airplane(id))
				 );
		when 'Organization' then return fn_get_organization_head(id,id);
				
		end case;
	
end;
$$ language plpgsql;


--///////////////////
select fn_get_entities(1);
copy (
select fn_get_by_id_json(263)
	) to 'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\NK-3BVtJzAjEC2abSYriTd2Xg.json';

select * from sanctions.entities_true where id = 'NK-3Gp49m7nmeMoKXry4TkNcq';


--create or replace function fn_get_thing(id text)
--returns setof sanctions.thing as
--$$
--begin
--	return query
--	(select * from sanctions.thing et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
--
----/////////////////////////////////////////////////
--create or replace function fn_get_person(id text)
--returns setof sanctions.person as
--$$
--begin
--	return query
--	(select * from sanctions.person et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_legalentity(id text)
--returns setof sanctions.legalentity as
--$$
--begin
--	return query
--	(select * from sanctions.legalentity et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_address(id text)
--returns setof sanctions.address as
--$$
--begin
--	return query
--	(select * from sanctions.address et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_interval(id text)
--returns setof sanctions.interval as
--$$
--begin
--	return query
--	(select * from sanctions.interval et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_value(id text)
--returns setof sanctions.value as
--$$
--begin
--	return query
--	(select * from sanctions.value et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
--				--/////////////////////////////////////////////////
--create or replace function fn_get_asset(id text)
--returns setof sanctions.asset as
--$$
--begin
--	return query
--	(select * from sanctions.asset et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_vehicle(id text)
--returns setof sanctions.vehicle as
--$$
--begin
--	return query
--	(select * from sanctions.vehicle et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_airplane(id text)
--returns setof sanctions.airplane as
--$$
--begin
--	return query
--	(select * from sanctions.airplane et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_associate(id text)
--returns setof sanctions.associate as
--$$
--begin
--	return query
--	(select * from sanctions.associate et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_company(id text)
--returns setof sanctions.company as
--$$
--begin
--	return query
--	(select * from sanctions.company et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_organization(id text)
--returns setof sanctions.organization as
--$$
--begin
--	return query
--	(select * from sanctions.organization et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_crypto_wallet(id text)
--returns setof sanctions.crypto_wallet as
--$$
--begin
--	return query
--	(select * from sanctions.crypto_wallet et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_directorships(id text)
--returns setof sanctions.directorships as
--$$
--begin
--	return query
--	(select * from sanctions.directorships et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_interest(id text)
--returns setof sanctions.interest as
--$$
--begin
--	return query
--	(select * from sanctions.interest et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_family(id text)
--returns setof sanctions.family as
--$$
--begin
--	return query
--	(select * from sanctions.family et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_identification(id text)
--returns setof sanctions.identification as
--$$
--begin
--	return query
--	(select * from sanctions.identification et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_membership(id text)
--returns setof sanctions.membership as
--$$
--begin
--	return query
--	(select * from sanctions.membership et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_ownership(id text)
--returns setof sanctions.ownership as
--$$
--begin
--	return query
--	(select * from sanctions.ownership et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_passport(id text)
--returns setof sanctions.passport as
--$$
--begin
--	return query
--	(select * from sanctions.passport et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_representation(id text)
--returns setof sanctions.representation as
--$$
--begin
--	return query
--	(select * from sanctions.representation et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_sanction(id text)
--returns setof sanctions.sanction as
--$$
--begin
--	return query
--	(select * from sanctions.sanction et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_security(id text)
--returns setof sanctions.security as
--$$
--begin
--	return query
--	(select * from sanctions.security et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_other_link(id text)
--returns setof sanctions.other_link as
--$$
--begin
--	return query
--	(select * from sanctions.other_link et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_vessel(id text)
--returns setof sanctions.vessel as
--$$
--begin
--	return query
--	(select * from sanctions.vessel et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_publicBody(id text)
--returns setof sanctions.publicBody as
--$$
--begin
--	return query
--	(select * from sanctions.publicBody et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;
----/////////////////////////////////////////////////
--create or replace function fn_get_publicBody(id text)
--returns setof sanctions.publicBody as
--$$
--begin
--	return query
--	(select * from sanctions.publicBody et
--		where et.general_id = $1);
--end;
--$$ language plpgsql;


















