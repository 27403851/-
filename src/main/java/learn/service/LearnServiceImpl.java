package learn.service;

import java.util.Date;
import java.util.List;

import learn.dao.LearnDao;
import learn.dao.LearnDaoMySQL;
import learn.model.Learn;

public class LearnServiceImpl implements LearnService {

	private LearnDao dao = new LearnDaoMySQL();
	
	@Override
	public boolean add(Date today, String content, String time, Integer bout) {
		Learn ln = new Learn(today, content, time, bout);
		int rowcount = dao.create(ln);
		return rowcount == 1;
	}

	@Override
	public Learn getById(Integer id) {
		return dao.findById(id);
	}

	@Override
	public Learn findByType(String content) {
		return dao.findByType(content);
	}

	@Override
	public List<Learn> queryAll() {
		return dao.findAll();
	}

	@Override
	public boolean removeById(Integer id) {
		int rowcount = dao.deleteById(id);
		return rowcount == 1;
	}

}
