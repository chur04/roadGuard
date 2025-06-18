<%-- 
    Document   : payment
    Created on : 16 thg 3, 2025, 02:09:41
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    String violationIDStr = request.getParameter("violationID");
    int violationID = 0; // Giá trị mặc định

    if (violationIDStr != null && !violationIDStr.isEmpty()) {
        try {
            violationID = Integer.parseInt(violationIDStr);
        } catch (NumberFormatException e) {
            violationID = -1; // Gán -1 nếu lỗi (có thể dùng để hiển thị thông báo lỗi)
        }
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh Toán Vi Phạm - RoadGuard Việt Nam</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/payment.css?v=1">
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
            <div class="payment-container">
                <h2>Thanh Toán Vi Phạm</h2>

                <form action="${pageContext.request.contextPath}/Appeal" method="GET"> <!-- Sửa action để đúng với chức năng thanh toán -->
                    <input type="hidden" name="violationID" value="<%= violationID %>">
                    <div class="form-group">
                        <label for="amount">Nhập số tiền:</label>
                        <input type="number" id="amount" name="amount" min="0" step="1000" required>
                    </div>
                    <button type="submit" class="submit-btn">Xác nhận thanh toán</button>
                </form>

                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="error-message">
                        <p><i><%= error %></i></p>
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