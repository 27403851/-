-- 刪除 user
drop table if exists user;

-- 建立 user
create table if not exists user (
	id int auto_increment primary key,
    username varchar(50) not null UNIQUE,
    password varchar(50) not null,
    email varchar(100) not null UNIQUE,
    salt varchar(32) not null
)