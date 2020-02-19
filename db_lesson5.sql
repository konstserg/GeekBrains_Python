-- Урок 5. Видеоурок. Операторы, фильтрация, сортировка и ограничение. Агрегация данных
-- ДЗ

DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;


-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”

/* 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их
текущими датой и временем.
*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT now(),
  updated_at DATETIME DEFAULT now() ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

/* 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы
типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10".
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at varchar(255),
  updated_at varchar(255)
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '18.02.2020 19:05', '18.02.2020 19:05'),
  ('Наталья', '1984-11-12', '17.02.2020 19:05', '17.02.2020 19:05'),
  ('Александр', '1985-05-20', '16.02.2020 19:05', '16.02.2020 19:05'),
  ('Сергей', '1988-08-14', '15.02.2020 19:05', '15.02.2020 19:05');
 
-- select created_at from users;

-- преобразуем к календарному значению
-- select STR_TO_DATE(created_at, '%d.%m.%Y %k:%i') from users;

update users 
set 
	created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i')
;

-- describe users;

-- исправим тип данных на date для created_at и updated_at

alter table users 
change
	created_at created_at datetime default current_timestamp
;

alter table users 
change
	updated_at updated_at datetime default current_timestamp
;

/* 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые
разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке
увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех
записей.
*/

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

insert into storehouses_products (storehouse_id, product_id, value)
values
	(1, 200, 0),
	(1, 3250, 236),
	(1, 8552, 0),
	(1, 2235, 1235),
	(1, 556, 14);
	
-- select * from storehouses_products order by value desc; товары с нулем в конце, но сортировка от большего к меньшему, а нужно от меньшего к большему

-- select id, value, if(value > 0, 0, 1) as sort from storehouses_products order by value; -- нулевые значения помечаем 1, все остальные значения 0

select * from storehouses_products order by if(value > 0, 0, 1), value;

/* 4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и
мае. Месяцы заданы в виде списка английских названий ('may', 'august')
*/

-- select name, birthday_at as birthday from users where month(birthday_at) IN (08, 05);

-- изменим формат 18.02.2020 на название месяца вида 'may'
select name, date_format(birthday_at, '%M') as birthday from users
where month(birthday_at) IN (08, 05);

/* 5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM
catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
*/

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
 
-- select * from catalogs where id in (5, 1, 2);

-- select field (2, 5, 1, 2);
-- функция FIELD возвращает позицию значения в списке значений (val1, val2, val3, …)

-- select id, name, field (id, 5, 1, 2) as position from catalogs WHERE id IN (5, 1, 2);


 select * from catalogs WHERE id IN (5, 1, 2) order by field (id, 5, 1, 2);


-- Практическое задание теме “Агрегация данных”

/*1. Подсчитайте средний возраст пользователей в таблице users
*/
 
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT now(),
  updated_at DATETIME DEFAULT now() ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
 select 
 	avg (timestampdiff(year, birthday_at, now())) as age
 from 
	users;

/* 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/

/*select name, birthday_at from users;
select 
	month (birthday_at), 
	day(birthday_at) 
from 
	users;

select 
	year(now()),
	month (birthday_at), 
	day(birthday_at) 
from 
	users;


select concat_ws(
	'-',
	year(now()),
	month (birthday_at), 
	day(birthday_at))
from 
	users;

select date (concat_ws(
	'-',
	year(now()),
	month (birthday_at), 
	day(birthday_at)))
from 
	users;

select date_format(date(concat_ws(
	'-',
	year(now()),
	month (birthday_at), 
	day(birthday_at))),
	'%W')
from 
	users;

select date_format(date(concat_ws(
	'-',
	year(now()),
	month (birthday_at), 
	day(birthday_at))),
	'%W') as day
from 
	users
group by
	day;

select date_format(date(concat_ws(
	'-',
	year(now()),
	month (birthday_at), 
	day(birthday_at))),
	'%W') as day,
count(*) as total
from 
	users
group by
	day;
*/

select date_format(date(concat_ws(
	'-',
	year(now()),
	month (birthday_at), 
	day(birthday_at))),
	'%W') as `day`,
count(*) as total
from 
	users
group by
	`day`
order by 
	total desc;

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

