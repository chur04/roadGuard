<%-- 
    Document   : viewInformationDontHaveVehicle
    Created on : 20 thg 3, 2025, 00:16:27
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông Tin Người Dùng Không Có Phương Tiện - RoadGuard Việt Nam</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/viewInformationDontHaveVehicle.css?v=1">
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
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewNotifications">Thông báo</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="info-container">
            <h2>Người Dùng Đang Không Có Phương Tiện</h2>

            <c:choose>
                <c:when test="${not empty userDontHaveVehicles}">
                    <table border="1">
                        <tr>
                            <th>Họ và Tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Địa chỉ</th>
                            
                        </tr>
                        <tr>
                            <td>${userDontHaveVehicles.fullName}</td>
                            <td>${userDontHaveVehicles.email}</td>
                            <td>${userDontHaveVehicles.phone}</td>
                            <td>${userDontHaveVehicles.address}</td>
                            
                        </tr>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-info-message">
                        <p>Không có người dùng nào không có phương tiện.</p>
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