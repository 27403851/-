package learn.controller;

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
import learn.model.Learn;
import learn.service.LearnService;
import learn.service.LearnServiceImpl;

@WebServlet("/learn")
public class LearnController extends HttpServlet{
	
	private LearnService service = new LearnServiceImpl();

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
		List<Learn> learns = service.queryAll();
		req.setAttribute("learns", learns);
		
		// 內重導到 jsp
		RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/jsp/learn.jsp");
		rd.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String todayStr = req.getParameter("today");
		String content = req.getParameter("content");
		String time = req.getParameter("time");
		Integer bout = Integer.parseInt(req.getParameter("bout"));
		
		// 將用戶提交的消費日期字符串轉為 java.util.Date ------------------
		
		Date today = null;
		
	    try {
	    	today = new SimpleDateFormat("yyyy-MM-dd").parse(todayStr);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
		
		boolean state = service.add(today, content, time, bout);
		req.setAttribute("state", state);	
		
	    // 获取用户选择的时间和次数
	    String timeOption = req.getParameter("time");
	    String boutOption = req.getParameter("bout");
	    
	    // 将时间和次数设置为请求属性
	    req.setAttribute("time", timeOption);
	    req.setAttribute("bout", boutOption);
	    
	    // 请求转发到 LearnResultController
	    req.getRequestDispatcher("/learn_result").forward(req, resp);
	
	}
	
}
