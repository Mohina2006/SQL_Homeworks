drop table if exists customer;
create table customer(
	customer_id int primary key,
	name varchar(255),
	city varchar(255) constraint default_city default 'Unknown'
);
alter table customer
drop constraint default_city;
alter table customer
add constraint default_city default 'Unknown' for city;