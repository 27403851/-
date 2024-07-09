package schedule.controller;

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
import schedule.model.Schedule;
import schedule.service.ScheduleService;
import schedule.service.ScheduleServiceImpl;

@WebServlet("/schedule/update")
public class ScheduleUpdateController extends HttpServlet{
	
	private ScheduleService scheduleService = new ScheduleServiceImpl();
	
	// 指向修改頁面
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String updateId = req.getParameter("updateId");
		if(updateId == null) {
			return;
		}
		Schedule schedule = scheduleService.getById(Integer.parseInt(updateId));
		req.setAttribute("schedule", schedule);
		// 重導到修改頁面(Server 內部重導)
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/schedule_update.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer id = Integer.parseInt(req.getParameter("id"));
		String eventName = req.getParameter("eventName");
		String starDateStr = req.getParameter("starDate");
		String endDateStr = req.getParameter("endDate");
		String description = req.getParameter("description");
		String eventType = req.getParameter("eventType");
		
		
		// 將用戶提交的消費日期字符串轉為 java.util.Date
		Date starDate = null;	
		Date endDate = null;
		
		try {
			starDate = new SimpleDateFormat("yyyy-MM-dd").parse(starDateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		try {
			endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		scheduleService.updateEventName(id, eventName);
		scheduleService.updateStarDate(id, starDate);
		scheduleService.updateEndDate(id, endDate);
		scheduleService.updateDescription(id, description);
		scheduleService.updateEventType(id, eventType);
		
		// 透過 redirtect 重導到首頁 (Client 重導)
		resp.sendRedirect("/JavaWeb/schedule");
	}

}
