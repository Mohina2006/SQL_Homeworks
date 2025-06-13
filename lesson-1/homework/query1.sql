
drop table if exists student
create table student(
 id int,
 name varchar(max),
 age integer
);
alter table student
alter column id int not null;