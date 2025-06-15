drop table if exists data_types_demo;
create table data_types_demo (
	id tinyint,
	small_value smallint,
	normal_value int,
	big_value bigint,
	price_decimal decimal (10,2),
	price_float float,
	name_char char(10),
	name_varchar varchar(50),
	notes_text nvarchar(max),
	birth_date date,
	exam_time time, 
	full_datetime datetime,
	precise_datetime datetime2,
	guid uniqueidentifier
);
insert into data_types_demo
values (
	10,
	20000,
	100000,
	9876543210,
	123.45,
	123.4567,
	'Jane',
	'Jane Doe',
	N'Example long blog text goes here.',
	'1990-01-01',    
	'14:30:00',
	getdate(),
	sysdatetime(),
	newid()

);

select * from data_types_demo