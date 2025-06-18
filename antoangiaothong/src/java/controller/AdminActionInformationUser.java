/*
 * Click nfs://.netbeans.org/filesystem/16.0.0/org-netbeans-modules-web-project.jar!/Templates/Licenses/license-default.txt to change this license
 * Click nfs://.netbeans.org/editors/16.0.0/org-netbeans-modules-editor-indent-jsp.xml to edit this template
 */
package controller;

import dao.UsersDAO;
import dao.VehiclesDAO;
import dao.ViolationsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Vehicles;
import model.ViolationUser;
import dao.VehiclesDAO ; 
        

/**
 *
 * @author im_chur
 */
public class AdminActionInformationUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminActionInformationUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminActionInformationUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int userID = Integer.parseInt(request.getParameter("userID"));
        switch (action) {
            case "viewVehicle":
                ArrayList<Vehicles> vehicles = new ArrayList<Vehicles>();
                vehicles = VehiclesDAO.AdmingetVehiclesByUserID(userID);
                request.setAttribute("vehicles", vehicles);
                request.getRequestDispatcher("/view/admin/adminViewMoreVehicle.jsp").forward(request, response);
                break;

            case "viewViolation":
                ArrayList<ViolationUser> violationUserList = new ArrayList<ViolationUser>();
                violationUserList = ViolationsDAO.getAllViolationByUserIDIfItPaid(userID);
                request.setAttribute("violationUserList", violationUserList);
                request.getRequestDispatcher("/view/admin/adminViewMoreViolation.jsp").forward(request, response);
                break;

            case "deleteUser":
                boolean delete = UsersDAO.deleteUser(userID) ; 
                if (delete){
                    request.setAttribute("message", "Bạn đã xóa thành công tài khỏan");
                    request.getRequestDispatcher("/view/admin.jsp").forward(request, response); 
                } else {
                    request.setAttribute("message", "Bạn đã xóa thất bại tài khỏan");
                    request.getRequestDispatcher("/view/admin.jsp").forward(request, response);
                }
                break;
                
            case "deleteVehicles": 
                String plateNumber = request.getParameter("plateNumber") ; 
                boolean deleteVehicle = VehiclesDAO.deleteVehicleData(plateNumber) ;
                if (deleteVehicle){
                    request.setAttribute("message", "Bạn đã xóa thành công xe");
                    request.getRequestDispatcher("/view/admin.jsp").forward(request, response); 
                } else {
                    request.setAttribute("message", "Bạn đã xóa thất bại xe");
                    request.getRequestDispatcher("/view/admin.jsp").forward(request, response);
                }
                
                break ; 

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