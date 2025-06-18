/*
 * Click nfs://.netbeans.org/filesystem/16.0.0/org-netbeans-modules-web-project.jar!/Templates/Licenses/license-default.txt to change this license
 * Click nfs://.netbeans.org/editors/16.0.0/org-netbeans-modules-editor-indent-jsp.xml to edit this template
 */

package controller;

import dao.NotificationsDAO;
import dao.ViolationsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Calendar;
import model.Notifications;
import model.ViolationUser;
import model.Violations;

/**
 *
 * @author im_chur
 */
public class AdminDoWithViolation extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminDoWithViolation</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDoWithViolation at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action") ; 
        switch(action) {
            case"statusViolationNotPaid":
                ArrayList<ViolationUser> admingetViolationUserListNotPaid  = new ArrayList<ViolationUser>() ; 
                admingetViolationUserListNotPaid = ViolationsDAO.AdmingetAllViolationByUserIDIfItNOTPAID() ;
                request.setAttribute("admingetViolationUserListNotPaid", admingetViolationUserListNotPaid);
                request.getRequestDispatcher("/view/admin/adminViewViolationUserNotPaid.jsp").forward(request, response);
                break ; 
                
            case"statusViolationPaid":
                ArrayList<ViolationUser> admingetViolationUserListPaid  = new ArrayList<ViolationUser>() ; 
                admingetViolationUserListPaid = ViolationsDAO.AdmingetAllViolationByUserIDIfItPAID() ;
                request.setAttribute("admingetViolationUserListPaid", admingetViolationUserListPaid);
                request.getRequestDispatcher("/view/admin/adminViewViolationUserPaid.jsp").forward(request, response);
                break ; 
        }
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String violatorID = request.getParameter("violatorID");
        String plateNumber = request.getParameter("plateNumber");
        String notificationMessage = request.getParameter("notification");

        if (violatorID != null && plateNumber != null && notificationMessage != null && !notificationMessage.trim().isEmpty()) {
            
            java.util.Date currentDate = Calendar.getInstance().getTime();
            int violatorIDs = Integer.parseInt(violatorID) ; 
            
            Notifications notification = new Notifications(0, violatorIDs, notificationMessage, plateNumber, currentDate, true) ; 
            

            boolean success = NotificationsDAO.sendNotifications(notification);

            if (success) {
                request.setAttribute("message", "Gửi thông báo thành công!");
            } else {
                request.setAttribute("message", "Gửi thông báo thất bại!");
            }
        } else {
            request.setAttribute("message", "Vui lòng nhập nội dung thông báo.");
        }

        request.getRequestDispatcher("/view/admin.jsp").forward(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}