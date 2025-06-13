drop table if exists product;

create table product (
    product_id int,
    product_name varchar(255),
    price decimal(10,2),
    constraint uq_product_id unique (product_id)
);

alter table product
drop constraint uq_product_id;

alter table product
add constraint uq_product_id_name unique (product_id, product_name);
