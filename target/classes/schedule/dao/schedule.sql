-- 刪除 schedule
drop table if exists schedule;

-- 建立 schedule
create table if not exists schedule (
	id int auto_increment primary key,
    eventName varchar(50) not null,
    starDate DATE,
    endDate DATE,
    description TEXT,
    eventType varchar(50) not null
)