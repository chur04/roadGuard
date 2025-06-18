package controller;

import dao.VehiclesDAO;
import dao.ViolationsDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.VehicleUser;
import model.Violations;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import model.Reports;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import dao.ReportsDAO;
import java.util.List;
import model.Users;
import model.Vehicles;
import model.Notifications ; 
import java.util.Date  ; 
import dao.NotificationsDAO ; 

/**
 *
 * @author im_chur
 */
public class AdminAction extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminAction</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAction at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("UTF-8"); 
        response.setContentType("text/html; charset=UTF-8"); 
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Reports report = (Reports) session.getAttribute("report");
        PrintWriter out = response.getWriter();

        if ("SEND".equalsIgnoreCase(action)) {
            try {
                double fineAmount = Double.parseDouble(request.getParameter("fineamount"));
                String dateStr = request.getParameter("finedate");

                if (dateStr == null || dateStr.isEmpty()) {
                    request.setAttribute("error", "Must enter all");
                    request.getRequestDispatcher("/view/admin/sendViolation.jsp").forward(request, response);
                    return;
                }

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date fineDate = sdf.parse(dateStr);
                Users user = (Users) session.getAttribute("user");

                if (report == null || user == null) {
                    out.print("Session expired");
                    response.sendRedirect(request.getContextPath() + "/view/admin.jsp");
                    return;
                }

                VehicleUser vehicles = VehiclesDAO.getVehiclesByPlateNumber(report.getPlateNumber());
                if (vehicles == null) {
                    out.print("Vehicle not found");
                    response.sendRedirect(request.getContextPath() + "/view/admin.jsp");
                    return;
                }

                int violatorID = vehicles.getUserID();
                Violations violation = new Violations(0, report.getReportID(), report.getPlateNumber(), violatorID, fineAmount, fineDate, false);

                
                
                String message = request.getParameter("message") ; 
                Notifications notifications = new Notifications(0, violatorID, message,report.getPlateNumber() , new Date(System.currentTimeMillis()), false ) ; 
                
                
                if (fineAmount == 0 || fineDate == null || message == null || message.isEmpty()){
                    request.setAttribute("error", "Must enter all in there");
                    request.getRequestDispatcher("/view/admin/sendViolation.jsp").forward(request, response);
                }
                
                boolean success = ViolationsDAO.sendViolation(violation)
                        && ReportsDAO.updateAfterApprovedOrRejectReport("Approved", report.getReportID(), user.getUserID())
                        && NotificationsDAO.sendNotifications(notifications) ; 
                
                if (success) {
                    
                    session.removeAttribute("reports");
                    List<Reports> updatedReports = ReportsDAO.getAllReportsIfItIsPending();
                    session.setAttribute("reports", updatedReports);

                    request.setAttribute("message", " Send Succesfully");
                    request.getRequestDispatcher("/view/admin/adminReceiveReports.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "Send Fail");
                    request.getRequestDispatcher("/view/admin/adminReceiveReports.jsp").forward(request, response);
                }
            } catch (NumberFormatException | ParseException e) {
                e.printStackTrace();
                request.setAttribute("error", "Must enter all");
                request.getRequestDispatcher("/view/admin/sendViolation.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("UTF-8"); 
        response.setContentType("text/html; charset=UTF-8"); 
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        switch (action.toLowerCase()) {
            case "view":
                String plateNumber = request.getParameter("plateNumber");
                if (plateNumber != null && !plateNumber.isEmpty()) {
                    request.setAttribute("vehicle", VehiclesDAO.getVehiclesByPlateNumber(plateNumber));
                }
                request.getRequestDispatcher("/view/admin/viewViolationInfo.jsp").forward(request, response);
                break;

            case "send":
                plateNumber = request.getParameter("plateNumber");
                String reportID = request.getParameter("reportID");
                Reports report = ReportsDAO.getReportByPlateNumberAndreportID(plateNumber, reportID);
                if (report != null) {
                    session.setAttribute("report", report);
                    request.getRequestDispatcher("/view/admin/sendViolation.jsp").forward(request, response);
                } else {
                    response.getWriter().print("No report found");
                }
                break;

            case "reject":
                plateNumber = request.getParameter("plateNumber");
                reportID = request.getParameter("reportID");
                Reports reportToReject = ReportsDAO.getReportByPlateNumberAndreportID(plateNumber, reportID);

                if (user == null || reportToReject == null) {
                    response.sendRedirect(request.getContextPath() + "/view/admin.jsp");
                    response.getWriter().print("Invalid session or report");
                    return;
                }

                boolean isRejected = ReportsDAO.updateAfterApprovedOrRejectReport("Reject", reportToReject.getReportID(), user.getUserID());

                if (isRejected) {
                    
                    session.removeAttribute("reports");
                    List<Reports> updatedReports = ReportsDAO.getAllReportsIfItIsPending();
                    session.setAttribute("reports", updatedReports);
                    request.setAttribute("message", "Reject Succesfully");
                    request.getRequestDispatcher("/view/admin/adminReceiveReports.jsp").forward(request, response);
                    
                } else {
                    response.sendRedirect(request.getContextPath() + "/view/admin.jsp");
                    response.getWriter().print("Fail");
                }
                break;

            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

}