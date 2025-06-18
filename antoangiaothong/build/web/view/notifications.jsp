<%-- 
    Document   : notifications
    Created on : 14 thg 3, 2025, 22:56:07
    Author     : im_chur
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Danh Sách Thông Báo - RoadGuard Việt Nam</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/notifications.css?v=1">
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
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewViolationWaitPaid">Vi phạm chờ xử lí</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryAppeal?action=view">Theo dõi kháng nghị</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewNotifications" class="active">Thông báo</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="notification-container">
            <h2>Danh Sách Thông Báo</h2>

            <c:choose>
                <c:when test="${not empty notifications}">
                    <div class="notification-list">
                        <c:forEach var="noti" items="${notifications}">
                            <div class="notification ${noti.isRead ? 'read' : 'unread'}">
                                <p><span class="label">Nội dung:</span> ${noti.message}</p>
                                <c:if test="${not empty noti.plateNumber}">
                                    <p><span class="label">Biển số xe:</span> ${noti.plateNumber}</p>
                                </c:if>
                                <p><span class="label">Ngày gửi:</span> ${noti.sentDate}</p>

                                <c:if test="${!noti.isRead}">
                                    <form action="ReceiveHistoryReport" method="post">
                                        <input type="hidden" name="notificationID" value="${noti.notificationID}">
                                        <button type="submit" class="mark-read-btn">Đánh dấu đã đọc</button>
                                    </form>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-notifications-message">
                        <p>Không có thông báo nào.</p>
                    </div>
                </c:otherwise>
            </c:choose>

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