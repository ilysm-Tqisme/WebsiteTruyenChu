/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package checkVIP;

/**
 *
 * @author USER
 */
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.Timer;

@WebListener
public class AppListener implements ServletContextListener {
    private Timer timer;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        timer = new Timer();
        timer.schedule(new VipReminderTask(), 0, 24 * 60 * 60 * 1000); // mỗi 24h
        System.out.println("✅ Đã khởi động lịch kiểm tra VIP!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        timer.cancel();
        System.out.println("🛑 Đã dừng lịch kiểm tra VIP.");
    }
}

