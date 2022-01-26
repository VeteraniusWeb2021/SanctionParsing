delete from sanctions.entities;

begin;
create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'G:\database\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\modify.json';
	
		insert into sanctions.entities (
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
				array[value->>'datasets'],
				value->>'first_seen',
				value->>'id',
				value->>'last_seen',
				array[value->>'referents'],
				value->>'schema',
				value->>'target'
					from temp_json);
				select * from temp_json;
			select * from sanctions.entities;
		
rollback;