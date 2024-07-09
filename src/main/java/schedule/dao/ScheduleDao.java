package schedule.dao;

import java.util.List;

import schedule.model.Schedule;

public interface ScheduleDao {
	
	int create(Schedule schedule); //新增
	Schedule findById(Integer id); // 單筆查詢
	List<Schedule> findAll(); // 多筆查詢
	int update(Schedule schedule); // 修改
	int deleteById(Integer id); // 刪除
	
}

