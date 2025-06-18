<%-- 
    Document   : home
    Created on : 4 thg 3, 2025, 23:46:18
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - RoadGuard Việt Nam</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css?v=6">
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
                <li><a href="${pageContext.request.contextPath}/view/sendReport.jsp">Gửi phản ánh</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewHistoryReport">Lịch sử phản ánh</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewHistoryViolation">Lịch sử vi phạm</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewViolationWaitPaid">Vi phạm chờ xử lí</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryAppeal?action=view">Theo dõi kháng nghị</a></li>
                <li><a href="${pageContext.request.contextPath}/ReceiveHistoryReport?action=viewNotifications">Thông báo</a></li>
            </ul>
        </div>
    </nav>

    <main class="main-content">
        <header class="hero">
            <h1>Chào mừng đến với RoadGuard Việt Nam</h1>
            <p>Nơi bạn có thể phản ánh vi phạm giao thông nhanh chóng và hiệu quả.</p>
            <a class="cta-btn" href="${pageContext.request.contextPath}/view/sendReport.jsp">Gửi phản ánh ngay</a>
        </header>

        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
        <div id="notification" class="notification">
            <%= message %>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let notification = document.getElementById("notification");
                if (notification) {
                    setTimeout(() => {
                        notification.style.opacity = "1";
                    }, 200);
                    setTimeout(() => {
                        notification.style.opacity = "0";
                    }, 7000);
                }
            });
        </script>
        <% } %>

        <section class="features">
            <div class="feature">
                <h2>Phản ánh dễ dàng</h2>
                <p>Gửi thông tin vi phạm giao thông chỉ với vài bước đơn giản.</p>
            </div>
            <div class="feature">
                <h2>Theo dõi xử lý</h2>
                <p>Cập nhật trạng thái phản ánh của bạn nhanh chóng.</p>
            </div>
            <div class="feature">
                <h2>Thanh toán trực tuyến</h2>
                <p>Nộp phạt dễ dàng, tiết kiệm thời gian.</p>
            </div>
        </section>

        <!-- Thêm section Tin tức Giao thông -->
        <section class="news-section">
            <h2 class="section-title">Tin tức Giao thông</h2>
            <div class="news-container">
                <div class="news-item">
                    <img src="https://tapchigiaothong.qltns.mediacdn.vn/tapchigiaothong.vn/files/content/2022/06/30/hinh-7-1102.jpg" alt="Giảm Ùn Tắc TP.HCM">
                    <h3>Giảm Ùn Tắc Giao Thông tại TP.HCM</h3>
                    <p>Chính quyền TP.HCM vừa triển khai thêm 10 camera giám sát mới để giảm ùn tắc tại các khu vực trung tâm, cải thiện lưu thông trên các tuyến đường chính.</p>
                </div>
                <div class="news-item">
                    <img src="https://tl.cdnchinhphu.vn/344445545208135680/2025/1/17/e2b6d522-ae0b-4ddc-a389-41730d5067ea-17370844879101710068574.jpg" alt="Chiến dịch An Toàn 2025">
                    <h3>Chiến dịch An Toàn Giao Thông 2025</h3>
                    <p>Chương trình an toàn giao thông sẽ bắt đầu từ ngày 15/6 với nhiều hoạt động nâng cao ý thức, bao gồm tuần lễ tuyên truyền trên toàn quốc.</p>
                </div>
            </div>
        </section>

        <!-- Thêm section Thống kê Giao thông -->
        
    </main>

    

    <footer class="footer">
        <p>© 2025 RoadGuard Việt Nam. Đã đăng ký bản quyền.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
</body>
</html>