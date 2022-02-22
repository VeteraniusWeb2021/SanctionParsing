

create or replace function sanctions.fn_get_page(quantity_records_by_page int,number_page int)
returns table (
id_int int,
caption text,
datasets text array,
first_seen text,
id text,
last_seen text,
referents text array,
schema text) as
$$
begin
	return query
	select * from sanctions.entities_true e 
	where e.id_int between ((($2-1)*$1)+1)
	and $1*$2;
end;
$$ language plpgsql;





create or replace function sanctions.fn_get_page_json(quantity_records_by_page int,number_page int)
returns json as
$$
declare 
js json;
begin

	js = (select array_to_json(array(
select row_to_json(t) from (select * from sanctions.fn_get_page(50,1)) t
			)));
	
return js;
end;
$$ language plpgsql;















