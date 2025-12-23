/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
/**
 *
 * @author USER
 */
@WebServlet(name="DBStatus", urlPatterns={"/index.html"})
public class DBStatus extends HttpServlet{
   @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();

    String result = DBConnection.testConnectionDetail(); // lấy thông báo chi tiết

    out.println("<html><head><title>Database Status</title></head><body>");
    out.println("<h2>Trạng thái kết nối CSDL</h2>");
    out.println("<p>" + result + "</p>");
    out.println("<a href='http://localhost:8080/TruyenChuTT/home'>← Quay lại</a>");
    out.println("</body></html>");
}

}
