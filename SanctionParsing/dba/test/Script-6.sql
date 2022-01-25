call sanctions.sp_fill_entities_with_json();
select * from sanctions.entities e ;

delete from sanctions.entities ;

		create table  temp_json (value text);
		copy temp_json from 'D:\Downloads\veteranius\Entities.json';
	select * from temp_json; 
		drop table temp_json;
		
	BEGIN;
-- let's create a temp table to bulk data into
create temporary table temp_json (values text) on commit drop;
copy temp_json from program 'sed ''s/\\/\\\\/g'' <D:\Downloads\veteranius\test_csv.csv'>;

-- uncomment the line above to insert records into your table
-- insert into tbl_staging_eventlog1 ("EId", "Category", "Mac", "Path", "ID") 


COMMIT;
rollback;
--!!!!!!!!!!!!!!!

delete from sanctions.entities ;
create or replace procedure sanctions.sp_fill_entities_with_json()
language plpgsql as
$$
begin
		create temporary table  temp_json (value json) on commit drop;
		copy temp_json from 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\Entities.json';
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
						array[value->>'datasets'],
						value->>'first_seen',
						value->>'id',
						value->>'last_seen',
						array[value->>'referents'],
						value->>'schema',
						value->>'target'
							from temp_json);
end;
$$;
call sanctions.sp_fill_entities_with_json();
