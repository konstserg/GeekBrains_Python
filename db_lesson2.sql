/* Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
  
Создал файл my.ini в корневой папке C:\ с содержанием:
[mysql]
user=root
password=password
*/

-- 2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

drop database if exists example;
create database example;
use example;

drop table if exists users;
CREATE TABLE users (
	id INT NOT NULL,
	names varchar(100) NOT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

-- 3. Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

-- в командной строке win

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p example > backup.sql

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p password -f sample < backup.sql


-- 4. (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p mysql --where ///  > backup1.sql

-- немного не понял где брать таблицу help_keyword
-- в документации утилиты mysqldump сказано , что можно использовать where для данной задачи