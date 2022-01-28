create table sanctions.legalEntity_cryptoWallets
(legalEntity_id varchar,
crypto_wallet_id varchar,
primary key(legalEntity_id,crypto_wallet_id),
foreign key (legalEntity_id) references sanctions.legal_entity(general_id),
foreign key (crypto_wallet_id) references sanctions.crypto_wallet(general_id));