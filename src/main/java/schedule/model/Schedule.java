package schedule.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Schedule {
	private Integer id;
	private String eventName; // 事件名稱
	private Date starDate; // 開始日期
	private Date endDate; // 結束日期
	private String description; // 內容備註
	private String eventType; // 行事曆標籤顏色
	
	public Schedule(String eventName, Date starDate, Date endDate, String description, String eventType) {
		this.eventName = eventName;
		this.starDate = starDate;
		this.endDate = endDate;
		this.description = description;
		this.eventType = eventType;
	}
}
