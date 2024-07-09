package learn.dao;

import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import learn.model.Learn;

public class LearnDaoMySQL implements LearnDao {

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
	public int create(Learn learn) {
		String sql = "insert into learn(today, content, time, bout) values(?, ?, ?, ?)";
		return jdbcTemplate.update(sql, learn.getToday(), learn.getContent(), learn.getTime(), learn.getBout());
	}

	@Override
	public Learn findById(Integer id) {
		String sql = "select id, today, content, time, bout from learn where id = ?";
		try {
			Learn learn = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Learn.class), id);
			return learn;
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public Learn findByType(String content) {
		String sql = "select id, today, content, time, bout from learn where content = ?";
		try {
			Learn learn = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Learn.class), content);
			return learn;
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public List<Learn> findAll() {
		String sql = "select id, today, content, time, bout from learn order by id";
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Learn.class));
	}

	@Override
	public int deleteById(Integer id) {
		String sql = "delete from learn where id = ?";
		return jdbcTemplate.update(sql, id);
	}
	
}
