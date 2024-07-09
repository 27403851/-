package record.service;

import java.util.Date;
import java.util.List;

import record.dao.RecordDao;
import record.dao.RecordDaoInMemory;
import record.dao.RecordDaoMySQL;
import record.model.Record;

public class RecordServiceImpl implements RecordService{

	// private RecordDao dao = new RecordDaoInMemory();
	private RecordDao dao = new RecordDaoMySQL();
	
	@Override
	public boolean add(String type, Integer cost, String content, Date costDate) {
		Record rd = new Record(type, cost, content, costDate);
		int rowcount = dao.create(rd);
		return rowcount == 1;
	}

	@Override
	public Record getById(Integer id) {
		return dao.findById(id);
	}

	@Override
	public List<Record> queryAll() {
		return dao.findAll();
	}

	@Override
	public boolean updateType(Integer id, String type) {
		Record rd = dao.findById(id);
		if(rd == null) {
			return false;
		}
		rd.setType(type);
		int rowcount = dao.update(rd);
		return rowcount == 1;
	}

	@Override
	public boolean updateCost(Integer id, Integer cost) {
		Record rd = dao.findById(id);
		if(rd == null) {
			return false;
		}
		rd.setCost(cost);
		int rowcount = dao.update(rd);
		return rowcount == 1;
	}
	
	@Override
	public boolean updateCostDate(Integer id, Date costDate) {
		Record rd = dao.findById(id);
		if(rd == null) {
			return false;
		}
		rd.setCostDate(costDate);
		int rowcount = dao.update(rd);
		return rowcount == 1;
	}

	@Override
	public boolean updateContent(Integer id, String content) {
		Record rd = dao.findById(id);
		if(rd == null) {
			return false;
		}
		rd.setContent(content);
		int rowcount = dao.update(rd);
		return rowcount == 1;
	}
	
	@Override
	public boolean removeById(Integer id) {
		int rowcount = dao.deleteById(id);
		return rowcount == 1;
	}

}
