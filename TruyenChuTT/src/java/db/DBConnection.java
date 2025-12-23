package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/DBTruyen?serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "25102005";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName(DRIVER);
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static String testConnectionDetail() {
        try (Connection conn = getConnection()) {
            if (conn != null && !conn.isClosed()) {
                return "✅ Kết nối thành công!";
            } else {
                return "❌ Kết nối null hoặc đã bị đóng.";
            }
        } catch (ClassNotFoundException e) {
            return "❌ Không tìm thấy JDBC Driver: " + e.getMessage();
        } catch (SQLException e) {
            return "❌ SQLException: " + e.getMessage() + "<br/>Mã lỗi: " + e.getErrorCode() + "<br/>SQL State: " + e.getSQLState();
        }
    }
}
