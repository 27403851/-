package register;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");

        UserService userservice = new UserServiceImpl();
        int info = userservice.register(username, password, email);
        String message;
        if(info == 1) {
            message = "註冊成功";
        } else if (info == 2) {
            message = "用戶名已存在";
        } else if (info == 3) {
            message = "電子郵件已存在";
        } else if (info == -1) {
            message = "資料庫錯誤";
        } else {
            message = "未知錯誤";
        }

        req.setAttribute("message", message);
        req.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(req, resp);
    }
}
