

create or replace procedure sanctions.sp_fill_entities_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\entities_test.txt';
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
--/////////////////////////////////////////////////////////////////////
create or replace procedure sanctions.sp_fill_thing_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\thing_test.txt';
		insert into sanctions.thing(
				general_id ,
				address,
				addressEntity,
				alias,
				country,
				description,
				keywords,
				modifiedAt,
				name,
				notes,
				previousName,
				program,
				publisher,
				publisherUrl,
				retrievedAt,
				sanctions,
				sourceUrl,
				summary,
				topics,
				unknownLinkFrom,
				unknownLinkTo,
				weakAlias,
				wikidataId,
				wikipediaUrl)
			(select 
				value->>'general_id',
				array (select json_array_elements_text (value->'address')) as ad,
				array (select json_array_elements_text (value->'addressEntity')) as addr,
				array (select json_array_elements_text (value->'alias')) as al,
				array (select json_array_elements_text (value->'country')) as cc,
				array (select json_array_elements_text (value->'description')) as der,
				array (select json_array_elements_text (value->'keywords')) as ke,
				array (select json_array_elements_text (value->'modifiedAt')) as mod,
				array (select json_array_elements_text (value->'name')) as n,
				array (select json_array_elements_text (value->'notes')) as noyt,
				array (select json_array_elements_text (value->'previousName')) as ptre,
				array (select json_array_elements_text (value->'program')) as pr,
				array (select json_array_elements_text (value->'publisher')) as pum,
				array (select json_array_elements_text (value->'publisherUrl')) as gf,
				array (select json_array_elements_text (value->'retrievedAt')) as yt,
				array (select json_array_elements_text (value->'sanctions')) as yy,
				array (select json_array_elements_text (value->'sourceUrl')) as we,
				array (select json_array_elements_text (value->'summary')) as gh,
				array (select json_array_elements_text (value->'topics')) as yui,
				array (select json_array_elements_text (value->'unknownLinkFrom')) as wer,
				array (select json_array_elements_text (value->'unknownLinkTo')) as rew,
				array (select json_array_elements_text (value->'weakAlias')) as ty,
				array (select json_array_elements_text (value->'wikidataId')) as nm,
				array (select json_array_elements_text (value->'wikipediaUrl')) as fds
					from temp_json );
end;
$$;

call sanctions.sp_fill_thing_with_json();
select * from sanctions.entities e ;
delete from sanctions.entities ;
delete from sanctions.thing ;
select * from sanctions.thing t ;


