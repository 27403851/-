-- 刪除 learn
drop table if exists learn;
-- 建立 learn
create table if not exists learn (
	id int auto_increment primary key,
    today date not null,
    content varchar(50) not null,
    time varchar(50) not null,
    bout varchar(50) not null
)