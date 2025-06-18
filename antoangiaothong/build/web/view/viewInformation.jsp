<%-- 
    Document   : viewInformation
    Created on : 15 thg 3, 2025, 01:59:54
    Author     : im_chur
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Thông Tin Người Dùng - RoadGuard Việt Nam</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/viewInformation.css?v=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="header-top">
            <div class="logo">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5o-Sjs5TEBXZccekEqo9tJSwMbBH8MlANaQ&s" alt="RoadGuard Logo" class="logo-img">
                RoadGuard Việt Nam
            </div>
            <details class="user-menu">
                <summary class="user-icon">Xin chào, <span class="user-name"></span> 👤</summary>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/InformationOfUser?action=viewInfor" class="active">Xem thông tin</a></li>
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
            <h2>Thông Tin Chủ Phương Tiện</h2>

            <c:choose>
                <c:when test="${not empty vehicleUsers}">
                    <c:set var="firstVehicle" value="${vehicleUsers[0]}" />
                    <div class="user-info">
                        <p><span class="label">Họ Tên:</span> ${firstVehicle.fullName}</p>
                        <p><span class="label">Email:</span> ${firstVehicle.email}</p>
                        <p><span class="label">Số Điện Thoại:</span> ${firstVehicle.phone}</p>
                    </div>

                    <h3>Danh Sách Phương Tiện</h3>
                    <div class="table-wrapper">
                        <table>
                            <thead>
                                <tr>
                                    <th>Biển Số Xe</th>
                                    <th>Hãng Xe</th>
                                    <th>Mẫu Xe</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="vehicle" items="${vehicleUsers}">
                                    <tr>
                                        <td>${vehicle.plateNumber}</td>
                                        <td>${vehicle.brand}</td>
                                        <td>${vehicle.model}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-info-message">
                        <p>Không tìm thấy thông tin phương tiện.</p>
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