/*
 * Click nfs://.netbeans.org/filesystem/16.0.0/org-netbeans-modules-web-project.jar!/Templates/Licenses/license-default.txt to change this license
 * Click nfs://.netbeans.org/editors/16.0.0/org-netbeans-modules-editor-indent-jsp.xml to edit this template
 */
package controller;

import dao.UsersDAO;
import dao.VehiclesDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Users;
import model.Vehicles;

public class AdminReceiveInformationOfUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminReceiveInformationOfUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminReceiveInformationOfUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Users> userList = UsersDAO.AdminGetAllUser();
        if (userList != null) {
            request.setAttribute("users", userList);
            request.getRequestDispatcher("/view/admin/viewUsersInfomation.jsp").forward(request, response);
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