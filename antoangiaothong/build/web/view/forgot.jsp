<%-- 
    Document   : forgot
    Created on : 5 thg 3, 2025, 00:28:05
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - RoadGuard Việt Nam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/forgot.css?v=1">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
</head>
<body>
    <div class="container">
        <div class="forgot-box">
            <h2>Quên Mật Khẩu</h2>
            <form action="Signin" method="GET">
                <div class="input-group">
                    <label for="email" class="form-label">Nhập email của bạn</label>
                    <input type="email" id="email" name="email" placeholder="example@gmail.com" class="form-control">
                </div>
                <div class="input-group">
                    <label for="phone" class="form-label">Nhập số điện thoại</label>
                    <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại của bạn" class="form-control">
                </div>
                <div class="input-group">
                    <label for="password" class="form-label">Nhập mật khẩu mới</label>
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu mới" class="form-control">
                </div>
                <div class="button-group">
                    <input type="submit" name="action" value="CANCEL" class="btn btn-secondary">
                    <input type="submit" name="action" value="Submit" class="btn btn-primary">
                </div>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <p class="error-message"><i><%= error %></i></p>
                <% } %>
            </form>
        </div>
    </div>
    <footer class="footer">
        <p>© 2025 RoadGuard Việt Nam. Đã đăng ký bản quyền.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>