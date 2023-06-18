create table category(
	cateId uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
	cateName varchar(100)
)

create table product(
	prodId uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
	name varchar(200),
	category uuid,
	stock int,
	price numeric,
	constraint fk_category foreign key (category) references category(cateId)
)

create table users(
	userId uuid default uuid_generate_v4() PRIMARY KEY,
	userName varchar(200)
)

create table itemproduct(
	cartId uuid default uuid_generate_v4() PRIMARY KEY,
	product uuid,
	qty int,
	subTotal numeric,
	"user" uuid,
	constraint fk_product foreign key (product) references product(prodId),
	constraint fk_user foreign key ("user") references users(userId)
)

create table orders(
	orderId uuid default uuid_generate_v4() PRIMARY KEY,
	orderNo varchar(50) default ord_id(),
	"user" uuid,
	totalPrice numeric,
	status varchar(30),
	constraint fk_user foreign key ("user") references users(userId)
)

create table orderlineitem(
	ordLineId uuid default uuid_generate_v4() PRIMARY KEY,
	product uuid,
	qty int,
	subTotal numeric,
	"order" uuid,
	constraint fk_product foreign key (product) references product(prodId),
	constraint fk_order foreign key ("order") references orders(orderId)
)

CREATE SEQUENCE seq_order
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 

create or replace function ord_id () returns varchar as $$
select CONCAT('PO','-',lpad(''||nextval('seq_order'),4,'0'))
$$ language sql

insert into users (username) values ('aldi09')
insert into users (username) values ('user01')
insert into users (username) values ('user02')

insert into category (catename) values ('keyboard')
insert into category (catename) values ('mouse')
insert into category (catename) values ('earphone')

insert into product ("name", category, stock, price) 
values ('Keychron Q4', 'c3bdf859-bea0-4d9e-a759-6f2f081ccbf4', 30, 1400000)

insert into product ("name", category, stock, price) 
values ('Mouse HP M260', '3f128a20-e364-4f80-bd89-1eeb5c50cd25', 40, 200000)