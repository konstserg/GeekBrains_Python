/* ���������� ���� MySQL. �������� � �������� ���������� ���� .my.cnf, ����� � ��� ����� � ������, ������� ���������� ��� ���������.
  
������ ���� my.ini � �������� ����� C:\ � �����������:
[mysql]
user=root
password=password
*/

-- 2. �������� ���� ������ example, ���������� � ��� ������� users, ��������� �� ���� ��������, ��������� id � ���������� name.

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

-- 3. �������� ���� ���� ������ example �� ����������� �������, ���������� ���������� ����� � ����� ���� ������ sample.

-- � ��������� ������ win

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p example > backup.sql

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p password -f sample < backup.sql


-- 4. (�� �������) ������������ ����� �������� � ������������� ������� mysqldump. �������� ���� ������������ ������� help_keyword ���� ������ mysql. ������ ��������� ����, ����� ���� �������� ������ ������ 100 ����� �������.

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p mysql --where ///  > backup1.sql

-- ������� �� ����� ��� ����� ������� help_keyword
-- � ������������ ������� mysqldump ������� , ��� ����� ������������ where ��� ������ ������