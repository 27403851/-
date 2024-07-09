-- 刪除 record
drop table if exists record;
-- 建立 record
create table if not exists record (
	id int auto_increment primary key,
    type varchar(50) not null,
    cost varchar(50) not null,
    cost_date DATE,
    content TEXT,
    update_date timestamp
)