package controller;

import model.Users;
import model.Reports;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.PrintWriter;

import java.util.Date;
import dao.ReportsDAO;
import model.Vehicles;
import dao.VehiclesDAO;

/**
 *
 * @author im_chur
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)

public class SendReportServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SendReportServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendReportServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        response.setCharacterEncoding("UTF-8"); 
        response.setContentType("text/html; charset=UTF-8"); 

        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("SEND")) {
            HttpSession session = request.getSession(false);
            Users user = (Users) session.getAttribute("user");

            if (user == null) {
                request.setAttribute("error", "Session expired. Please log in again.");
                response.sendRedirect("index.jsp");
                return;
            }

            String violationType = request.getParameter("violationtype");
            String description = request.getParameter("description");
            String plateNumber = request.getParameter("platenumber");
            String location = request.getParameter("location");

            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists() && !uploadDir.mkdir()) {
                request.setAttribute("error", "Failed to create upload directory.");
                request.getRequestDispatcher("/view/sendReport.jsp").forward(request, response);
                return;
            }
           
            Part imagePart = request.getPart("image");
            Part videoPart = request.getPart("video");

            if (imagePart == null || imagePart.getSubmittedFileName().isEmpty()) {
                request.setAttribute("error", "Image is required.");
                request.getRequestDispatcher("/view/sendReport.jsp").forward(request, response);
                        return;
            }

            if (videoPart == null || videoPart.getSubmittedFileName().isEmpty()) {
                request.setAttribute("error", "Video is required.");
                request.getRequestDispatcher("/view/sendReport.jsp").forward(request, response);
                return;
            }

            String imageName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String videoName = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();

            String imagePath = uploadPath + File.separator + imageName;
            String videoPath = uploadPath + File.separator + videoName;

            try {
                imagePart.write(imagePath);
                videoPart.write(videoPath);
            } catch (IOException e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to upload files.");
                request.getRequestDispatcher("/view/sendReport.jsp").forward(request, response);
                return;
            }

            Reports report = new Reports(0, user.getUserID(), violationType, description, plateNumber,
                    imageName, videoName, location, new Date(System.currentTimeMillis()),
                    "Pending", null);

            Reports reportSend = ReportsDAO.sendReport(report);
            if (reportSend == null) {
                request.setAttribute("error", "Error submitting report. Please enter exactly plate number.");
                request.getRequestDispatcher("/view/sendReport.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Report submitted successfully.");
                request.getRequestDispatcher("/view/home.jsp").forward(request, response);
            }
        } else if (action.equalsIgnoreCase("CANCEL")) {
            response.sendRedirect(request.getContextPath() + "/view/home.jsp");
        } else if (action.equalsIgnoreCase("REGISTER")) {
            try {
                String brand = request.getParameter("brand");
                String model = request.getParameter("model");
                String plateNumber = request.getParameter("platenumber");
                String manufactureYearStr = request.getParameter("manufactureyear");

                if (brand == null || model == null || plateNumber == null || manufactureYearStr == null
                        || brand.trim().isEmpty() || model.trim().isEmpty() || plateNumber.trim().isEmpty() || manufactureYearStr.trim().isEmpty()) {
                    throw new Exception("Vui lòng nhập đầy đủ thông tin xe.");
                }

                int manufactureYear = Integer.parseInt(manufactureYearStr);
                if (manufactureYear < 1900 || manufactureYear > 2025) {
                    throw new Exception("Năm sản xuất không hợp lệ.");
                }

                HttpSession session = request.getSession();
                Users user = (Users) session.getAttribute("user");
                if (user == null) {
                    response.sendRedirect("index.jsp");
                    return;
                }

                Vehicles vehicle = new Vehicles(0, plateNumber, user.getUserID(), brand, model, manufactureYear);
                if (VehiclesDAO.registerVehicles(vehicle)) {
                    request.setAttribute("message", "Đăng ký xe thành công!");
                    request.getRequestDispatcher("/view/home.jsp").forward(request, response);
                } else {
                    throw new Exception("Đăng ký xe thất bại, vui lòng thử lại.");
                }
            } catch (Exception e) {
                request.setAttribute("errorMessage", e.getMessage());
                request.getRequestDispatcher("/view/registerVehicle.jsp").forward(request, response);
            }

        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
