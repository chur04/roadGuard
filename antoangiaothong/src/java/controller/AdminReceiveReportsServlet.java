package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Reports;
import model.Users;
import dao.ReportsDAO;
import dao.UsersDAO;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

public class AdminReceiveReportsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminReceiveReportsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminReceiveReportsServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Reports> reports = new ArrayList<Reports>();
        
        reports = ReportsDAO.getAllReportsIfItIsPending();
        if (reports != null) {
            request.getSession().setAttribute("reports", reports);
            request.getRequestDispatcher("/view/admin/adminReceiveReports.jsp").forward(request, response);

        }  
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}