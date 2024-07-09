package record.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import record.model.Record;
import record.service.RecordService;
import record.service.RecordServiceImpl;

@WebServlet("/record/update")
public class RecordUpdateController extends HttpServlet{
	
	private RecordService recordService = new RecordServiceImpl();
	
	// 指向修改頁面
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String updateId = req.getParameter("updateId");
		if(updateId == null) {
			return;
		}
		Record record = recordService.getById(Integer.parseInt(updateId));
		req.setAttribute("record", record);
		// 重導到修改頁面(Server 內部重導)
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/record_update.jsp");
		rd.forward(req, resp);
	}
	
	// 指向修改內容
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer id = Integer.parseInt(req.getParameter("id"));
		String type = req.getParameter("type");
		Integer cost = Integer.parseInt(req.getParameter("cost"));
		String content = req.getParameter("content");
		String costDateStr = req.getParameter("costDate");
		
		// 將用戶提交的消費日期字符串轉為 java.util.Date
		Date costDate = null;		
		
		try {
			costDate = new SimpleDateFormat("yyyy-MM-dd").parse(costDateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		recordService.updateType(id, type);
		recordService.updateCost(id, cost);
		recordService.updateContent(id, content);
		recordService.updateCostDate(id, costDate);
		
		// 透過 redirtect 重導到首頁 (Client 重導)
		resp.sendRedirect("/JavaWeb/record");
	}

	
}
