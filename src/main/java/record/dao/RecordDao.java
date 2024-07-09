package record.dao;

import java.util.List;

import record.model.Record;

public interface RecordDao {
	
	int create(Record record); // 新增
	Record findById(Integer id); // 單筆查詢
	List<Record> findAll(); // 多筆查詢
	int update(Record record); // 修改
	int deleteById(Integer id); // 刪除
}
