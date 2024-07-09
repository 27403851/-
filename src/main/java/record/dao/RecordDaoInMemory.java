package record.dao;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import record.model.Record;

public class RecordDaoInMemory implements RecordDao{

	// In-Memory 資料
	private List<Record> records = new CopyOnWriteArrayList<>();
	
	@Override
	public int create(Record record) {
		// 找到 guestBooks 中 id 的最大值
		Integer maxId = records.stream()
				.map(Record::getId) // .map(rd -> rd.getId())
				.max(Integer::compareTo) // .max((o1, o2) -> Integer.compare(o1, o2))
				.orElse(0);
		maxId += 1; // 將最大值加一
		record.setId(maxId);
		records.add(record);
		return 1;
	}

	@Override
	public Record findById(Integer id) {
		return records.stream().filter(rd -> rd.getId().equals(id)).findFirst().orElse(null);
	}

	@Override
	public List<Record> findAll() {
		return records;
	}


	@Override
	public int update(Record record) {
		Record recordUpt = findById(record.getId());
		if(recordUpt == null) {
			return 0;
		}
		recordUpt.setType(record.getType());
		recordUpt.setCost(record.getCost());
		return 1;
	}

	@Override
	public int deleteById(Integer id) {
		Record recordDel = findById(id);
		if(recordDel == null) {
			return 0;
		}
		records.remove(recordDel);
		return 1;
	}
	
}
