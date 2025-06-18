<%-- 
    Document   : sendReport
    Created on : 5 thg 3, 2025, 01:34:21
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.VehiclesDAO" %>
<%@page import="model.Users" %>
<%@page import="model.Vehicles" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gửi Phản Ánh - RoadGuard Việt Nam</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/sendReport.css?v=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
</head>
<body>
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
                <li><a href="${pageContext.request.contextPath}/view/sendReport.jsp" class="active">Gửi phản ánh</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewHistoryReport">Lịch sử phản ánh</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewHistoryViolation">Lịch sử vi phạm</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewViolationWaitPaid">Vi phạm chờ xử lí</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryAppeal?action=view">Theo dõi kháng nghị</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewNotifications">Thông báo</a></li>
            </ul>
        </div>
    </nav>

    <main class="main-content">
        <%
            Users user = (Users) session.getAttribute("user");
            int userID = user.getUserID();
            boolean hasVehicle = VehiclesDAO.hasRegisteredVehicle(userID);
            if (!hasVehicle) {
        %>
        <div class="no-vehicle-message">
            <p>Bạn cần đăng ký xe trước khi gửi báo cáo vi phạm.</p>
            <a href="${pageContext.request.contextPath}/view/registerVehicle.jsp">Đăng ký xe ngay</a>
        </div>
        <%
            } else {
        %>
        <div class="form-container">
            <h2>Gửi Phản Ánh Vi Phạm</h2>
            <form action="${pageContext.request.contextPath}/SendReport" method="POST" enctype="multipart/form-data">
                <table>
                    <tr>
                        <td>Loại vi phạm:</td>
                        <td><input type="text" name="violationtype" class="form-control" ></td>
                    </tr>
                    <tr>
                        <td>Mô tả:</td>
                        <td><input type="text" name="description" class="form-control" ></td>
                    </tr>
                    <tr>
                        <td>Biển số xe:</td>
                        <td><input type="text" name="platenumber" class="form-control" ></td>
                    </tr>
                    <tr>
                        <td>Hình ảnh:</td>
                        <td><input type="file" name="image" accept="image/*" class="form-control-file" ></td>
                    </tr>
                    <tr>
                        <td>Video:</td>
                        <td><input type="file" name="video" accept="video/*" class="form-control-file"></td>
                    </tr>
                    <tr>
                        <td>Địa điểm:</td>
                        <td><input type="text" name="location" class="form-control" ></td>
                    </tr>
                </table>

                <div class="form-buttons">
                    <input type="submit" name="action" value="SEND" class="btn btn-primary">
                    <input type="submit" name="action" value="CANCEL" class="btn btn-secondary">
                </div>

                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                <p class="error-message"><i><%= error %></i></p>
                <% } %>
            </form>
        </div>
        <%
            }
        %>
    </main>

    <footer class="footer">
        <p>© 2025 RoadGuard Việt Nam. Đã đăng ký bản quyền.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>