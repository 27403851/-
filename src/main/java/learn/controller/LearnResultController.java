package learn.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/learn_result")
public class LearnResultController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 获取表单参数
        String time = request.getParameter("time");
        String bout = request.getParameter("bout");
        int durationInSeconds = 0;
        int bouts = 1;

        // 根据选择的时间设置秒数
        if ("25分鐘".equals(time)) {
            durationInSeconds = 25 * 60;
        } else if ("40分鐘".equals(time)) {
            durationInSeconds = 40 * 60;
        } else if ("55分鐘".equals(time)) {
            durationInSeconds = 55 * 60;
        } else if ("5秒鐘".equals(time)) {
            durationInSeconds = 5;
        }

        // 解析选择的回数
        try {
            bouts = Integer.parseInt(bout);
        } catch (NumberFormatException e) {
            bouts = 1; // 默认值
        }
        
        // 设置请求属性
        request.setAttribute("studyDuration", durationInSeconds);
        request.setAttribute("bouts", bouts);
        
        // 转发请求到倒数计时页面
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/learn_result.jsp");
        dispatcher.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
