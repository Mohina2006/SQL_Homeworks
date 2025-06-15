drop table if exists test_identity;
create table test_identity (
	id int identity(1,1),
	name varchar(50)
);
insert into test_identity (name)
values ('Alice'), ('Bob'), ('Charlie'), ('David'), ('Eve');
select * from test_identity
delete from test_identity where id = 4
insert into test_identity (name) values ('Frank');
select * from test_identity
truncate table test_identity
insert into test_identity (name) values ('Grace');
select * from test_identity
drop table test_identity
