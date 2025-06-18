<%-- 
    Document   : viewUserAppeal
    Created on : 16 thg 3, 2025, 01:18:24
    Author     : im_chur
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Theo Dõi Kháng Nghị - RoadGuard Việt Nam</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/viewUserAppeal.css?v=1">
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
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryAppeal?action=view" class="active">Theo dõi kháng nghị</a></li>
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewNotifications">Thông báo</a></li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            <div class="appeal-container">
                <h2>Theo Dõi Kháng Nghị</h2>

                <c:choose>
                    <c:when test="${empty appeals}">
                        <div class="no-appeals-message">
                            <p>Ồ! Có vẻ như bạn không có kháng nghị nào!!!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-wrapper">
                            <table>
                                <tr>
                                    <th>ID Kháng nghị</th>
                                    <th>ID Vi phạm</th>
                                    
                                    <th>Mô tả</th>
                                    <th>Ngày kháng nghị</th>
                                    <th>Trạng thái</th>
                                    <th>CSGT Phản hồi</th>
                                    <th>Ngày phản hồi</th>
                                    <th>Ảnh</th>
                                    <th>Video</th>
                                </tr>
                                <c:forEach var="appeal" items="${appeals}">
                                    <tr>
                                        <td>${appeal.appealID}</td>
                                        <td>${appeal.violationID}</td>
                                        
                                        <td>${appeal.appealText}</td>
                                        <td>${appeal.appealDate}</td>
                                        <td class="status-${appeal.status.toLowerCase()}">${appeal.status}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty appeal.adminResponse}">Đang chờ xử lý</c:when>
                                                <c:otherwise>${appeal.adminResponse}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty appeal.responseDate}">Đang chờ xử lý</c:when>
                                                <c:otherwise>${appeal.responseDate}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty appeal.imageURL}">
                                                    <a href="uploads/${appeal.imageURL}" target="_blank">Xem ảnh</a>
                                                </c:when>
                                                <c:otherwise>Không có</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty appeal.videoURL}">
                                                    <a href="uploads/${appeal.videoURL}" target="_blank">Xem video</a>
                                                </c:when>
                                                <c:otherwise>Không có</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
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

    </body>
</html>