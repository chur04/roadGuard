/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nfs://.netbeans.org/editors/16.0.0/org-netbeans-modules-editor-indent-jsp.xml to edit this template
 */
package controller;

import dao.AppealDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ViolationUser;
import dao.ViolationsDAO;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author im_chur
 */
public class AdminActionAppeal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminActionAppeal</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminActionAppeal at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int violationID = Integer.parseInt(request.getParameter("violationID"));
        int appealID = Integer.parseInt(request.getParameter("id"));
        switch (action) {
            case "view":

                ArrayList<ViolationUser> violationusers = ViolationsDAO.getViolationHaveAppealByViolationsID(violationID);
                request.getSession().setAttribute("violationusers", violationusers);
                request.getRequestDispatcher("/view/admin/viewReportOfAppeal.jsp").forward(request, response);

                break;

            case "response":
                request.setAttribute("violationID", violationID);
                request.setAttribute("appealID", appealID);
                request.getRequestDispatcher("/view/admin/responseAppeal.jsp").forward(request, response);
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int appealID = Integer.parseInt(request.getParameter("appealID"));
            int violationID = Integer.parseInt(request.getParameter("violationID"));
            String status = request.getParameter("status");
            String adminResponse = request.getParameter("adminResponse");

            if (status.equalsIgnoreCase("Approved")) {
                boolean result = AppealDAO.updateAppeal(appealID, status, adminResponse, new Date());
                boolean check = ViolationsDAO.setStatusfor_1(violationID);
                if (result && check ) {

                    request.getSession().removeAttribute("pendingAppeals");
                    request.setAttribute("message", "Appeal updated successfully!");
                } else {
                    request.setAttribute("message", "Failed to update appeal.");
                }
            } else {
                boolean result = AppealDAO.updateAppeal(appealID, status, adminResponse, new Date());
                if (result) {

                    request.getSession().removeAttribute("pendingAppeals");
                    request.setAttribute("message", "Appeal updated successfully!");
                } else {
                    request.setAttribute("message", "Failed to update appeal.");
                }
            }

            request.getSession().setAttribute("pendingAppeals", AppealDAO.getAllAppealIfItIsPending());
            request.getRequestDispatcher("/view/admin/adminReceiveAppeals.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error occurred.");
            request.getRequestDispatcher("/view/admin.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}