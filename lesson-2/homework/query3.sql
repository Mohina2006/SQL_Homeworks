drop table if exists photos;
create table photos (
	id int identity(1,1),
	image_data varbinary(max)
);
insert into photos (image_data)
select * from openrowset(bulk 'C:\Users\user\Downloads\51AYOrWcVxL._UF1000,1000_QL80_.jpg', single_blob) as image;
select * from photos
