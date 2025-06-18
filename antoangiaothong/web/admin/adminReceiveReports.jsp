<%-- 
    Document   : adminReceiveReports
    Created on : 8 thg 3, 2025, 22:25:19
    Author     : im_chur
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="dao.ReportsDAO" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Báo Cáo Vi Phạm - Cyberpunk Admin</title>
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

            /* Status Badge */
            .status-badge {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                text-align: center;
            }

            .status-pending {
                background: rgba(255, 221, 87, 0.2);
                color: var(--warning);
                border: 1px solid var(--warning);
            }

            .status-approved {
                background: rgba(0, 255, 102, 0.2);
                color: var(--success);
                border: 1px solid var(--success);
            }

            .status-rejected {
                background: rgba(255, 56, 96, 0.2);
                color: var(--danger);
                border: 1px solid var(--danger);
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

            .btn-approve {
                background: rgba(0, 255, 102, 0.2);
                color: var(--success);
                border: 1px solid var(--success);
            }

            .btn-approve:hover {
                background: rgba(0, 255, 102, 0.3);
                box-shadow: 0 0 10px rgba(0, 255, 102, 0.5);
            }

            .btn-reject {
                background: rgba(255, 56, 96, 0.2);
                color: var(--danger);
                border: 1px solid var(--danger);
            }

            .btn-reject:hover {
                background: rgba(255, 56, 96, 0.3);
                box-shadow: 0 0 10px rgba(255, 56, 96, 0.5);
            }

            .btn-delete {
                background: rgba(108, 117, 125, 0.2);
                color: #adb5bd;
                border: 1px solid #adb5bd;
            }

            .btn-delete:hover {
                background: rgba(108, 117, 125, 0.3);
                box-shadow: 0 0 10px rgba(108, 117, 125, 0.5);
            }

            /* Media Links */
            .media-link {
                display: inline-flex;
                align-items: center;
                color: var(--primary);
                text-decoration: none;
                font-size: 14px;
                transition: all 0.3s;
            }

            .media-link:hover {
                color: var(--secondary);
                text-shadow: 0 0 5px var(--secondary);
            }

            .media-link i {
                margin-right: 5px;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 40px;
                background: var(--card-bg);
                border-radius: 10px;
                border: 1px solid rgba(0, 243, 255, 0.2);
            }

            .empty-state i {
                font-size: 48px;
                color: var(--primary);
                margin-bottom: 20px;
                opacity: 0.7;
            }

            .empty-state h3 {
                font-family: 'Orbitron', sans-serif;
                font-size: 20px;
                margin-bottom: 10px;
                color: var(--light);
            }

            .empty-state p {
                color: rgba(224, 224, 255, 0.8);
                margin-bottom: 20px;
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

            /* Message Box */
            .message-box {
                position: fixed;
                top: 20px;
                right: 20px;
                background: rgba(10, 10, 32, 0.9);
                border: 1px solid var(--primary);
                border-radius: 8px;
                padding: 15px;
                width: 300px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3), 0 0 15px rgba(0, 243, 255, 0.3);
                z-index: 1000;
                backdrop-filter: blur(10px);
            }

            .message-content {
                display: flex;
                align-items: center;
            }

            .message-content i {
                font-size: 20px;
                color: var(--primary);
                margin-right: 10px;
            }

            .message-content p {
                flex: 1;
                color: var(--light);
            }

            .close-btn {
                position: absolute;
                top: 10px;
                right: 10px;
                background: none;
                border: none;
                color: rgba(224, 224, 255, 0.7);
                cursor: pointer;
                font-size: 16px;
                transition: all 0.3s;
            }

            .close-btn:hover {
                color: var(--primary);
            }

            /* Truncate long text */
            .truncate {
                max-width: 150px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
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
                    <li class="active">
                        <a >
                            <i class="fas fa-flag"></i>
                            <span>Quản lý phản ánh</span>
                            <span class="hover-effect"></span>
                        </a>
                    </li>
                    <li>
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
                        <h1 class="page-title">Quản Lý Báo Cáo Vi Phạm</h1>
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
                        <h1>Danh sách báo cáo vi phạm</h1>
                        <p>Xem và xử lý các báo cáo vi phạm giao thông từ người dùng.</p>
                    </div>

                    <div class="filter-bar">
                        <div class="search-input">
                            <i class="fas fa-search"></i>
                            <input type="text" id="searchInput" placeholder="Tìm kiếm báo cáo...">
                        </div>
                        <div class="filter-dropdown">
                            <select id="statusFilter">
                                <option value="all">Tất cả trạng thái</option>
                                
                            </select>
                        </div>
                        <div class="filter-dropdown">
                            <select id="violationFilter">
                                <option value="all">Tất cả loại vi phạm</option>
                                <option value="speed">Vượt tốc độ</option>
                                <option value="signal">Vượt đèn đỏ</option>
                                <option value="parking">Đỗ xe sai quy định</option>
                                <option value="other">Khác</option>
                            </select>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty reports || not empty ReportsDAO.getAllReportsIfItIsPending()}">
                            <div class="data-table-container">
                                <table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Người Báo Cáo</th>
                                            <th>Loại Vi Phạm</th>
                                            <th>Mô Tả</th>
                                            <th>Biển Số</th>
                                            <th>Hình Ảnh</th>
                                            <th>Video</th>
                                            <th>Vị Trí</th>
                                            <th>Thời Gian</th>
                                            <th>Trạng Thái</th>
                                            <th>Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="report" items="${ReportsDAO.getAllReportsIfItIsPending()}">
                                            <tr>
                                                <td>${report.reportID}</td>
                                                <td>${report.reporterID}</td>
                                                <td>${report.violationType}</td>
                                                <td class="truncate">${report.description}</td>
                                                <td>${report.plateNumber}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty report.imageURL}">
                                                            <a href="uploads/${report.imageURL}" target="_blank" class="media-link">
                                                                <i class="fas fa-image"></i> Xem ảnh
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty report.videoURL}">
                                                            <a href="uploads/${report.videoURL}" target="_blank" class="media-link">
                                                                <i class="fas fa-video"></i> Xem video
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="truncate">${report.location}</td>
                                                <td>${report.reportDate}</td>
                                                <td>
                                                    <span class="status-badge status-pending">
                                                        ${report.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <a href="${pageContext.request.contextPath}/Adminaction?action=view&plateNumber=${report.plateNumber}&reportID=${report.reportID}" class="btn btn-view">
                                                            <i class="fas fa-eye"></i> Xem
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/Adminaction?action=send&plateNumber=${report.plateNumber}&reportID=${report.reportID}" class="btn btn-approve">
                                                            <i class="fas fa-check"></i> Gửi
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/Adminaction?action=reject&plateNumber=${report.plateNumber}&reportID=${report.reportID}" class="btn btn-reject">
                                                            <i class="fas fa-times"></i> Từ chối
                                                        </a>
                                                    </div>
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
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-clipboard-check"></i>
                                <h3>Không có báo cáo nào đang chờ xử lý</h3>
                                <p>Tất cả các báo cáo vi phạm đã được xử lý hoặc chưa có báo cáo nào được gửi.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <a href="${pageContext.request.contextPath}/view/admin.jsp" class="back-btn">
                        <i class="fas fa-arrow-left"></i> Quay lại Dashboard
                    </a>
                </div>
            </div>
        </div>

        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
        <div id="msgBox" class="message-box">
            <div class="message-content">
                <i class="fas fa-info-circle"></i>
                <p><%= message %></p>
            </div>
            <button class="close-btn"><i class="fas fa-times"></i></button>
        </div>
        <% } %>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/gsap.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                
                const sidebarToggle = document.getElementById('sidebar-toggle');
                const adminWrapper = document.querySelector('.admin-wrapper');

                sidebarToggle.addEventListener('click', function () {
                    adminWrapper.classList.toggle('sidebar-collapsed');
                });

                
                const msgBox = document.getElementById('msgBox');
                if (msgBox) {
                    const closeBtn = msgBox.querySelector('.close-btn');

                    
                    gsap.fromTo(msgBox, {
                        opacity: 0,
                        y: -50
                    }, {
                        opacity: 1,
                        y: 0,
                        duration: 0.5
                    });

                  
                    setTimeout(() => {
                        gsap.to(msgBox, {
                            opacity: 0,
                            y: -50,
                            duration: 0.5,
                            onComplete: () => {
                                msgBox.style.display = 'none';
                            }
                        });
                    }, 5000);

                   
                    if (closeBtn) {
                        closeBtn.addEventListener('click', () => {
                            gsap.to(msgBox, {
                                opacity: 0,
                                y: -50,
                                duration: 0.3,
                                onComplete: () => {
                                    msgBox.style.display = 'none';
                                }
                            });
                        });
                    }
                }

               
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

                
                gsap.from(tableRows, {
                    y: 20,
                    opacity: 0,
                    duration: 0.5,
                    stagger: 0.05,
                    ease: "power2.out"
                });

               
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

                
                const statusFilter = document.getElementById('statusFilter');
                if (statusFilter) {
                    statusFilter.addEventListener('change', function () {
                        const selectedStatus = this.value.toLowerCase();

                        if (selectedStatus === 'all') {
                            tableRows.forEach(row => {
                                row.style.display = '';
                            });
                            return;
                        }

                        tableRows.forEach(row => {
                            const statusCell = row.querySelector('td:nth-child(10)');
                            const status = statusCell.textContent.trim().toLowerCase();

                            if (status.includes(selectedStatus)) {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        });
                    });
                }

                
                const violationFilter = document.getElementById('violationFilter');
                if (violationFilter) {
                    violationFilter.addEventListener('change', function () {
                        const selectedType = this.value.toLowerCase();

                        if (selectedType === 'all') {
                            tableRows.forEach(row => {
                                row.style.display = '';
                            });
                            return;
                        }

                        tableRows.forEach(row => {
                            const typeCell = row.querySelector('td:nth-child(3)');
                            const type = typeCell.textContent.trim().toLowerCase();

                            if (type.includes(selectedType)) {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        });
                    });
                }

               
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
        </script>
    </body>
</html>
