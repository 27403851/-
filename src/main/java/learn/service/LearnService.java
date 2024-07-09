package learn.service;

import java.util.Date;
import java.util.List;

import learn.model.Learn;

public interface LearnService {
	
	boolean add(Date today, String content, String time, Integer bout); // 新增
	Learn getById(Integer id); // 單筆查詢
	Learn findByType(String content); // 單筆查詢
	List<Learn> queryAll(); // 多筆查詢
	boolean removeById(Integer id); // 刪除

}
