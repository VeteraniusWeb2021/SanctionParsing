drop table foo cascade;
drop table bar;
create table foo (id int,t text);
insert into foo values(1,'t'),(2,'h');
insert into foo select 30,'g';
alter table foo 
add primary key (t);

create table bar (id int,t text,foreign key (t) references foo(t),primary key (id,t));
insert into bar values (2,'t'),(2,'a') on conflict on constraint bar_t_fkey do update set t='h' where excluded.t='a';
create table bar (id int,t text);insert into bar select 2,'h';insert into bar select 2,'h';
create table enti (id int,tex text);insert into enti select 2,'22';insert into enti select 3,'33';

on conflict on constraint bar_t_fkey do nothing ;

on conflict on constraint bar_pkey do nothing;
select * from bar;
on conflict (t) do nothing;

on constraint bar_t_fkey do update set id=1,t = 'h';

--/////////////////////////////////////////////////////////

select * from foo;
select * from enti;
create or replace function fn_foo(id int)
returns setof foo  as
$$
declare r foo%rowtype;
begin
	for r in
		select * from foo
	loop
		update foo set t=t||'null' where r.id = $1 ;
	return nextr;
	end loop;
	return;
end;
$$ language plpgsql;

select fn_foo(2);

