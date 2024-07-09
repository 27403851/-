package schedule.service;


import java.util.Date;
import java.util.List;

import schedule.model.Schedule;

public interface ScheduleService {
	
	boolean add(String eventName, Date starDate, Date endDate, String description, String eventType); // 新增
	Schedule getById(Integer id); // 單筆查詢
	List<Schedule> queryAll(); // 多筆查詢
	boolean updateEventName(Integer id, String eventName); // 修改事件名稱
	boolean updateStarDate(Integer id, Date starDate); // 修改事件開始日期
	boolean updateEndDate(Integer id, Date endDate); // 修改事件結束日期
	boolean updateDescription(Integer id, String description); // 修改事件備註
	boolean updateEventType(Integer id, String eventType); // 修改事件類型
	boolean removeById(Integer id); // 刪除
}
