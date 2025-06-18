<%-- 
    Document   : adminViewMoreViolation
    Created on : 17 thg 3, 2025, 00:58:01
    Author     : im_chur
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh Sách Vi Phạm - Cyberpunk Admin</title>
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

            /* User Info Card */
            .user-info-card {
                background: var(--card-bg);
                border-radius: 10px;
                border: 1px solid rgba(0, 243, 255, 0.2);
                padding: 20px;
                margin-bottom: 20px;
                position: relative;
                overflow: hidden;
            }

            .user-info-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(135deg, rgba(255, 0, 160, 0.05), transparent);
                z-index: 0;
            }

            .user-info-header {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
                position: relative;
                z-index: 1;
            }

            .user-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background: var(--primary);
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 15px;
                font-size: 20px;
                color: var(--dark);
                border: 2px solid var(--primary);
                box-shadow: 0 0 15px rgba(0, 243, 255, 0.5);
            }

            .user-details {
                flex: 1;
            }

            .user-name {
                font-family: 'Orbitron', sans-serif;
                font-size: 18px;
                margin-bottom: 5px;
                color: var(--primary);
            }

            .user-id {
                font-size: 14px;
                color: rgba(224, 224, 255, 0.7);
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
                overflow-x: auto;
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
                white-space: nowrap;
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
                vertical-align: middle;
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

            /* Status Badges */
            .status-badge {
                display: inline-block;
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                text-align: center;
            }

            .status-paid {
                background: rgba(0, 255, 102, 0.2);
                color: var(--success);
                border: 1px solid var(--success);
            }

            .status-unpaid {
                background: rgba(255, 56, 96, 0.2);
                color: var(--danger);
                border: 1px solid var(--danger);
            }

            /* Violation Type Badges */
            .violation-badge {
                display: inline-block;
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                text-align: center;
            }

            .violation-speeding {
                background: rgba(255, 56, 96, 0.2);
                color: var(--danger);
                border: 1px solid var(--danger);
            }

            .violation-parking {
                background: rgba(255, 221, 87, 0.2);
                color: var(--warning);
                border: 1px solid var(--warning);
            }

            .violation-signal {
                background: rgba(0, 209, 255, 0.2);
                color: var(--info);
                border: 1px solid var(--info);
            }

            .violation-other {
                background: rgba(224, 224, 255, 0.2);
                color: var(--light);
                border: 1px solid var(--light);
            }

            /* Media Links */
            .media-link {
                display: inline-flex;
                align-items: center;
                padding: 5px 10px;
                background: rgba(0, 243, 255, 0.1);
                border: 1px solid rgba(0, 243, 255, 0.3);
                border-radius: 5px;
                color: var(--primary);
                text-decoration: none;
                font-size: 13px;
                transition: all 0.3s;
            }

            .media-link:hover {
                background: rgba(0, 243, 255, 0.2);
                box-shadow: 0 0 10px rgba(0, 243, 255, 0.3);
            }

            .media-link i {
                margin-right: 5px;
            }

            /* Empty State */
            .empty-state {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px 20px;
                text-align: center;
            }

            .empty-state i {
                font-size: 50px;
                color: rgba(0, 243, 255, 0.3);
                margin-bottom: 20px;
            }

            .empty-state h3 {
                font-family: 'Orbitron', sans-serif;
                font-size: 20px;
                color: var(--primary);
                margin-bottom: 10px;
            }

            .empty-state p {
                color: rgba(224, 224, 255, 0.7);
                max-width: 400px;
                margin-bottom: 20px;
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
                max-width: 800px;
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
                    min-width: 1000px;
                }

                .filter-bar {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-dropdown {
                    margin-left: 0;
                    margin-top: 10px;
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
                        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">
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
                        <a>
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
                        <h1 class="page-title">Danh Sách Vi Phạm</h1>
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
                        <h1>Thông tin vi phạm</h1>
                        <p>Danh sách các vi phạm giao thông của người dùng trong hệ thống.</p>
                    </div>

                    <c:if test="${not empty user}">
                        <div class="user-info-card">
                            <div class="user-info-header">
                                <div class="user-avatar">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="user-details">
                                    <div class="user-name">${user.fullName}</div>
                                    <div class="user-id">ID: ${user.userID} | Email: ${user.email}</div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <div class="filter-bar">
                        <div class="search-input">
                            <i class="fas fa-search"></i>
                            <input type="text" id="searchInput" placeholder="Tìm kiếm vi phạm...">
                        </div>
                        <div class="filter-dropdown">
                            <select id="violationTypeFilter">
                                <option value="all">Tất cả loại vi phạm</option>
                                <option value="Speeding">Vượt tốc độ</option>
                                <option value="Parking">Đỗ xe sai quy định</option>
                                <option value="Signal">Vi phạm tín hiệu</option>
                                <option value="Other">Khác</option>
                            </select>
                        </div>
                        <div class="filter-dropdown">
                            <select id="paidStatusFilter">
                                <option value="all">Tất cả trạng thái</option>
                                
                            </select>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty violationUserList}">
                            <div class="data-table-container">
                                <table class="data-table" id="violationsTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Người vi phạm</th>
                                            <th>Loại vi phạm</th>
                                            <th>Mô tả</th>
                                            <th>Hình ảnh</th>
                                            <th>Video</th>
                                            <th>Địa điểm</th>
                                            <th>Ngày báo cáo</th>
                                            <th>Tiền phạt</th>
                                            <th>Ngày phạt</th>
                                            <th>Biển số xe</th>
                                            <th>Trạng thái</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="violation" items="${violationUserList}">
                                            <tr>
                                                <td>${violation.violationID}</td>
                                                <td>${violation.violatorID}</td>
                                                <td>
                                                    <span class="violation-badge
                                                          ${violation.violationType == 'Speeding' ? 'violation-speeding' : 
                                                            violation.violationType == 'Parking' ? 'violation-parking' : 
                                                            violation.violationType == 'Signal' ? 'violation-signal' : 'violation-other'}">
                                                              ${violation.violationType}
                                                          </span>
                                                    </td>
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
                                                    <td><span class="highlight-text">${violation.fineAmount} VNĐ</span></td>
                                                    <td>${violation.fineDate}</td>
                                                    <td>${violation.plateNumber}</td>   
                                                    <td>
                                                        <span class="status-badge ${violation.paidStatus ? 'status-paid' : 'status-unpaid'}">
                                                            ${violation.paidStatus ? 'Đã thanh toán' : 'Chưa thanh toán'}
                                                        </span>
                                                    </td>

                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="data-table-container">
                                    <div class="empty-state">
                                        <i class="fas fa-check-circle"></i>
                                        <h3>Không có vi phạm nào</h3>
                                        <p>Người dùng này chưa có vi phạm giao thông nào được ghi nhận trong hệ thống.</p>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <a href="${pageContext.request.contextPath}/AdminReceiveInformationOfUser" class="back-btn">
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách người dùng
                        </a>
                    </div>
                </div>
            </div>

            <!-- Image Modal -->
            <div id="imageModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title">Hình ảnh vi phạm</h2>
                        <button class="modal-close" onclick="closeImageModal()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div style="text-align: center;">
                            <img id="modalImage" src="" alt="Hình ảnh vi phạm" style="max-width: 100%; max-height: 500px;">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="back-btn" onclick="closeImageModal()">
                            <i class="fas fa-times"></i> Đóng
                        </button>
                    </div>
                </div>
            </div>

            <!-- Video Modal -->
            <div id="videoModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title">Video vi phạm</h2>
                        <button class="modal-close" onclick="closeVideoModal()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div style="text-align: center;">
                            <video id="modalVideo" controls style="max-width: 100%; max-height: 500px;">
                                <source src="" type="video/mp4">
                                Trình duyệt của bạn không hỗ trợ xem video.
                            </video>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="back-btn" onclick="closeVideoModal()">
                            <i class="fas fa-times"></i> Đóng
                        </button>
                    </div>
                </div>
            </div>

            <!-- Violation Details Modal -->
            <div id="violationDetailsModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title">Chi tiết vi phạm</h2>
                        <button class="modal-close" onclick="closeViolationDetailsModal()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="modal-body" id="violationDetailsContent">
                        <!-- Violation details will be loaded here -->
                    </div>
                    <div class="modal-footer">
                        <button class="back-btn" onclick="closeViolationDetailsModal()">
                            <i class="fas fa-times"></i> Đóng
                        </button>
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
                                        filterTable();
                                    });
                                }

                                // Filter by violation type
                                const violationTypeFilter = document.getElementById('violationTypeFilter');
                                if (violationTypeFilter) {
                                    violationTypeFilter.addEventListener('change', function () {
                                        filterTable();
                                    });
                                }

                                // Filter by paid status
                                const paidStatusFilter = document.getElementById('paidStatusFilter');
                                if (paidStatusFilter) {
                                    paidStatusFilter.addEventListener('change', function () {
                                        filterTable();
                                    });
                                }

                                function filterTable() {
                                    const searchTerm = searchInput.value.toLowerCase();
                                    const selectedType = violationTypeFilter.value.toLowerCase();
                                    const selectedStatus = paidStatusFilter.value.toLowerCase();

                                    tableRows.forEach(row => {
                                        const text = row.textContent.toLowerCase();
                                        const typeCell = row.querySelector('td:nth-child(3)');
                                        const statusCell = row.querySelector('td:nth-child(12)');

                                        let typeMatch = true;
                                        let statusMatch = true;
                                        let searchMatch = text.includes(searchTerm);

                                        if (selectedType !== 'all' && typeCell) {
                                            typeMatch = typeCell.textContent.trim().toLowerCase().includes(selectedType);
                                        }

                                        if (selectedStatus !== 'all' && statusCell) {
                                            const isPaid = statusCell.textContent.trim().toLowerCase().includes('đã thanh toán');
                                            statusMatch = (selectedStatus === 'paid' && isPaid) || (selectedStatus === 'unpaid' && !isPaid);
                                        }

                                        if (searchMatch && typeMatch && statusMatch) {
                                            row.style.display = '';
                                        } else {
                                            row.style.display = 'none';
                                        }
                                    });
                                }

                                // Button hover effects
                                const buttons = document.querySelectorAll('.media-link, .back-btn');
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

                            // View image in modal
                            function viewImage(imageSrc) {
                                const modal = document.getElementById('imageModal');
                                const modalImage = document.getElementById('modalImage');

                                modalImage.src = imageSrc;
                                modal.style.display = 'block';

                                // Animation
                                gsap.fromTo(modal.querySelector('.modal-content'),
                                        {opacity: 0, y: -50},
                                        {opacity: 1, y: 0, duration: 0.3}
                                );
                            }

                            function closeImageModal() {
                                const modal = document.getElementById('imageModal');

                                gsap.to(modal.querySelector('.modal-content'), {
                                    opacity: 0,
                                    y: -50,
                                    duration: 0.3,
                                    onComplete: () => {
                                        modal.style.display = 'none';
                                    }
                                });
                            }

                            // View video in modal
                            function viewVideo(videoSrc) {
                                const modal = document.getElementById('videoModal');
                                const modalVideo = document.getElementById('modalVideo');
                                const videoSource = modalVideo.querySelector('source');

                                videoSource.src = videoSrc;
                                modalVideo.load();
                                modal.style.display = 'block';

                                // Animation
                                gsap.fromTo(modal.querySelector('.modal-content'),
                                        {opacity: 0, y: -50},
                                        {opacity: 1, y: 0, duration: 0.3}
                                );
                            }

                            function closeVideoModal() {
                                const modal = document.getElementById('videoModal');
                                const modalVideo = document.getElementById('modalVideo');

                                modalVideo.pause();

                                gsap.to(modal.querySelector('.modal-content'), {
                                    opacity: 0,
                                    y: -50,
                                    duration: 0.3,
                                    onComplete: () => {
                                        modal.style.display = 'none';
                                    }
                                });
                            }

                            // View violation details
                            function viewViolationDetails(violationId) {
                                const modal = document.getElementById('violationDetailsModal');
                                const contentDiv = document.getElementById('violationDetailsContent');

                                // In a real application, you would fetch violation details from the server
                                // For now, we'll just use placeholder data based on the table
                                const violationRow = document.querySelector(`.data-table tbody tr td:first-child:contains('${violationId}')`).parentNode;
                                if (violationRow) {
                                    const violatorId = violationRow.cells[1].textContent;
                                    const violationType = violationRow.cells[2].textContent.trim();
                                    const description = violationRow.cells[3].textContent;
                                    const location = violationRow.cells[6].textContent;
                                    const reportDate = violationRow.cells[7].textContent;
                                    const fineAmount = violationRow.cells[8].textContent;
                                    const fineDate = violationRow.cells[9].textContent;
                                    const plateNumber = violationRow.cells[10].textContent;
                                    const paidStatus = violationRow.cells[11].textContent.trim();

                                    // Get badge class based on violation type
                                    let badgeClass = 'violation-other';
                                    if (violationType.includes('Speeding')) {
                                        badgeClass = 'violation-speeding';
                                    } else if (violationType.includes('Parking')) {
                                        badgeClass = 'violation-parking';
                                    } else if (violationType.includes('Signal')) {
                                        badgeClass = 'violation-signal';
                                    }

                                    // Get status badge class
                                    const statusBadgeClass = paidStatus.includes('Đã thanh toán') ? 'status-paid' : 'status-unpaid';

                                    contentDiv.innerHTML = `
                            <div style="display: flex; justify-content: center; margin-bottom: 20px;">
                                <div style="font-size: 40px; color: var(--danger);">
                                    <i class="fas fa-exclamation-triangle"></i>
                                </div>
                            </div>
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                                <div>
                                    <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">ID Vi phạm:</p>
                                    <p style="font-weight: 500;">${violationId}</p>
                                </div>
                                <div>
                                    <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">ID Người vi phạm:</p>
                                    <p style="font-weight: 500;">${violatorId}</p>
                                </div>
                                <div>
                                    <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">Loại vi phạm:</p>
                                    <p style="font-weight: 500;"><span class="violation-badge ${badgeClass}">${violationType}</span></p>
                                </div>
                                <div>
                                    <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">Biển số xe:</p>
                                    <p style="font-weight: 500;">${plateNumber}</p>
                                </div>
                                <div>
                                    <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">Địa điểm:</p>
                                    <p style="font-weight: 500;">${location}</p>
                                </div>
                                <div>
                                    <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">Ngày báo cáo:</p>
                                    <p style="font-weight: 500;">${reportDate}</p>
                                </div>
                                <div>
                                    <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">Tiền phạt:</p>
                                    <p style="font-weight: 500; color: var(--primary);">${fineAmount}</p>
                                </div>
                                <div>
                                    <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">Ngày phạt:</p>
                                    <p style="font-weight: 500;">${fineDate}</p>
                                </div>
                                <div>
                                    <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">Trạng thái:</p>
                                    <p style="font-weight: 500;"><span class="status-badge ${statusBadgeClass}">${paidStatus}</span></p>
                                </div>
                            </div>
                            <div style="margin-top: 20px;">
                                <p style="color: rgba(224, 224, 255, 0.7); margin-bottom: 5px;">Mô tả vi phạm:</p>
                                <p style="font-weight: 500; line-height: 1.5;">${description}</p>
                            </div>
                        `;
                                } else {
                                    contentDiv.innerHTML = '<p>Không thể tìm thấy thông tin vi phạm.</p>';
                                }

                                modal.style.display = 'block';

                                // Animation
                                gsap.fromTo(modal.querySelector('.modal-content'),
                                        {opacity: 0, y: -50},
                                        {opacity: 1, y: 0, duration: 0.3}
                                );
                            }

                            function closeViolationDetailsModal() {
                                const modal = document.getElementById('violationDetailsModal');

                                gsap.to(modal.querySelector('.modal-content'), {
                                    opacity: 0,
                                    y: -50,
                                    duration: 0.3,
                                    onComplete: () => {
                                        modal.style.display = 'none';
                                    }
                                });
                            }

                            // Helper function to find element by text content
                            jQuery.expr[':'].contains = function (a, i, m) {
                                return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
                            };

                            // Close modal if clicked outside
                            window.addEventListener('click', function (event) {
                                const imageModal = document.getElementById('imageModal');
                                const videoModal = document.getElementById('videoModal');
                                const violationDetailsModal = document.getElementById('violationDetailsModal');

                                if (event.target === imageModal) {
                                    closeImageModal();
                                }

                                if (event.target === videoModal) {
                                    closeVideoModal();
                                }

                                if (event.target === violationDetailsModal) {
                                    closeViolationDetailsModal();
                                }
                            });
            </script>
        </body>
    </html>

