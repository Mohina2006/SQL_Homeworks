drop table if exists books
create table books (
    book_id int identity(1,1) primary key,
    title varchar(255) not null check (len(title) > 0),
    price decimal(10,2) check (price > 0),
    genre varchar(100) default 'Unknown'
);
insert into books (title, price, genre) values ('The AI Era', 25.99, 'Tech');
insert into books (title, price) values ('Mystery of Mind', 15.50);  
select * from books;
--insert into books (title, price) values ('', 20.00); fails
--insert into books (title, price) values ('Free Book', 0); fails
--insert into books (price) values (19.99); fails