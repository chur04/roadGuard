<%-- 
    Document   : appeal
    Created on : 15 thg 3, 2025, 16:16:31
    Author     : im_chur
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String violationID = request.getParameter("violationID");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kháng Nghị Vi Phạm - RoadGuard Việt Nam</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/appeal.css?v=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
        <meta http-equiv="Pragma" content="no-cache">
        <meta http-equiv="Expires" content="0">
    </head>
    <body>
        <!-- Navbar (Đồng bộ với home.jsp) -->
        <nav class="navbar">
            <div class="header-top">
                <div class="logo">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5o-Sjs5TEBXZccekEqo9tJSwMbBH8MlANaQ&s" alt="RoadGuard Logo" class="logo-img">
                    RoadGuard Việt Nam
                </div>
                <details class="user-menu">
                    <summary class="user-icon">Xin chào, <span class="user-name"></span> 👤</summary>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/InformationOfUser?action=viewInfor">Xem thông tin</a></li>
                        <li><a href="${pageContext.request.contextPath}/view/updateInfor.jsp">Chỉnh sửa thông tin</a></li>
                        <li><a href="${pageContext.request.contextPath}/view/registerVehicle.jsp">Đăng kí xe</a></li>
                        <li><a href="${pageContext.request.contextPath}/Logout">Đăng xuất</a></li>
                        
                    </ul>
                </details>
            </div>

            <div class="menu-container">
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/view/home.jsp">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/view/sendReport.jsp">Gửi phản ánh</a></li>
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewHistoryReport">Lịch sử phản ánh</a></li>
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewHistoryViolation">Lịch sử vi phạm</a></li>
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewViolationWaitPaid" class="active">Vi phạm chờ xử lí</a></li>
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryAppeal?action=view">Theo dõi kháng nghị</a></li>
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewNotifications">Thông báo</a></li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            <div class="appeal-container">
                <h2>Gửi Kháng Nghị Vi Phạm</h2>

                <form action="${pageContext.request.contextPath}/Appeal" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="appeal">
                    <input type="hidden" name="violationID" value="<%= violationID != null ? violationID : "" %>">

                    <div class="form-group">
                        <label for="appealText">Nội dung kháng nghị:</label>
                        <textarea id="appealText" name="appealText" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="imageFile">Hình ảnh minh chứng:</label>
                        <input type="file" id="imageFile" name="imageFile" accept="image/*">
                    </div>

                    <div class="form-group">
                        <label for="videoFile">Video minh chứng:</label>
                        <input type="file" id="videoFile" name="videoFile" accept="video/*">
                    </div>

                    <button type="submit" class="submit-btn">Gửi Kháng Nghị</button>
                </form>

                <% String errorMessage = (String) request.getAttribute("error"); %>
                <% if (errorMessage != null) { %>
                    <div class="error-message">
                        <p><%= errorMessage %></p>
                    </div>
                <% } %>

                <div class="back-button">
                    <a href="${pageContext.request.contextPath}/view/home.jsp">Quay lại trang chủ</a>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer class="footer">
            <p>© 2025 RoadGuard Việt Nam. Đã đăng ký bản quyền.</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    </body>
</html>