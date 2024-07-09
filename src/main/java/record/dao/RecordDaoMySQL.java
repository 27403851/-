package record.dao;

import java.util.List;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import record.model.Record;

public class RecordDaoMySQL implements RecordDao{

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
	public int create(Record record) {
		String sql = "insert into record(type, cost, cost_date, content) values(?, ?, ?, ?)";
		return jdbcTemplate.update(sql, record.getType(), record.getCost(), record.getCostDate(), record.getContent());
	}

	@Override
	public Record findById(Integer id) {
		String sql = "select id, type, cost, cost_date, update_date, content from record where id = ?";
		try {
			Record record = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Record.class), id);
			return record;
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public List<Record> findAll() {
		String sql = "select id, type, cost, cost_date, update_date, content from record order by id";
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Record.class));
	}

	@Override
	public int deleteById(Integer id) {
		String sql = "delete from record where id = ?";
		return jdbcTemplate.update(sql, id);
	}

	@Override
	public int update(Record record) {
		String sql = "update record set type=?, cost=?, cost_date=?, content=?, update_date=NOW() where id=?";
		return jdbcTemplate.update(sql, record.getType(), record.getCost(), record.getCostDate(), record.getContent() != null ? record.getContent() : "", record.getId());
	}

}
