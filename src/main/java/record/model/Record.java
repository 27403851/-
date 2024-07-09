package record.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Record {
	private Integer id;
	private String type;
	private Integer cost;
	private String content;
	private Date costDate;
	private Date updateDate;
	
	public Record(String type, Integer cost, String content, Date costDate) {
		this.type = type;
		this.cost = cost;
		this.content = content;
		this.costDate = costDate;
	}
}
