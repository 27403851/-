package schedule.dao;

import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import schedule.model.Schedule;

public class ScheduleMySQL implements ScheduleDao{
	
private JdbcTemplate jdbcTemplate;
	
	{
		String driverName = "com.mysql.cj.jdbc.Driver";
		String dbURL = "jdbc:mysql://localhost:3306/web?serverTimezone=Asia/Taipei";
		String username = "root";
		String password = "12345678";
		
		// 資料源設定
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(driverName);
		dataSource.setUrl(dbURL);
		dataSource.setUsername(username);
		dataSource.setPassword(password);
		
		// 將資料源設定給 jdbcTemplae
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public int create(Schedule schedule) {
		String sql = "insert into schedule(eventName, starDate, endDate, eventType, description) values(?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, schedule.getEventName(), schedule.getStarDate(), schedule.getEndDate(), schedule.getEventType(), schedule.getDescription());
	}

	@Override
	public Schedule findById(Integer id) {
		String sql = "select id, eventName, starDate, endDate, description, eventType from schedule where id = ?";
		try {
			Schedule schedule = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Schedule.class), id);
			return schedule;
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public List<Schedule> findAll() {
		String sql = "select id, eventName, starDate, endDate, description, eventType from schedule order by id";
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Schedule.class));
	}

	@Override
	public int update(Schedule schedule) {
		String sql = "update schedule set eventName=?, starDate=?, endDate=?, eventType=?, description=? where id=?";
		return jdbcTemplate.update(sql, schedule.getEventName(), schedule.getStarDate(), schedule.getEndDate(), schedule.getEventType(), schedule.getDescription(), schedule.getId());
	}

	@Override
	public int deleteById(Integer id) {
		String sql = "delete from schedule where id = ?";
		return jdbcTemplate.update(sql, id);
	}

}
