-- Урок 6. Вебинар. Операторы, фильтрация, сортировка и ограничение. Агрегация данных

/* 1. Пусть задан некоторый пользователь. 
   Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
*/

use vk;

-- выберем друзей пользователя с id = 1
select initiator_user_id, target_user_id, status
from friend_requests
where (initiator_user_id = 1 or target_user_id = 1) and status = 'approved'
;

-- просмотр переписок пользователя id = 1
select id, from_user_id, to_user_id
from messages
where ( to_user_id = 1 or from_user_id = 1)
;

-- общее количество сообщений с id = 1
select 
count(to_user_id = 1 or from_user_id = 1) as all_mesg
from messages
where ( to_user_id = 1 or from_user_id = 1)
;

select 
	from_user_id, count(*) as 'messages'
from messages m
join users u on u.id = m.from_user_id
where to_user_id = 1
group by from_user_id
order by count(*)
;


-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

select count(*)
from likes
where media_id in ( 
	select id 
	from media 
	where user_id in (
		select user_id
		from profiles
		where  YEAR(CURDATE()) - YEAR(birthday) < 10)
);

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?

select count(*) as `total`,
	(select gender from profiles where user_id = likes.user_id) as gender
from
	likes
group by gender
order by `total`
;
























