package learn.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Learn {
	private Integer id; // 編號
	private Date today; // 日期
	private String content; // 項目內容
	private String time; // 時間
	private Integer bout; // 次數
	
	public Learn(Date today, String content, String time, Integer bout) {
		this.today = today;
		this.content = content;
		this.time = time;
		this.bout = bout;
	}
}
