create table sanctions.crypto_wallet
(general_id text,
balance text array,
balanceDate text array,
creationDate text array,
currencySymbol text array,
holder text array,
mangingExchange text array,
privateKey text array,
publicKey text array,
primary key (general_id),
foreign key (general_id) references sanctions.entities(id)
);

create or replace procedure sanctions.sp_fill_crypto_wallet_with_json(in_json_crypto_wallet json)
language plpgsql as
$$
begin
	insert into sanctions.crypto_wallet
		(select * from json_to_record
	($1) as x
	(general_id text,
	balance text array,
	balanceDate text array,
	creationDate text array,
	currencySymbol text array,
	holder text array,
	mangingExchange text array,
	privateKey text array,
	publicKey text array));
end;
$$;