package record.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import record.model.Record;
import record.service.RecordService;
import record.service.RecordServiceImpl;

@WebServlet("/record")
public class RecordController extends HttpServlet{
	
	private RecordService service = new RecordServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 是否有 deleteId 參數帶入 ?
				String deleteId = req.getParameter("deleteId");
				if(deleteId != null) {
					// 將 deleteId 轉成 Integer
					Integer id = Integer.valueOf(deleteId);
					// 刪除指定 id 位置的紀錄
					service.removeById(id);
				}
		
		// 取得所有紀錄
		List<Record> records = service.queryAll();
		req.setAttribute("records", records);
		
		// 內重導到 jsp
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/record.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String type = req.getParameter("type");
		Integer cost = Integer.parseInt(req.getParameter("cost"));
		String content = req.getParameter("content");
		String costDateStr = req.getParameter("costDate");
		
		// 將用戶提交的消費日期字符串轉為 java.util.Date ------------------
		
		Date costDate = null;
		
	    try {
	        costDate = new SimpleDateFormat("yyyy-MM-dd").parse(costDateStr);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    
	    // ---------------------------------------------------------
	    
		boolean state = service.add(type, cost, content, costDate);
		req.setAttribute("state", state);
		
		// 內重導到 jsp
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/record_result.jsp");
		rd.forward(req, resp);
	}

}
