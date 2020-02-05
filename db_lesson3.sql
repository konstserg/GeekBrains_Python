DROP TABLE IF EXISTS `bookmarks`; -- таблица закладки. В ней хранится информация о пользователе, который опубликовал ее, медиа и лайках
CREATE TABLE `bookmarks` (
	`id` SERIAL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,
    `media_id` BIGINT UNSIGNED NOT null,
    `likes_id` BIGINT UNSIGNED NOT null,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id),
    FOREIGN KEY (likes_id) REFERENCES likes(id),    
     	  	
  	INDEX (user_id),
  	INDEX (media_id),
  	index (likes_id)
  	);


DROP TABLE IF EXISTS `saved_msg`; -- таблица сохраненные сообщения. Хранится: информация о пользователе, само сообщение
CREATE TABLE `saved_msg` (
	`id` SERIAL,
	`user_id` BIGINT UNSIGNED DEFAULT NULL,
    `messages_id` BIGINT UNSIGNED DEFAULT NULL,
    `body_text` TEXT(100) not null, 
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX (user_id)
);


DROP TABLE IF EXISTS `apps`;
CREATE TABLE `apps` (
	`id` SERIAL,
	`application_name` varchar(100),
	`user_id` BIGINT UNSIGNED DEFAULT NULL,
	
        
    PRIMARY KEY (`id`),
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX (application_name)
);