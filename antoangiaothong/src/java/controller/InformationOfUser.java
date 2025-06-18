/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Users;
import model.VehicleUser;

/**
 *
 * @author im_chur
 */
public class InformationOfUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InformationOfUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InformationOfUser at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        switch (action) {
            case "viewInfor":
                int userID = user.getUserID();
                List<VehicleUser> vehicleUsers = VehiclesDAO.getInformationByUserID(userID);
                
                if (vehicleUsers.isEmpty()) {
                    Users userDontHaveVehicles = UsersDAO.getUserIfDontHaveVehicle(userID) ; 
                    request.setAttribute("userDontHaveVehicles", userDontHaveVehicles);
                    request.getRequestDispatcher("view/viewInformationDontHaveVehicle.jsp").forward(request, response);
                } else {
                    request.setAttribute("vehicleUsers", vehicleUsers);
                    request.getRequestDispatcher("view/viewInformation.jsp").forward(request, response);
                }

                
                break;

            case "Update":
                String phone = request.getParameter("phone");
                
                String address = request.getParameter("address");
                
                boolean updated = UsersDAO.updateUserInfo(user.getUserID(), phone, address);
                if (updated) {
                    request.setAttribute("message", "Cập nhật thành công");
                    request.getRequestDispatcher("/view/home.jsp").forward(request, response);
                    
                } else {
                    request.setAttribute("errorMessage", "Cập nhật thất bại");
                    request.getRequestDispatcher("/view/updateInfor.jsp").forward(request, response);
                }

               
                
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
