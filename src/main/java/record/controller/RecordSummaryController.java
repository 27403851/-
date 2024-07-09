package record.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import record.model.Record;
import record.service.RecordService;
import record.service.RecordServiceImpl;

@WebServlet("/record/summary")
public class RecordSummaryController extends HttpServlet {

	private RecordService service = new RecordServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 获取所有记录
        List<Record> recordList = service.queryAll();
        
        // 设置请求属性，传递记录列表到页面
        req.setAttribute("records", recordList);
		
		req.getRequestDispatcher("/WEB-INF/jsp/record_summary.jsp").forward(req, resp);
	}

}
