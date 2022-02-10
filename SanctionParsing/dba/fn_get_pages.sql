create or replace function sanctions.fn_get_page(quantity_records_by_page int,number_page int)
returns table (
id_int int,
caption text,
datasets text array,
first_seen text,
id text,
last_seen text,
referents text array,
schema text,
target boolean) as
$$
begin
	return query
	select * from sanctions.entities e 
	where e.id_int between ((($2-1)*$1)+1)
	and $1*$2;
end;
$$ language plpgsql;

--select * from sanctions.fn_get_page(50,2);