create or replace function sanctions.fn_delete_all_data_from_tables()
returns void as
$$
begin
	truncate table sanctions.entities cascade;
end;
$$ language plpgsql;
