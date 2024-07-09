package learn.dao;

import java.util.List;

import learn.model.Learn;

public interface LearnDao {
	
	int create(Learn learn); // 新增
	Learn findById(Integer id); // 單筆查詢
	Learn findByType(String content); // 單筆查詢
	List<Learn> findAll(); // 多筆查詢
	int deleteById(Integer id); // 刪除
	
}
