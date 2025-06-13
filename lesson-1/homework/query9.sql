drop table if exists loan;
drop table if exists book;
drop table if exists member;
create table book (
	book_id int primary key,
	title varchar(255) not null,
	author varchar(255),
	published_year int check (published_year >= 0)
);
create table member (
	member_id int primary key, 
	name varchar(255) not null,
	email varchar(255),
	phone_number varchar(20)
);
create table loan (
	loan_id int primary key,
	book_id int,
	member_id int,
	loan_date date not null,
	return_date date,
	constraint fk_book foreign key (book_id) references book (book_id),
	constraint kf_member foreign key (member_id) references member (member_id)
);
insert into book values (1, '1984', 'George Orwell', 1949);
insert into book values (2, 'To Kill a Mockingbird', 'Harper Lee', 1960);
insert into book values (3, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925);
insert into member values (1, 'Alice Johnson', 'alice@example.com', '1234567890');
insert into member values (2, 'Bob Smith', 'bob@example.com', '0987654321');
insert into loan values (1, 1, 1, '2024-06-01', '2024-06-10');  -- Alice borrowed '1984'
insert into loan values (2, 2, 1, '2024-06-11', null);          -- Alice borrowed 'Mockingbird' (not returned)
insert into loan values (3, 1, 2, '2024-06-12', null);   -- Bob borrowed '1984' again later
select * from book, member, loan;