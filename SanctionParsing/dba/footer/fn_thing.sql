create or replace function sanctions.fn_thing(general_id text)
returns table (
address text array,
addressEntity text array,
alias text array,
country text array,
description text array,
keywords text array,
modifiedAt text array,
name text array,
notes text array,
previousName text array,
program text array,
publisher text array,
publisherUrl text array,
retrievedAt text array,
sanctions text array,
sourceUrl text array,
summary text array,
topics text array,
unknownLinkFrom text array,
unknownLinkTo text array,
weakAlias text array,
wikidataId text array,
wikipediaUrl text array) as
$$
begin
	return query
	select 
	t.address,
	t.addressEntity,
	t.alias,
	t.country,
	t.description,
	t.keywords,
	t.modifiedAt,
	t.name,
	t.notes,
	t.previousName,
	t.program,
	t.publisher,
	t.publisherUrl,
	t.retrievedAt,
	t.sanctions,
	t.sourceUrl,
	t.summary,
	t.topics,
	t.unknownLinkFrom,
	t.unknownLinkTo,
	t.weakAlias,
	t.wikidataId,
	t.wikipediaUrl
	from sanctions.thing t
	where t.general_id = $1;
	
end;
$$ language plpgsql;

select * from sanctions.fn_thing('NK-22HtK7WrxZ2sU3rmhz6PuZ');

create or replace function sanctions.fn_test(id_int int)
returns setof  as 
$$
begin
	select * from sanctions.fn_thing;
end;
$$ language plpgsql;

begin;
create table temp (a text,b text array,c text array)
as values('a','{b}','{c}'); 
