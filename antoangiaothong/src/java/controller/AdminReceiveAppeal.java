/*
 * Click nfs://.netbeans.org/filesystem/16.0.0/org-netbeans-modules-web-project.jar!/Templates/Licenses/license-default.txt to change this license
 * Click nfs://.netbeans.org/editors/16.0.0/org-netbeans-modules-editor-indent-jsp.xml to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Appeals;
import dao.AppealDAO;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;

/**
 *
 * @author im_chur
 */
public class AdminReceiveAppeal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminReceiveAppeal</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminReceiveAppeal at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<Appeals> pendingAppeals = (ArrayList<Appeals>) session.getAttribute("pendingAppeals");

        
        if (pendingAppeals == null) {
            pendingAppeals = AppealDAO.getAllAppealIfItIsPending();
            session.setAttribute("pendingAppeals", pendingAppeals);
        }

        request.getRequestDispatcher("/view/admin/adminReceiveAppeals.jsp").forward(request, response);
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