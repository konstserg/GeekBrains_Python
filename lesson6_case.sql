-- Урок 6. Вебинар. Операторы, фильтрация, сортировка и ограничение. Агрегация данных

use vk;

-- Является ли пользователь админом данного сообщества?
-- добавляем поле admin_user_id в таблицу communities
ALTER TABLE vk.communities ADD admin_user_id INT DEFAULT 1 NOT NULL;
-- ALTER TABLE vk.communities ADD CONSTRAINT communities_fk FOREIGN KEY (admin_user_id) REFERENCES vk.users(id);

-- установим пользователя с id = 1 в качестве админа ко всем сообществам
update communities
set admin_user_id = 1;

-- является ли пользователь админом группы?
-- user_id = 1
-- community_id = 5
select 1 = (
	select admin_user_id
	from communities
	where id = 5
	) 'is admin';
	
-- Можно ли сделать, чтобы при запросе выходило слово 'yes' или 'no' вместо значений '1' и '0'?
select 1 = (
	select
		CASE (admin_user_id)
			WHEN admin_user_id = '1'
				THEN 'yes'
			-- WHEN admin_user_id = '0'
				-- THEN 'no'
			ELSE 'no'
	    END -- CASE
    from communities
	where id = 5) as 'is admin';