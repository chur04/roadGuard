<%-- 
    Document   : signup
    Created on : 5 thg 3, 2025, 00:12:15
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký - RoadGuard Việt Nam</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/signup.css?v=5">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
</head>
<body>
    <div class="container">
        <div class="login-box">
            <h2>Đăng Ký</h2>
            <form action="Signin" method="GET">
                <div class="input-group">
                    <label for="fullname" class="form-label">Họ và Tên</label>
                    <input type="text" id="fullname" name="fullname" placeholder="Nhập họ và tên" class="form-control">
                </div>
                <div class="input-group">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" placeholder="example@gmail.com" class="form-control">
                </div>
                <div class="input-group">
                    <label for="password" class="form-label">Mật Khẩu</label>
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" class="form-control">
                </div>
                <div class="input-group">
                    <label for="role" class="form-label">Vai Trò</label>
                    <select id="role" name="role" class="form-select custom-role-select">
                        <option value="Citizen">Công Dân</option>
                        
                    </select>
                </div>
                <div class="input-group">
                    <label for="phone" class="form-label">Số Điện Thoại</label>
                    <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại" class="form-control">
                </div>
                <div class="input-group">
                    <label for="address" class="form-label">Địa Chỉ</label>
                    <input type="text" id="address" name="address" placeholder="Nhập địa chỉ" class="form-control">
                </div>
                <div class="button-group">
                    <input type="submit" name="action" value="CANCEL" class="btn btn-secondary">
                    <input type="submit" name="action" value="SignUp" class="btn btn-primary">
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const select = document.querySelector('.custom-role-select');
            if (select) {
                const longestOption = Array.from(select.options).reduce((max, option) => 
                    option.text.length > max.text.length ? option : max, select.options[0]).text;
                const minHeight = Math.max(40, longestOption.length * 5); // Ước lượng chiều cao dựa trên độ dài text
                select.style.minHeight = `${minHeight}px`;
                select.style.height = 'auto';
                select.style.maxHeight = 'none';
                select.style.overflow = 'visible';
                select.style.lineHeight = '1.5';
            }
        });
    </script>
</body>
</html>