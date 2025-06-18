<%-- 
    Document   : access-denied
    Created on : 12 thg 3, 2025, 16:55:30
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="error-container">
            <h1>Access Denied</h1>
            <p>Sorry, you don't have permission to access this page.</p>
            <a href="${pageContext.request.contextPath}/view/home.jsp">Quay lại trang chủ</a>
        </div>
    </body>
</html>
