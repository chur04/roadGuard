<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Danh Sách Vi Phạm - RoadGuard Việt Nam</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ViolationUser.css?v=1">
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
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewHistoryViolation" class="active">Lịch sử vi phạm</a></li>
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewViolationWaitPaid">Vi phạm chờ xử lí</a></li>
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryAppeal?action=view">Theo dõi kháng nghị</a></li>
                    <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewNotifications">Thông báo</a></li>
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            <div class="violation-container">
                <h2>Danh Sách Vi Phạm</h2>

                <c:choose>
                    <c:when test="${not empty violationuser}">
                        <div class="table-wrapper">
                            <table>
                                <tr>
                                    <th>ID Vi phạm</th>
                                    
                                    <th>Loại vi phạm</th>
                                    <th>Mô tả</th>
                                    <th>Ảnh</th>
                                    <th>Video</th>
                                    <th>Địa điểm</th>
                                    <th>Ngày bị tố cáo</th>
                                    <th>Tiền phạt</th>
                                    <th>Ngày thanh toán</th>
                                    <th>Biển số</th>
                                    <th>Trạng thái thanh toán</th>
                                </tr>
                                <c:forEach var="violation" items="${violationuser}">
                                    <tr>
                                        <td>${violation.violationID}</td>
                                        
                                        <td>${violation.violationType}</td>
                                        <td>${violation.description}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty violation.imageURL}">
                                                    <a href="uploads/${violation.imageURL}" target="_blank">Xem ảnh</a>
                                                </c:when>
                                                <c:otherwise>Không có</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty violation.videoURL}">
                                                    <a href="uploads/${violation.videoURL}" target="_blank">Xem video</a>
                                                </c:when>
                                                <c:otherwise>Không có</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${violation.location}</td>
                                        <td>${violation.reportDate}</td>
                                        <td>${violation.fineAmount}</td>
                                        <td>${violation.fineDate}</td>
                                        <td>${violation.plateNumber}</td>   
                                        <td>
                                            <c:choose>
                                                <c:when test="${violation.paidStatus}"> 
                                                    <span class="paid">Đã thanh toán</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="unpaid">Chưa thanh toán</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-violations-message">
                            <p>Ồ! Có vẻ bạn là người rất chấp hành luật giao thông! Chúc mừnggg.</p>
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