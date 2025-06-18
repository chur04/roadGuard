package controller;

import dao.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Users;

/**
 *
 * @author im_chur
 */
public class SigninServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SigninServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SigninServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {

            case "SignUp":
                doSignUp(request, response);
                break;

            case "Submit": // Tên là submit nhưng case này để đôir pass
                doForgotPassword(request, response);
                break;

            case "CANCEL":
                doCANCEL(request, response);
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {

            case "SignIn":
                doSignIn(request, response);
                break;

            case "SignUp":
                request.getRequestDispatcher("/view/signup.jsp").forward(request, response);
                break;

            case "ForgotPassword":
                request.getRequestDispatcher("/view/forgot.jsp").forward(request, response);
                break;

        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void doSignIn(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/view/signin.jsp").forward(request, response);
            return;
        }

        Users user = UsersDAO.loginByEmailAndPassword(email.trim(), password.trim());
        if (user == null) {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/view/signin.jsp").forward(request, response);
            return;
        }

        request.getSession().setAttribute("user", user);

        switch (user.getRole().toLowerCase()) {
            case "citizen":
                response.sendRedirect(request.getContextPath() + "/view/home.jsp");
                break;
            case "trafficpolice":
                response.sendRedirect(request.getContextPath() + "/view/admin.jsp");
                break;
            default:
                request.setAttribute("error", "Unauthorized role");
                request.getRequestDispatcher("/view/signin.jsp").forward(request, response);
        }
    }

    private void doSignUp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (fullname == null || fullname.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || address == null || address.trim().isEmpty()) {

            request.setAttribute("error", "Signup Failed! All fields are required");
            request.getRequestDispatcher("/view/signup.jsp").forward(request, response);
            return;
        }

        if (UsersDAO.isEmailExist(email.trim())) {
            request.setAttribute("error", "Signup Failed! Email already exists");
            request.getRequestDispatcher("/view/signup.jsp").forward(request, response);
             return;
        }

        Users user = new Users(0, fullname.trim(), email.trim(), password.trim(),
                role == null ? "" : role.trim(), phone.trim(), address.trim());
               user = UsersDAO.signupUser(user);
               
        if (user == null    ) {  
            request.setAttribute("error", "Signup Failed! Please try again.");
            request.getRequestDispatcher("/view/signup.jsp").forward(request, response);
            return;
        }

        
        request.setAttribute("error", "Signup successful! Please login.");
        request.getRequestDispatcher("/view/signin.jsp").forward(request, response);

    }

    private void doForgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        if (email != null) {
            email = email.trim();
        } else {
            email = "";
        }

        if (phone != null) {
            phone = phone.trim();
        } else {
            phone = "";
        }

        if (password != null) {
            password = password.trim();
        } else {
            password = "";
        }

        if (email.isEmpty()) {
            request.setAttribute("error", "Email is required");
            request.getRequestDispatcher("/view/forgot.jsp").forward(request, response);
            return;
        }
        if (phone.isEmpty()) {
            request.setAttribute("error", "Phone number is required");
            request.getRequestDispatcher("/view/forgot.jsp").forward(request, response);
            return;
        }
        if (password.isEmpty()) {
            request.setAttribute("error", "New password is required");
            request.getRequestDispatcher("/view/forgot.jsp").forward(request, response);
            return;
        }

        boolean success = UsersDAO.forGotPassWord(password, email, phone);

        if (success) {
            request.setAttribute("error", "Password reset successful. Please sign in.");
            request.getSession().setAttribute("resetSuccess", "Password reset successful. Please sign in.");
             request.getRequestDispatcher("index.jsp").forward(request, response);

        } else {
            request.setAttribute("error", "Invalid email or phone number");
            request.getRequestDispatcher("/view/forgot.jsp").forward(request, response);
        }
    }

    private void doCANCEL(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("index.jsp").forward(request, response);

    }

}
