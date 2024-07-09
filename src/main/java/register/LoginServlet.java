package register;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // GET请求直接转发到登录页面
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // 調用 UserService 進行登錄驗證
        boolean authenticated = userService.login(username, password);

        if (!authenticated) {
            // 使用者名不存在的情況
            User existingUser = userService.findByUsername(username);
            if (existingUser == null) {
                req.setAttribute("message", "此帳號尚未註冊");
            } else {
                req.setAttribute("message", "密碼錯誤");
            }
            req.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(req, resp);
        } else {
            // 登錄成功
            req.setAttribute("username", username);
            req.getRequestDispatcher("/default.html").forward(req, resp);
        }
    }
}
