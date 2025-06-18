/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReportsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Reports;
import model.Users;
import model.ViolationUser;
import dao.ViolationsDAO;
import model.Notifications;
import dao.NotificationsDAO;
import java.lang.reflect.Array;

/**
 *
 * @author im_chur
 */
public class ReceiveHistoryReport extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReceiveHistoryReport</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReceiveHistoryReport at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("UTF-8"); 
        response.setContentType("text/html; charset=UTF-8"); 
        String action = request.getParameter("action");
        Users user = (Users) request.getSession().getAttribute("user");
        int userID = user.getUserID();
        switch (action) {
            case "viewHistoryReport":
                

                if (userID != 0) {
                    ArrayList<Reports> reportsList = ReportsDAO.getHistoryReports(userID);
                    request.setAttribute("reportsList", reportsList);
                }

                request.getRequestDispatcher("/view/historyReport.jsp").forward(request, response);
                break;

            case "viewHistoryViolation":
               
                if (userID != 0) {
                    ArrayList<ViolationUser> violationuser = ViolationsDAO.getAllViolationByUserIDIfItPaid(userID);
                    request.setAttribute("violationuser", violationuser);
                }
                request.getRequestDispatcher("/view/ViolationUser.jsp").forward(request, response);
                break;

            case "viewNotifications":
                
                if (userID != 0) {
                    ArrayList<Notifications> notifications = NotificationsDAO.receiveNotifications(userID);
                    request.setAttribute("notifications", notifications);

                }
                request.getRequestDispatcher("/view/notifications.jsp").forward(request, response);
                break;
                
            case "viewViolationWaitPaid":
                 if (userID != 0) {
                    ArrayList<ViolationUser> violationuserWaitPaid = ViolationsDAO.getAllViolationByUserIDIfItNOTPAID(userID);
                    request.setAttribute("violationuserWaitPaid", violationuserWaitPaid);
                }
                request.getRequestDispatcher("/view/violationsWaitPaid.jsp").forward(request, response);
                break ; 
                
                
            
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("UTF-8"); 
        response.setContentType("text/html; charset=UTF-8"); 
        int notificationID = Integer.parseInt(request.getParameter("notificationID"));

        if (NotificationsDAO.markAsRead(notificationID)) {
            // Lấy lại danh sách thông báo sau khi cập nhật
            Users user = (Users) request.getSession().getAttribute("user");
            if (user != null) {
                ArrayList<Notifications> notifications = NotificationsDAO.receiveNotifications(user.getUserID());
                request.setAttribute("notifications", notifications);
            }

            // Chuyển tiếp về trang notifications.jsp
            request.getRequestDispatcher("/view/notifications.jsp").forward(request, response);
        } else {
            response.getWriter().println("Lỗi khi cập nhật trạng thái thông báo.");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
