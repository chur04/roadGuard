<%-- 
    Document   : viewUsersInfomation
    Created on : 16 thg 3, 2025, 23:43:04
    Author     : im_chur
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Người Dùng - Cyberpunk Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary: #00f3ff;
                --primary-dark: #00a2b3;
                --secondary: #ff00a0;
                --accent: #fffc00;
                --dark: #0a0a20;
                --darker: #050510;
                --light: #e0e0ff;
                --card-bg: rgba(10, 10, 32, 0.7);
                --sidebar-width: 280px;
                --header-height: 70px;
                --success: #00ff66;
                --danger: #ff3860;
                --warning: #ffdd57;
                --info: #00d1ff;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Roboto', sans-serif;
            }

            body {
                background-color: var(--darker);
                color: var(--light);
                background-image:
                    radial-gradient(circle at 20% 35%, rgba(0, 243, 255, 0.15) 0%, transparent 40%),
                    radial-gradient(circle at 75% 65%, rgba(255, 0, 160, 0.15) 0%, transparent 40%);
                min-height: 100vh;
                overflow-x: hidden;
            }

            /* Glowing text effect */
            .glow-text {
                text-shadow: 0 0 5px var(--primary), 0 0 10px var(--primary);
            }

            .highlight-text {
                color: var(--primary);
                text-shadow: 0 0 5px var(--primary), 0 0 10px var(--primary);
            }

            /* Admin Wrapper */
            .admin-wrapper {
                display: flex;
                min-height: 100vh;
                position: relative;
                overflow-x: hidden;
            }

            /* Sidebar */
            .sidebar {
                width: var(--sidebar-width);
                background: linear-gradient(135deg, rgba(10, 10, 32, 0.95), rgba(5, 5, 16, 0.98));
                border-right: 1px solid rgba(0, 243, 255, 0.2);
                box-shadow: 5px 0 25px rgba(0, 243, 255, 0.1);
                padding: 20px;
                display: flex;
                flex-direction: column;
                z-index: 100;
                position: fixed;
                height: 100vh;
                transition: transform 0.3s ease;
            }

            .sidebar-collapsed .sidebar {
                transform: translateX(-100%);
            }

            .logo-container {
                margin-bottom: 30px;
                padding: 10px 0;
                text-align: center;
            }

            .logo {
                position: relative;
                display: inline-block;
                padding: 10px 15px;
                border: 2px solid var(--primary);
                border-radius: 5px;
                overflow: hidden;
            }

            .logo-glow {
                position: absolute;
                top: 0;
                left: -100%;
                width: 50px;
                height: 100%;
                background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(0, 243, 255, 0.3),
                    transparent
                    );
                animation: logo-glow 3s infinite;
            }

            @keyframes logo-glow {
                0% {
                    left: -100%;
                }
                50% {
                    left: 100%;
                }
                100% {
                    left: 100%;
                }
            }

            .cyber-text {
                font-family: 'Orbitron', sans-serif;
                font-weight: 700;
                font-size: 18px;
                color: var(--primary);
                letter-spacing: 1px;
            }

            .admin-text {
                font-family: 'Orbitron', sans-serif;
                font-weight: 500;
                font-size: 18px;
                color: var(--light);
                letter-spacing: 1px;
            }

            .nav-links {
                list-style: none;
                margin-bottom: auto;
            }

            .nav-links li {
                margin-bottom: 5px;
                position: relative;
            }

            .nav-links a {
                display: flex;
                align-items: center;
                padding: 12px 15px;
                text-decoration: none;
                color: var(--light);
                border-radius: 5px;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .nav-links a i {
                margin-right: 12px;
                font-size: 18px;
                width: 24px;
                text-align: center;
                color: var(--primary);
                transition: all 0.3s ease;
            }

            .nav-links a span {
                position: relative;
                z-index: 2;
            }

            .nav-links a .hover-effect {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, rgba(0, 243, 255, 0.1), transparent);
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }

            .nav-links a:hover {
                color: #fff;
            }

            .nav-links a:hover i {
                color: var(--accent);
            }

            .nav-links a:hover .hover-effect {
                transform: translateX(0);
            }

            .nav-links li.active a {
                background: rgba(0, 243, 255, 0.1);
                box-shadow: 0 0 10px rgba(0, 243, 255, 0.2);
            }

            .nav-links li.active a::before {
                content: '';
                position: absolute;
                left: 0;
                top: 0;
                height: 100%;
                width: 3px;
                background: var(--primary);
                box-shadow: 0 0 10px var(--primary);
            }

            /* Main Content */
            .main-content {
                flex: 1;
                margin-left: var(--sidebar-width);
                transition: margin 0.3s ease;
            }

            .sidebar-collapsed .main-content {
                margin-left: 0;
            }

            /* Header */
            header {
                height: var(--header-height);
                background: rgba(10, 10, 32, 0.8);
                backdrop-filter: blur(10px);
                border-bottom: 1px solid rgba(0, 243, 255, 0.2);
                position: sticky;
                top: 0;
                z-index: 99;
            }

            .header-content {
                display: flex;
                align-items: center;
                height: 100%;
                padding: 0 20px;
            }

            .menu-btn {
                background: none;
                border: none;
                color: var(--primary);
                font-size: 20px;
                cursor: pointer;
                width: 40px;
                height: 40px;
                border-radius: 5px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s;
                margin-right: 15px;
            }

            .menu-btn:hover {
                background: rgba(0, 243, 255, 0.1);
            }

            .page-title {
                font-family: 'Orbitron', sans-serif;
                font-size: 20px;
                color: var(--light);
                margin: 0;
                flex: 1;
            }

            .header-actions {
                display: flex;
            }

            .action-btn {
                background: none;
                border: none;
                color: var(--light);
                font-size: 18px;
                cursor: pointer;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-left: 10px;
                position: relative;
                transition: all 0.3s;
            }

            .action-btn:hover {
                background: rgba(0, 243, 255, 0.1);
                color: var(--primary);
            }

            /* Content Area */
            .content-area {
                padding: 20px;
            }

            .page-header {
                margin-bottom: 20px;
                padding: 20px;
                background: var(--card-bg);
                border-radius: 10px;
                border: 1px solid rgba(0, 243, 255, 0.2);
                position: relative;
                overflow: hidden;
            }

            .page-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(135deg, rgba(0, 243, 255, 0.1), transparent);
                z-index: 0;
            }

            .page-header h1 {
                font-family: 'Orbitron', sans-serif;
                font-size: 28px;
                margin-bottom: 10px;
                position: relative;
                z-index: 1;
            }

            .page-header p {
                color: rgba(224, 224, 255, 0.8);
                position: relative;
                z-index: 1;
            }

            /* Filter Bar */
            .filter-bar {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                padding: 15px;
                background: var(--card-bg);
                border-radius: 10px;
                border: 1px solid rgba(0, 243, 255, 0.2);
                flex-wrap: wrap;
                gap: 10px;
            }

            .search-input {
                flex: 1;
                min-width: 200px;
                position: relative;
            }

            .search-input input {
                width: 100%;
                padding: 10px 15px 10px 40px;
                border-radius: 20px;
                border: 1px solid rgba(0, 243, 255, 0.3);
                background: rgba(10, 10, 32, 0.6);
                color: var(--light);
                font-size: 14px;
                transition: all 0.3s;
            }

            .search-input input:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 10px rgba(0, 243, 255, 0.3);
            }

            .search-input i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: rgba(224, 224, 255, 0.7);
            }

            .filter-dropdown {
                position: relative;
                margin-left: 10px;
            }

            .filter-dropdown select {
                padding: 10px 35px 10px 15px;
                border-radius: 20px;
                border: 1px solid rgba(0, 243, 255, 0.3);
                background: rgba(10, 10, 32, 0.6);
                color: var(--light);
                font-size: 14px;
                appearance: none;
                cursor: pointer;
                transition: all 0.3s;
            }

            .filter-dropdown select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 10px rgba(0, 243, 255, 0.3);
            }

            .filter-dropdown::after {
                content: '\f078';
                font-family: 'Font Awesome 5 Free';
                font-weight: 900;
                position: absolute;
                right: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: rgba(224, 224, 255, 0.7);
                pointer-events: none;
            }

            /* Data Table */
            .data-table-container {
                background: var(--card-bg);
                border-radius: 10px;
                border: 1px solid rgba(0, 243, 255, 0.2);
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                margin-bottom: 20px;
            }

            .data-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                color: var(--light);
            }

            .data-table th {
                background: rgba(0, 243, 255, 0.1);
                padding: 15px;
                text-align: left;
                font-family: 'Orbitron', sans-serif;
                font-weight: 500;
                font-size: 14px;
                color: var(--primary);
                border-bottom: 1px solid rgba(0, 243, 255, 0.2);
                position: relative;
            }

            .data-table th:after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                height: 1px;
                background: linear-gradient(90deg, var(--primary), transparent);
            }

            .data-table td {
                padding: 12px 15px;
                border-bottom: 1px solid rgba(0, 243, 255, 0.1);
                font-size: 14px;
            }

            .data-table tr:last-child td {
                border-bottom: none;
            }

            .data-table tr {
                transition: all 0.3s;
            }

            .data-table tr:hover {
                background: rgba(0, 243, 255, 0.05);
            }

            .data-table tr:hover td {
                color: #fff;
            }

            /* Role Badge */
            .role-badge {
                display: inline-block;
                padding: 4px 8px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                text-align: center;
            }

            .role-admin {
                background: rgba(255, 56, 96, 0.2);
                color: var(--danger);
                border: 1px solid var(--danger);
            }

            .role-user {
                background: rgba(0, 209, 255, 0.2);
                color: var(--info);
                border: 1px solid var(--info);
            }

            .role-police {
                background: rgba(0, 255, 102, 0.2);
                color: var(--success);
                border: 1px solid var(--success);
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                gap: 5px;
                flex-wrap: wrap;
            }

            .btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 8px 12px;
                border-radius: 5px;
                font-size: 13px;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.3s;
                border: none;
                cursor: pointer;
                position: relative;
                overflow: hidden;
            }

            .btn i {
                margin-right: 5px;
                font-size: 14px;
            }

            .btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.2),
                    transparent
                    );
                transition: all 0.3s;
            }

            .btn:hover::before {
                left: 100%;
            }

            .btn-view {
                background: rgba(0, 209, 255, 0.2);
                color: var(--info);
                border: 1px solid var(--info);
            }

            .btn-view:hover {
                background: rgba(0, 209, 255, 0.3);
                box-shadow: 0 0 10px rgba(0, 209, 255, 0.5);
            }

            .btn-violation {
                background: rgba(255, 221, 87, 0.2);
                color: var(--warning);
                border: 1px solid var(--warning);
            }

            .btn-violation:hover {
                background: rgba(255, 221, 87, 0.3);
                box-shadow: 0 0 10px rgba(255, 221, 87, 0.5);
            }

            .btn-delete {
                background: rgba(255, 56, 96, 0.2);
                color: var(--danger);
                border: 1px solid var(--danger);
            }

            .btn-delete:hover {
                background: rgba(255, 56, 96, 0.3);
                box-shadow: 0 0 10px rgba(255, 56, 96, 0.5);
            }

            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination-item {
                margin: 0 5px;
            }

            .pagination-link {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 36px;
                height: 36px;
                border-radius: 5px;
                background: var(--card-bg);
                border: 1px solid rgba(0, 243, 255, 0.2);
                color: var(--light);
                text-decoration: none;
                transition: all 0.3s;
            }

            .pagination-link:hover {
                background: rgba(0, 243, 255, 0.1);
                border-color: var(--primary);
            }

            .pagination-link.active {
                background: rgba(0, 243, 255, 0.2);
                border-color: var(--primary);
                color: var(--primary);
                box-shadow: 0 0 10px rgba(0, 243, 255, 0.3);
            }

            /* Back Button */
            .back-btn {
                display: inline-flex;
                align-items: center;
                padding: 10px 20px;
                background: rgba(0, 243, 255, 0.1);
                border: 1px solid var(--primary);
                border-radius: 5px;
                color: var(--primary);
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: all 0.3s;
                margin-top: 20px;
                position: relative;
                overflow: hidden;
            }

            .back-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(
                    90deg,
                    transparent,
                    rgba(255, 255, 255, 0.2),
                    transparent
                    );
                transition: all 0.3s;
            }

            .back-btn:hover {
                background: rgba(0, 243, 255, 0.2);
                box-shadow: 0 0 15px rgba(0, 243, 255, 0.3);
            }

            .back-btn:hover::before {
                left: 100%;
            }

            .back-btn i {
                margin-right: 8px;
            }

            /* Truncate long text */
            .truncate {
                max-width: 150px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            /* Modal */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(5, 5, 16, 0.8);
                z-index: 1000;
                backdrop-filter: blur(5px);
            }

            .modal-content {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: var(--card-bg);
                padding: 25px;
                border-radius: 10px;
                border: 1px solid rgba(0, 243, 255, 0.3);
                box-shadow: 0 0 30px rgba(0, 243, 255, 0.2);
                max-width: 500px;
                width: 90%;
            }

            .modal-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid rgba(0, 243, 255, 0.2);
            }

            .modal-title {
                font-family: 'Orbitron', sans-serif;
                font-size: 20px;
                color: var(--primary);
            }

            .modal-close {
                background: none;
                border: none;
                color: var(--light);
                font-size: 18px;
                cursor: pointer;
                transition: all 0.3s;
            }

            .modal-close:hover {
                color: var(--primary);
            }

            .modal-body {
                margin-bottom: 20px;
            }

            .modal-footer {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }

            /* Responsive */
            @media (max-width: 992px) {
                .sidebar {
                    transform: translateX(-100%);
                }

                .main-content {
                    margin-left: 0;
                }

                .admin-wrapper.sidebar-open .sidebar {
                    transform: translateX(0);
                }
            }

            @media (max-width: 768px) {
                .data-table-container {
                    overflow-x: auto;
                }

                .data-table {
                    min-width: 800px;
                }

                .filter-bar {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-dropdown {
                    margin-left: 0;
                    margin-top: 10px;
                }

                .action-buttons {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <div class="admin-wrapper">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="logo-container">
                    <div class="logo">
                        <div class="logo-glow"></div>
                        <span class="cyber-text">CYBER</span>
                        <span class="admin-text">ADMIN</span>
                    </div>
                </div>

                <ul class="nav-links">
                    <li>
                        <a >
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                            <span class="hover-effect"></span>
                        </a>
                    </li>
                    <li>
                        <a >
                            <i class="fas fa-flag"></i>
                            <span>Quản lý phản ánh</span>
                            <span class="hover-effect"></span>
                        </a>
                    </li>
                    <li>
                        <a >
                            <i class="fas fa-gavel"></i>
                            <span>Quản lý khiếu nại</span>
                            <span class="hover-effect"></span>
                        </a>
                    </li>
                    <li class="active">
                        <a >
                            <i class="fas fa-users"></i>
                            <span>Quản lý người dùng</span>
                            <span class="hover-effect"></span>
                        </a>
                    </li>
                    <li>
                        <a >
                            <i class="fas fa-bell"></i>
                            <span>Thông báo</span>
                            <span class="hover-effect"></span>
                        </a>
                    </li>
                    <li>
                        <a href="/antoangiaothong/Logout">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                            <span class="hover-effect"></span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main content -->
            <div class="main-content">
                <header>
                    <div class="header-content">
                        <button id="sidebar-toggle" class="menu-btn">
                            <i class="fas fa-bars"></i>
                        </button>
                        <h1 class="page-title">Quản Lý Người Dùng</h1>
                        <div class="header-actions">
                            <button class="action-btn">
                                <i class="fas fa-bell"></i>
                            </button>
                            <button class="action-btn">
                                <i class="fas fa-cog"></i>
                            </button>
                        </div>
                    </div>
                </header>

                <div class="content-area">
                    <div class="page-header">
                        <h1>Danh sách người dùng</h1>
                        <p>Quản lý thông tin và quyền truy cập của người dùng trong hệ thống.</p>
                    </div>

                    <div class="filter-bar">
                        <div class="search-input">
                            <i class="fas fa-search"></i>
                            <input type="text" id="searchInput" placeholder="Tìm kiếm người dùng...">
                        </div>
                        <div class="filter-dropdown">
                            <select id="roleFilter">
                                <option value="all">Tất cả vai trò</option>
                                
                            </select>
                        </div>
                    </div>

                    <div class="data-table-container">
                        <table class="data-table" id="usersTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Họ và Tên</th>
                                    <th>Email</th>
                                    <th>Số Điện Thoại</th>
                                    <th>Địa Chỉ</th>
                                    <th>Vai Trò</th>
                                    <th>Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td>${user.userID}</td>
                                        <td>${user.fullName}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td class="truncate">${user.address}</td>
                                        <td>
                                            <span class="role-badge ${user.role == 'admin' ? 'role-admin' : user.role == 'police' ? 'role-police' : 'role-user'}">
                                                ${user.role}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/AdminActionInformationUser?action=viewVehicle&userID=${user.userID}">View Vehicles User Have</a>
                                            <a href="${pageContext.request.contextPath}/AdminActionInformationUser?action=viewViolation&userID=${user.userID}">View Violations Of This User</a>
                                            <a href="${pageContext.request.contextPath}/AdminActionInformationUser?action=deleteUser&userID=${user.userID}">Delete User</a>
                                        </td>

                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="pagination">
                        <div class="pagination-item">
                            <a href="#" class="pagination-link">
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </div>
                        <div class="pagination-item">
                            <a href="#" class="pagination-link active">1</a>
                        </div>
                        <div class="pagination-item">
                            <a href="#" class="pagination-link">2</a>
                        </div>
                        <div class="pagination-item">
                            <a href="#" class="pagination-link">3</a>
                        </div>
                        <div class="pagination-item">
                            <a href="#" class="pagination-link">
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/view/admin.jsp" class="back-btn">
                        <i class="fas fa-arrow-left"></i> Quay lại Dashboard
                    </a>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div id="deleteModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Xác nhận xóa</h2>
                    <button class="modal-close" onclick="closeModal()">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa người dùng này? Hành động này không thể hoàn tác.</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-view" onclick="closeModal()">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                    <a id="confirmDeleteBtn" href="#" class="btn btn-delete">
                        <i class="fas fa-trash-alt"></i> Xóa
                    </a>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/gsap.min.js"></script>
        <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            // Sidebar toggle
                            const sidebarToggle = document.getElementById('sidebar-toggle');
                            const adminWrapper = document.querySelector('.admin-wrapper');

                            sidebarToggle.addEventListener('click', function () {
                                adminWrapper.classList.toggle('sidebar-collapsed');
                            });

                            // Table row hover effect with GSAP
                            const tableRows = document.querySelectorAll('.data-table tbody tr');
                            tableRows.forEach(row => {
                                row.addEventListener('mouseenter', () => {
                                    gsap.to(row, {
                                        backgroundColor: 'rgba(0, 243, 255, 0.05)',
                                        duration: 0.3
                                    });
                                });

                                row.addEventListener('mouseleave', () => {
                                    gsap.to(row, {
                                        backgroundColor: 'transparent',
                                        duration: 0.3
                                    });
                                });
                            });

                            // Animate table rows on load
                            gsap.from(tableRows, {
                                y: 20,
                                opacity: 0,
                                duration: 0.5,
                                stagger: 0.05,
                                ease: "power2.out"
                            });

                            // Search functionality
                            const searchInput = document.getElementById('searchInput');
                            if (searchInput) {
                                searchInput.addEventListener('input', function () {
                                    const searchTerm = this.value.toLowerCase();

                                    tableRows.forEach(row => {
                                        const text = row.textContent.toLowerCase();
                                        const shouldShow = text.includes(searchTerm);

                                        if (shouldShow) {
                                            row.style.display = '';
                                        } else {
                                            row.style.display = 'none';
                                        }
                                    });
                                });
                            }

                            // Filter by role
                            const roleFilter = document.getElementById('roleFilter');
                            if (roleFilter) {
                                roleFilter.addEventListener('change', function () {
                                    const selectedRole = this.value.toLowerCase();

                                    if (selectedRole === 'all') {
                                        tableRows.forEach(row => {
                                            row.style.display = '';
                                        });
                                        return;
                                    }

                                    tableRows.forEach(row => {
                                        const roleCell = row.querySelector('.role-badge');
                                        if (roleCell) {
                                            const role = roleCell.textContent.trim().toLowerCase();
                                            if (role === selectedRole) {
                                                row.style.display = '';
                                            } else {
                                                row.style.display = 'none';
                                            }
                                        }
                                    });
                                });
                            }

                            // Button hover effects
                            const buttons = document.querySelectorAll('.btn');
                            buttons.forEach(btn => {
                                btn.addEventListener('mouseenter', () => {
                                    gsap.to(btn, {
                                        scale: 1.05,
                                        duration: 0.3
                                    });
                                });

                                btn.addEventListener('mouseleave', () => {
                                    gsap.to(btn, {
                                        scale: 1,
                                        duration: 0.3
                                    });
                                });
                            });

                            // Mobile responsive sidebar
                            function checkWindowSize() {
                                if (window.innerWidth < 992) {
                                    adminWrapper.classList.add('sidebar-collapsed');
                                } else {
                                    adminWrapper.classList.remove('sidebar-collapsed');
                                }
                            }

                            // Check on load
                            checkWindowSize();

                            // Check on resize
                            window.addEventListener('resize', checkWindowSize);
                        });

                        // Modal functions
                        function confirmDelete(userId) {
                            const modal = document.getElementById('deleteModal');
                            const confirmBtn = document.getElementById('confirmDeleteBtn');

                            confirmBtn.href = `${pageContext.request.contextPath}/AdminActionInformationUser?action=deleteUser&userID=${userId}`;

                                    modal.style.display = 'block';

                                    // Animation
                                    gsap.fromTo(modal.querySelector('.modal-content'),
                                            {opacity: 0, y: -50},
                                            {opacity: 1, y: 0, duration: 0.3}
                                    );
                                }

                                function closeModal() {
                                    const modal = document.getElementById('deleteModal');

                                    gsap.to(modal.querySelector('.modal-content'), {
                                        opacity: 0,
                                        y: -50,
                                        duration: 0.3,
                                        onComplete: () => {
                                            modal.style.display = 'none';
                                        }
                                    });
                                }

                                // Close modal if clicked outside
                                window.addEventListener('click', function (event) {
                                    const modal = document.getElementById('deleteModal');
                                    if (event.target === modal) {
                                        closeModal();
                                    }
                                });
        </script>
    </body>
</html>

