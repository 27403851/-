package record.service;

import java.util.Date;
import java.util.List;

import record.model.Record;

public interface RecordService {
	
	boolean add(String type, Integer cost, String content, Date costDate); // 新增
	Record getById(Integer id); // 單筆查詢
	List<Record> queryAll(); // 多筆查詢
	boolean updateType(Integer id, String type); // 修改種類
	boolean updateCost(Integer id, Integer cost); // 修改金額
	boolean updateContent(Integer id, String content); // 修改日期
	boolean updateCostDate(Integer id, Date costDate); // 修改日期
	boolean removeById(Integer id); // 刪除
	
}
