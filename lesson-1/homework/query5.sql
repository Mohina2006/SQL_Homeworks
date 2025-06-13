drop table if exists account;
create table account(
	account_id int primary key,
	balance decimal(10,2),
	account_type varchar(50),
	constraint check_balance_non_negative check (balance >= 0),
	constraint check_account_type check (account_type in ('Saving', 'Checking'))
);
alter table account
drop constraint check_balance_non_negative;
alter table account
drop constraint check_account_type;
alter table account
add constraint check_balance_non_negative check (balance >= 0);
alter table account
add constraint check_account_type check (account_type in ('Saving', 'Checking'));