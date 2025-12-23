package servlet.admin;

import dao.NguoiDungDAO;
import model.NguoiDung;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.time.LocalDateTime;

/**
 * Listener to initialize an admin account when the web application starts.
 * Checks if an admin account exists and creates one if it doesn't.
 */
@WebListener
public class AdminInitializer implements ServletContextListener {

    private static final String ADMIN_EMAIL = "adminTruyen@gmail.com"; // Account ADMIN
    private static final String ADMIN_PASSWORD = "adminTruyen@gmail.com"; // hange this in productionC
    private static final String ADMIN_NAME = "ADMIN TRUYỆN";
    private static final String ADMIN_PHONE = "0937743378"; //
    private static final String ADMIN_ROLE = "ADMIN";

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();

        // Check if admin account exists
        if (!nguoiDungDAO.kiemTraEmailTonTai(ADMIN_EMAIL)) {
            // Create new admin account
            NguoiDung admin = new NguoiDung();
            admin.setEmail(ADMIN_EMAIL);
            admin.setMatKhau(ADMIN_PASSWORD); // Will be hashed in DAO
            admin.setHoTen(ADMIN_NAME);
            admin.setSoDienThoai(ADMIN_PHONE);
            admin.setVaiTro(ADMIN_ROLE);
            admin.setTrangThai(true);
            admin.setNgayTao(LocalDateTime.now());
            admin.setNgayCapNhat(LocalDateTime.now());

            boolean success = nguoiDungDAO.dangKy(admin);
            if (success) {
                System.out.println("Admin account created successfully: " + ADMIN_EMAIL);
            } else {
                System.err.println("Failed to create admin account: " + ADMIN_EMAIL);
            }
        } else {
            System.out.println("Admin account da co: " + ADMIN_EMAIL);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
    }
}