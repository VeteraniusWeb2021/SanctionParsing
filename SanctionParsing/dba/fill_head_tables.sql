

create or replace procedure sanctions.sp_fill_entities_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\entities.txt';
		insert into sanctions.entities(
				caption ,
				datasets  ,
				first_seen ,
				id ,
				last_seen ,
				referents  ,
				schema ,
				target )
			(select 
				value->>'caption',
				array (select json_array_elements_text (value->'datasets')) as dtsets,
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array (select json_array_elements_text (value->'referents')) as rfs,
				value->>'schema',
				(value->>'target')::boolean
					from temp_json );
end;
$$;

call sanctions.sp_fill_entities_with_json();
