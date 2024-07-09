package schedule.controller;

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
import schedule.model.Schedule;
import schedule.service.ScheduleService;
import schedule.service.ScheduleServiceImpl;

@WebServlet("/schedule")
public class ScheduleController extends HttpServlet{

	private ScheduleService service = new ScheduleServiceImpl();

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
		List<Schedule> schedules = service.queryAll();
		req.setAttribute("schedules", schedules);
		
		// 內重導到 jsp
		RequestDispatcher sc = req.getRequestDispatcher("/WEB-INF/jsp/schedule.jsp");
		sc.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String eventName = req.getParameter("eventName");
		String starDateStr = req.getParameter("starDate");
		String endDateStr = req.getParameter("endDate");
		String description = req.getParameter("description");
		String eventType = req.getParameter("eventType");
		
		// 將用戶提交的消費日期字符串轉為 java.util.Date ------------------
		
		Date starDate = null;
		
	    try {
	    	starDate = new SimpleDateFormat("yyyy-MM-dd").parse(starDateStr);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    
		Date endDate = null;
		
	    try {
	    	endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    // ---------------------------------------------------------
	    
		boolean state = service.add(eventName, starDate, endDate, description, eventType);
		req.setAttribute("state", state);
		
		// 內重導到 jsp
		RequestDispatcher sc = req.getRequestDispatcher("/WEB-INF/jsp/schedule_result.jsp");
		sc.forward(req, resp);
	}
	
		
}
