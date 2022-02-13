create or replace function fn_delete_all_data_from_tables()
returns void as
$$
begin
	truncate table sanctions.entities cascade;
end;
$$ language plpgsql;
