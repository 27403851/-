package schedule.service;

import java.util.Date;
import java.util.List;

import schedule.dao.ScheduleDao;
import schedule.dao.ScheduleMySQL;
import schedule.model.Schedule;

public class ScheduleServiceImpl implements ScheduleService{

	private ScheduleDao dao = new ScheduleMySQL();
	
	@Override
	public boolean add(String eventName, Date starDate, Date endDate, String description, String eventType) {
		Schedule sc = new Schedule(eventName, starDate, endDate, description, eventType);
		int rowcount = dao.create(sc);
		return rowcount == 1;
	}

	@Override
	public Schedule getById(Integer id) {
		return dao.findById(id);
	}

	@Override
	public List<Schedule> queryAll() {
		return dao.findAll();
	}

	@Override
	public boolean updateEventName(Integer id, String eventName) {
		Schedule sc = dao.findById(id);
		if(sc == null) {
			return false;
		}
		sc.setEventName(eventName);
		int rowcount = dao.update(sc);
		return rowcount == 1;
	}

	@Override
	public boolean updateStarDate(Integer id, Date starDate) {
		Schedule sc = dao.findById(id);
		if(sc == null) {
			return false;
		}
		sc.setStarDate(starDate);
		int rowcount = dao.update(sc);
		return rowcount == 1;
	}

	@Override
	public boolean updateEndDate(Integer id, Date endDate) {
		Schedule sc = dao.findById(id);
		if(sc == null) {
			return false;
		}
		sc.setEndDate(endDate);
		int rowcount = dao.update(sc);
		return rowcount == 1;
	}

	@Override
	public boolean updateDescription(Integer id, String description) {
		Schedule sc = dao.findById(id);
		if(sc == null) {
			return false;
		}
		sc.setDescription(description);
		int rowcount = dao.update(sc);
		return rowcount == 1;
	}

	@Override
	public boolean removeById(Integer id) {
		int rowcount = dao.deleteById(id);
		return rowcount == 1;
	}

	@Override
	public boolean updateEventType(Integer id, String eventType) {
		Schedule sc = dao.findById(id);
		if(sc == null) {
			return false;
		}
		sc.setEventType(eventType);
		int rowcount = dao.update(sc);
		return rowcount == 1;
	}

}
