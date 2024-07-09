package schedule.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/schedule/calendar")
public class ScheduleCalendarController extends HttpServlet{

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 在这里处理 GET 请求
        // 您可以从数据库或其他数据源获取日程数据
        // 将日程数据设置为请求属性
        // 将请求转发到 JSP 页面
        // 示例代码如下：
        
        // 设置日程数据
        req.setAttribute("calendarData", getCalendarData());
        
        // 转发到 JSP 页面
        req.getRequestDispatcher("/WEB-INF/jsp/schedule_fullcalendar.jsp").forward(req, resp);
    }
    
    // 获取日历数据的示例方法
    private String getCalendarData() {
        // 这里可以是您从数据库或其他地方获取日历数据的逻辑
        // 返回格式化的 JSON 字符串，供 FullCalendar 使用
        return "[{ \"title\": \"Event 1\", \"start\": \"2024-06-01\" }, { \"title\": \"Event 2\", \"start\": \"2024-06-05\" }]";
    }

}
