-- Урок 7. Видеоурок. Сложные запросы
-- Дз

use shop;
-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select id, name, birthday_at from users;

-- select * from orders; таблица пустая
-- select * from orders_products; таблица пустая

insert into orders (user_id) -- заполнение табл. orderss 
select id from users where name = 'Геннадий';

insert into orders_products (order_id, product_id, total) -- заполнение табл. orders_products 
select last_insert_id(), id, 2 from products 
where name = 'Intel Core i5-7400'; -- last_insert_id() возвращает посл id в таблице

insert into orders (user_id)
select id from users where name = 'Hаталья';

insert into orders_products (order_id, product_id, total)
select last_insert_id(), id, 1 from products 
where name in ('Intel Core i5-7400', 'Gigabyte H310M S2H');

insert into orders (user_id)
select id from users where name = 'Иван';

insert into orders_products (order_id, product_id, total)
select last_insert_id(), id, 1 from products 
where name in ('AMD FX-8320', 'ASUS ROG MAXIMUS X HERO');

select distinct user_id from orders;


select id, name, birthday_at
from users
where 
id in (select distinct user_id from orders);

-- используя join 

select
	u.id, u.name, u.birthday_at
from 
	users as u
join
	orders as o
on
	u.id = o.user_id;
	

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

select id, name, price, catalog_id from products;
select * from catalogs;

-- нужно объеденить обе таблицы
-- воспользуемся вложенным запросом

select 
	id, name, price, (select name from catalogs where id = products.catalog_id) 
from 
	products;
	
-- получился коррелированный запрос. 
-- использум join 

select
	p.id, p.name, p.price, c.name as `catalog`
from 
	products as p
left join -- так как нужны все записи из таблицы products
	catalogs as c
on
	p.catalog_id = c.id;

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

drop table if exists flights;

create table flights (
	id serial primary key,
	`from` varchar(255) comment 'Город отправления',
	`to` varchar(255) comment 'Город прибытия'
	) comment = 'Рейсы';

insert into flights (`from`, `to`) values
	('moskow', 'omsk'),
	('novgorod', 'kasan'),
	('irkutsk', 'moskow'),
	('omsk', 'irkutsk'),
	('moskow', 'kasan');

drop table if exists cities;
create table cities (
	id serial primary key,
	`label` varchar(255) comment 'код города',
	`name` varchar(255) comment 'название города'
	) comment = 'словарь городов';

insert into cities (label, `name`) values
	('moskow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kasan', 'Казань'),
	('omsk', 'Омск');

-- select * from flights; 
-- select * from cities;

select 
	id, 
	`from`, 
	`to` 
from 
	flights;

-- выведем, заменяя eng названия на ru
select
	id,
	(select name from cities where label = flights.`from`) as `from`,
	(select name from cities where label = flights.`to`) `to`
from
flights;

-- тоже самое используя join 
select
	f.id,
	cities_from.name as `from`,
	cities_to.name as `to`
from
	flights as f
left join
	cities as cities_from
on
	f.`from` = cities_from.label
left join
	cities as cities_to
on
	f.`to` = cities_to.label;







