<%-- 
    Document   : signin
    Created on : 4 thg 3, 2025, 23:29:01
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - RoadGuard Việt Nam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/signin.css?v=6">
</head>
<body>
    <div class="container">
        <div class="login-box">
            <h2>Đăng Nhập</h2>
            <form action="Signin" method="POST">
                <div class="input-group">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" placeholder="example@gmail.com" required class="form-control">
                </div>
                
                <div class="input-group">
                    <label for="password" class="form-label">Mật Khẩu</label>
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu của bạn" required class="form-control">
                </div>
                
                <div class="button-group">
                    <input type="submit" name="action" value="SignIn" class="btn btn-primary">
                </div>
                
                <div class="footer-actions">
                    <input type="submit" name="action" value="ForgotPassword" class="btn btn-secondary">
                    <input type="submit" name="action" value="SignUp" class="btn btn-signup">
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