drop table if exists orders;
create table orders (
  order_id int,
  customer_name varchar(255),
  order_date date,
  constraint pk_order_id primary key (order_id)
);
alter table orders
drop constraint pk_order_id;
alter table orders
add constraint pk_order_id primary key (order_id);
