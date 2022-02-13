select * from sanctions.entities_true;

create or replace function fn_test(id_int int) returns text 
language plpgsql as 
$$
begin
	return (
	select schema
	from sanctions.entities_true et
		where et.id_int = $1);
end;
$$;
drop function fn_test();
select fn_test(3);

create or replace procedure sp_test1(id_int int) as 
$$
begin 
	case (select schema
	from sanctions.entities_true et
		where et.id_int = $1)
		when 'Person' then select * from sanctions.address;
		when 'Company' then call sp_company();
		else call sp_error();
	end case;
end;
$$ language plpgsql;

call sp_test1 (2);

create or replace procedure sp_person() as 
$$
declare r text;
begin 
		r = select row(*) from sanctions.address a ;
end;
$$ language plpgsql;

call sp_person();