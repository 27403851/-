package register;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

public class UserDaoImpl implements UserDao {

    // 生成随机盐值
    private String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    // 使用 SHA-256 加密密码并加盐
    private String hashPassword(String password, String salt) {
        String saltedPassword = password + salt;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(saltedPassword.getBytes());
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int register(User user) {
    	// 檢查使用者名稱是否已存在
        if (existsByUsername(user.getUsername())) {
            return 2; // 使用者名稱已存在
        }
        
        // 檢查電子郵件是否已存在
        if (existsByEmail(user.getEmail())) {
            return 3; // 電子郵件已存在
        }
        
        // 生成鹽值並設置到使用者物件中
        String salt = generateSalt();
        user.setSalt(salt);
        // 將密碼進行雜湊處理並設置到使用者物件中
        user.setPassword(hashPassword(user.getPassword(), salt));

        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/web?serverTimezone=Asia/Taipei";
            String dbUsername = "root";
            String dbPassword = "12345678";

            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            String sql = "INSERT INTO user (username, password, email, salt) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getSalt());

            result = pstmt.executeUpdate();
            
        } catch (ClassNotFoundException | SQLException e) {
        	// 處理例外情況，例如找不到 JDBC 驅動程式、資料庫連線失敗、SQL 執行錯誤等
            e.printStackTrace();
            result = -1; // 設置結果為資料庫錯誤
        } finally {
            try {
            	// 關閉資料庫連線和 PreparedStatement
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return result;
    }

    @Override
    public User findByUsername(String username) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/web?serverTimezone=Asia/Taipei";
            String dbUsername = "root";
            String dbPassword = "12345678";

            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            String sql = "SELECT * FROM user WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setSalt(rs.getString("salt"));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return user;
    }

    @Override
    public boolean existsByUsername(String username) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean exists = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/web?serverTimezone=Asia/Taipei";
            String dbUsername = "root";
            String dbPassword = "12345678";

            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            String sql = "SELECT COUNT(*) FROM user WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);

            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                exists = true;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return exists;
    }

    @Override
    public boolean existsByEmail(String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean exists = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/web?serverTimezone=Asia/Taipei";
            String dbUsername = "root";
            String dbPassword = "12345678";

            conn = DriverManager.getConnection(url, dbUsername, dbPassword);

            String sql = "SELECT COUNT(*) FROM user WHERE email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);

            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                exists = true;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return exists;
    }
}
