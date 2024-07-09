package learn.controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/learn_finish")
public class LearnFinishController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        // 处理GET请求
        try {
            request.getRequestDispatcher("/WEB-INF/jsp/learn_finish.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 处理POST请求（如果有的话）
        doGet(request, response);
    }
}
