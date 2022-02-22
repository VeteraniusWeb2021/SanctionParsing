

create or replace function fn_get_page(quantity_records_by_page int,number_page int)
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
declare
q int = $1;
n int =$2;
low int;
high int;
cnt int;
begin
	low = (($2-1)*$1)+1;
	high = $1*$2;
	cnt = (select count(*) from sanctions.entities_true);
	if high>cnt then 
		high = cnt;
		low = cnt - q +1;
	end if;
	return query
	select * from sanctions.entities_true e 
	where e.id_int between low
	and high;
end;
$$ language plpgsql;





create or replace function fn_get_page_json(quantity_records_by_page int,number_page int)
returns json as
$$
declare 
js json;
q int = $1;
n int =$2;
low int;
high int;
cnt int;
begin
	
	low = (($2-1)*$1)+1;
	high = $1*$2;
	cnt = (select count(*) from sanctions.entities_true);
	if high>cnt then 
		n=cnt/q +1;
		raise notice 'n %',n;
	end if;
	js = (select array_to_json(array(
		select row_to_json(t) from (select * from sanctions.fn_get_page($1,n)) t
			)));
	
return js;
end;
$$ language plpgsql;















