package filter;

/**
 *
 * @author im_chur
 */
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;
import java.io.IOException;

@WebFilter(filterName = "AdminFilter", urlPatterns = {
    "/view/admin/*", 
    "/view/admin.jsp", 
    "/Adminaction",
    "/AdminReceiveReports",
    "/AdminReceiveAppeal",
    "/AdminActionAppeal",
    "/AdminReceiveInformationOfUser",
    "/AdminActionInformationUser",
    "/AdminDoWithViolation"
})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String contextPath = req.getContextPath();
        
        System.out.println("=== AdminFilter Debug ===");
        System.out.println("Session ID: " + (session != null ? session.getId() : "NULL"));
        
        
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("No session or user found");
            res.sendRedirect(contextPath + "/signin.jsp");
            return;
        }

        Users user = (Users) session.getAttribute("user");
        System.out.println("User Object: " + user);
        System.out.println("User Role: " + (user != null ? "\"" + user.getRole() + "\"" : "NULL"));

        
        if (!"TrafficPolice".equalsIgnoreCase(user.getRole())) {
            System.out.println("Access denied - Not TrafficPolice");
            res.sendRedirect(contextPath + "/view/access-denied.jsp");
            return;
        }

        System.out.println("Access granted - Proceeding");
        chain.doFilter(request, response);
    }
}
