/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.PrintWriter;
import model.Users;
import dao.AppealDAO;
import dao.ViolationsDAO;
import jakarta.servlet.http.Part;
import model.Appeals;

import model.Users;
import model.Reports;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;

/**
 *
 * @author im_chur
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AppealServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AppealServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AppealServlet at " + request.getContextPath() + "</h1>");
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

        try {
            int violationID = Integer.parseInt(request.getParameter("violationID"));
            int amount = Integer.parseInt(request.getParameter("amount"));

            if (amount <= 0) {
                request.setAttribute("error", "Vui lòng nhập đúng số tiền");
                request.getRequestDispatcher("/view/payment.jsp").forward(request, response);
                return;
            }

            int fineAmount = ViolationsDAO.getFineAmoutFromViolations(violationID);

            if (amount == fineAmount) {
                if (ViolationsDAO.processPayment(violationID)) {
                    request.setAttribute("message", "Chúc mừng, thanh toán thành công");
                    request.getRequestDispatcher("/view/home.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/view/payment.jsp?violationID=" + violationID + "&error=1");
                }
            } else {
                request.setAttribute("message", "Xin lỗi, thanh toán thất bại do bạn chưa nhập đúng số tiền");
                request.getRequestDispatcher("/view/home.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Vui lòng nhập số hợp lệ");
            request.getRequestDispatcher("/view/payment.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        if ("appeal".equals(action)) {
            HttpSession session = request.getSession();
            Users user = (Users) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            int violationID = Integer.parseInt(request.getParameter("violationID"));
            int violatorID = user.getUserID();
            String appealText = request.getParameter("appealText");
            Date appealDate = new Date();

            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists() && !uploadDir.mkdir()) {
                request.setAttribute("error", "Failed to create upload directory.");
                request.getRequestDispatcher("/view/appeal.jsp").forward(request, response);
                return;
            }

            Part imagePart = request.getPart("imageFile");
            Part videoPart = request.getPart("videoFile");

            if (imagePart == null || imagePart.getSubmittedFileName().isEmpty()) {
                request.setAttribute("error", "Image is required.");
                request.getRequestDispatcher("/view/appeal.jsp").forward(request, response);
                return;
            }

            if (videoPart == null || videoPart.getSubmittedFileName().isEmpty()) {
                request.setAttribute("error", "Video is required.");
                request.getRequestDispatcher("/view/appeal.jsp").forward(request, response);
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
                request.getRequestDispatcher("/view/appeal.jsp").forward(request, response);
                return;
            }

            Appeals appeal =  new Appeals(0, violationID, violatorID, appealText, new Date(), "Pending", null, null, imageName, videoName);

            boolean success = AppealDAO.sendAppeal(appeal);
            if (success) {
                request.setAttribute("message", "Gửi kháng nghị thành công ! Chúc mừng !!!!");
                request.getRequestDispatcher("/view/home.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Gửi kháng nghị thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher("/view/appeal.jsp").forward(request, response);
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
