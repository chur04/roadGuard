<%-- 
    Document   : admin
    Created on : 6 thg 3, 2025, 11:52:09
    Author     : im_chur
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Users" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Cyberpunk</title>
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
            0% { left: -100%; }
            50% { left: 100%; }
            100% { left: 100%; }
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
        
        .user-profile {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(0, 243, 255, 0.2);
        }
        
        .avatar-container {
            position: relative;
            width: 80px;
            height: 80px;
            margin-bottom: 15px;
        }
        
        .avatar-border {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 2px solid var(--primary);
            border-radius: 50%;
            animation: rotate 10s linear infinite;
        }
        
        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .avatar {
            position: absolute;
            top: 5px;
            left: 5px;
            width: calc(100% - 10px);
            height: calc(100% - 10px);
            background-image: url('https://i.pravatar.cc/150?img=12');
            background-size: cover;
            border-radius: 50%;
            box-shadow: 0 0 15px rgba(0, 243, 255, 0.5);
        }
        
        .user-profile h3 {
            font-size: 18px;
            margin-bottom: 5px;
        }
        
        .status {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: rgba(224, 224, 255, 0.7);
        }
        
        .status-dot {
            width: 8px;
            height: 8px;
            background-color: #0f0;
            border-radius: 50%;
            margin-right: 6px;
            box-shadow: 0 0 5px #0f0;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { opacity: 0.6; }
            50% { opacity: 1; }
            100% { opacity: 0.6; }
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
        
        .system-stats {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid rgba(0, 243, 255, 0.2);
        }
        
        .stat {
            margin-bottom: 15px;
        }
        
        .stat-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
            font-size: 14px;
            color: rgba(224, 224, 255, 0.8);
        }
        
        .stat-bar {
            height: 6px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 3px;
            overflow: hidden;
        }
        
        .stat-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            border-radius: 3px;
            position: relative;
        }
        
        .stat-fill::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 30px;
            height: 100%;
            background: rgba(255, 255, 255, 0.3);
            filter: blur(5px);
            animation: stat-glow 2s infinite;
        }
        
        @keyframes stat-glow {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(400%); }
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
        
        .search-box {
            flex: 1;
            max-width: 400px;
            position: relative;
            margin-right: 20px;
        }
        
        .search-box input {
            width: 100%;
            padding: 10px 15px 10px 40px;
            border-radius: 20px;
            border: 1px solid rgba(0, 243, 255, 0.3);
            background: rgba(10, 10, 32, 0.6);
            color: var(--light);
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 10px rgba(0, 243, 255, 0.3);
        }
        
        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(224, 224, 255, 0.7);
        }
        
        .header-actions {
            display: flex;
            margin-left: auto;
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
        
        .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--secondary);
            color: #fff;
            font-size: 10px;
            font-weight: bold;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 5px rgba(255, 0, 160, 0.5);
        }
        
        /* Dashboard */
        .dashboard {
            padding: 20px;
        }
        
        .welcome-section {
            margin-bottom: 30px;
            padding: 30px;
            background: rgba(10, 10, 32, 0.6);
            border-radius: 10px;
            border: 1px solid rgba(0, 243, 255, 0.2);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        }
        
        .cyber-heading {
            font-family: 'Orbitron', sans-serif;
            font-size: 32px;
            margin-bottom: 10px;
            position: relative;
            display: inline-block;
        }
        
        .cyber-heading::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, var(--primary), transparent);
        }
        
        .sub-heading {
            font-size: 16px;
            color: rgba(224, 224, 255, 0.8);
            margin-bottom: 30px;
        }
        
        .stats-container {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .stat-card {
            flex: 1;
            min-width: 200px;
            background: rgba(10, 10, 32, 0.7);
            border-radius: 8px;
            padding: 20px;
            display: flex;
            align-items: center;
            border: 1px solid rgba(0, 243, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 243, 255, 0.1), transparent);
            z-index: 0;
        }
        
        .stat-icon {
            width: 50px;
            height: 50px;
            background: rgba(0, 243, 255, 0.1);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            position: relative;
            z-index: 1;
        }
        
        .stat-icon i {
            font-size: 24px;
            color: var(--primary);
        }
        
        .stat-info {
            position: relative;
            z-index: 1;
        }
        
        .stat-info h3 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
            color: #fff;
        }
        
        .stat-info p {
            font-size: 14px;
            color: rgba(224, 224, 255, 0.8);
        }
        
        .stat-chart {
            position: absolute;
            right: 20px;
            bottom: 10px;
            width: 60px;
            height: 30px;
            opacity: 0.5;
        }
        
        /* Dashboard Grid */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        
        .card {
            background: var(--card-bg);
            border-radius: 10px;
            border: 1px solid rgba(0, 243, 255, 0.2);
            box-shadow: 0 4px 20px rgba(0, 243, 255, 0.1);
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid rgba(0, 243, 255, 0.1);
        }
        
        .card-header h2 {
            font-size: 18px;
            font-weight: 500;
            color: #fff;
            font-family: 'Orbitron', sans-serif;
        }
        
        .card-actions {
            display: flex;
        }
        
        .card-btn {
            background: none;
            border: none;
            color: var(--light);
            cursor: pointer;
            width: 30px;
            height: 30px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
        }
        
        .card-btn:hover {
            background: rgba(0, 243, 255, 0.1);
            color: var(--primary);
        }
        
        .card-body {
            padding: 20px;
            position: relative;
            z-index: 1;
        }
        
        .card-icon {
            width: 60px;
            height: 60px;
            background: rgba(0, 243, 255, 0.1);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
        }
        
        .card-icon i {
            font-size: 30px;
            color: var(--primary);
        }
        
        .card-body p {
            margin-bottom: 20px;
            color: rgba(224, 224, 255, 0.8);
            font-size: 14px;
            line-height: 1.5;
        }
        
        .progress-bar {
            height: 6px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 3px;
            overflow: hidden;
            margin-bottom: 10px;
        }
        
        .progress {
            height: 100%;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            border-radius: 3px;
        }
        
        .progress-text {
            font-size: 12px;
            color: rgba(224, 224, 255, 0.7);
            text-align: right;
        }
        
        .user-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        
        .user-stat {
            display: flex;
            align-items: center;
        }
        
        .dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin-right: 8px;
        }
        
        .dot.active {
            background: var(--primary);
            box-shadow: 0 0 5px var(--primary);
        }
        
        .dot.inactive {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .violation-chart {
            display: flex;
            align-items: flex-end;
            height: 60px;
            gap: 5px;
            margin-top: 15px;
        }
        
        .chart-bar {
            flex: 1;
            background: linear-gradient(to top, var(--primary), var(--secondary));
            border-radius: 3px;
        }
        
        .archive-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
        }
        
        .archive-stat {
            text-align: center;
            padding: 10px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 5px;
            flex: 1;
        }
        
        .archive-stat:first-child {
            margin-right: 10px;
        }
        
        .archive-stat .label {
            font-size: 12px;
            color: rgba(224, 224, 255, 0.7);
            margin-bottom: 5px;
        }
        
        .archive-stat .value {
            font-size: 18px;
            font-weight: 700;
            color: #fff;
        }
        
        .card-footer {
            padding: 15px 20px;
            border-top: 1px solid rgba(0, 243, 255, 0.1);
            text-align: right;
        }
        
        .cyber-btn {
            display: inline-flex;
            align-items: center;
            padding: 8px 16px;
            background: rgba(0, 243, 255, 0.1);
            border: 1px solid var(--primary);
            border-radius: 5px;
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .cyber-btn::before {
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
        
        .cyber-btn:hover {
            background: rgba(0, 243, 255, 0.2);
            box-shadow: 0 0 15px rgba(0, 243, 255, 0.3);
        }
        
        .cyber-btn:hover::before {
            left: 100%;
        }
        
        .cyber-btn i {
            margin-left: 8px;
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
            .stats-container {
                flex-direction: column;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
            
            .welcome-section {
                padding: 20px;
            }
            
            .cyber-heading {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        <!-- Sidebar với hiệu ứng neon -->
        <div class="sidebar">
            <div class="logo-container">
                <div class="logo">
                    <div class="logo-glow"></div>
                    <span class="cyber-text">CYBER</span>
                    <span class="admin-text">ADMIN</span>
                </div>
            </div>
            
            <div class="user-profile">
                <div class="avatar-container">
                    <div class="avatar-border"></div>
                    <div class="avatar"></div>
                </div>
                <h3 class="glow-text">Administrator</h3>
                <p class="status"><span class="status-dot"></span> Online</p>
            </div>
            
            <ul class="nav-links">
                <li class="active">
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
            
            <div class="system-stats">
                <div class="stat">
                    <div class="stat-label">System</div>
                    <div class="stat-bar">
                        <div class="stat-fill" style="width: 78%"></div>
                    </div>
                </div>
                <div class="stat">
                    <div class="stat-label">Security</div>
                    <div class="stat-bar">
                        <div class="stat-fill" style="width: 92%"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main content -->
        <div class="main-content">
            <header>
                <div class="header-content">
                    <button id="sidebar-toggle" class="menu-btn">
                        <i class="fas fa-bars"></i>
                                            </button>
                   
                    <div class="header-actions">
                        <button class="action-btn">
                            <i class="fas fa-bell"></i>
                            <span class="badge">3</span>
                        </button>
                        <button class="action-btn">
                            <i class="fas fa-cog"></i>
                        </button>
                    </div>
                </div>
            </header>

            <div class="dashboard">
                <div class="welcome-section">
                    <h1 class="cyber-heading">Chào mừng, <span class="highlight-text">Admin!</span></h1>
                    <p class="sub-heading">Quản lý hệ thống giao thông một cách hiệu quả.</p>
                    
                    <div class="stats-container">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="stat-info">
                               
                            </div>
                            <div class="stat-chart"></div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="stat-info">
                               
                            </div>
                            <div class="stat-chart"></div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="stat-info">
                                
                            </div>
                            <div class="stat-chart"></div>
                        </div>
                    </div>
                </div>
                
                <div class="dashboard-grid">
                    <div class="card">
                        <div class="card-header">
                            <h2>Phản ánh chờ xử lý</h2>
                            <div class="card-actions">
                                <button class="card-btn"><i class="fas fa-ellipsis-h"></i></button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-icon">
                                <i class="fas fa-clipboard-list"></i>
                            </div>
                            <p>Xem và xử lý các phản ánh vi phạm giao thông.</p>
                            <div class="progress-bar">
                                <div class="progress" style="width: 65%"></div>
                            </div>
                            <p class="progress-text">Cần xử lí</p>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/AdminReceiveReports" class="cyber-btn">
                                <span>Quản lý</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header">
                            <h2>Khiếu nại chờ xử lý</h2>
                            <div class="card-actions">
                                <button class="card-btn"><i class="fas fa-ellipsis-h"></i></button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-icon">
                                <i class="fas fa-gavel"></i>
                            </div>
                            <p>Xem và xử lý các khiếu nại về phản ánh vi phạm.</p>
                            <div class="progress-bar">
                                <div class="progress" style="width: 42%"></div>
                            </div>
                            <p class="progress-text">Cần xử lý</p>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/AdminReceiveAppeal" class="cyber-btn">
                                <span>Quản lý</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header">
                            <h2>Người dùng</h2>
                            <div class="card-actions">
                                <button class="card-btn"><i class="fas fa-ellipsis-h"></i></button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-icon">
                                <i class="fas fa-user-shield"></i>
                            </div>
                            <p>Kiểm soát và quản lý tài khoản người dùng.</p>
                            <div class="user-stats">
                                <div class="user-stat">
                                    <span class="dot active"></span>
                                    <span>Hoạt động</span>
                                </div>
                                <div class="user-stat">
                                    <span class="dot inactive"></span>
                                    <span>Không hoạt động</span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/AdminReceiveInformationOfUser" class="cyber-btn">
                                <span>Quản lý</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header">
                            <h2>Vi Phạm Chưa Thanh Toán</h2>
                            <div class="card-actions">
                                <button class="card-btn"><i class="fas fa-ellipsis-h"></i></button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-icon">
                                <i class="fas fa-money-bill-wave"></i>
                            </div>
                            <p>Xem các vi phạm của người dùng chưa thanh toán</p>
                            <div class="violation-chart">
                                <div class="chart-bar" style="height: 60%"></div>
                                <div class="chart-bar" style="height: 80%"></div>
                                <div class="chart-bar" style="height: 45%"></div>
                                <div class="chart-bar" style="height: 75%"></div>
                                <div class="chart-bar" style="height: 65%"></div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/AdminDoWithViolation?action=statusViolationNotPaid" class="cyber-btn">
                                <span>Quản lý</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header">
                            <h2>Kho vi phạm</h2>
                            <div class="card-actions">
                                <button class="card-btn"><i class="fas fa-ellipsis-h"></i></button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="card-icon">
                                <i class="fas fa-archive"></i>
                            </div>
                            <p>Xem các vi phạm đã được thanh toán và vi phạm trong diện cân nhắc</p>
                            <div class="archive-stats">
                                <div class="archive-stat">
                                    <span class="label">Đã thanh toán</span>
                                    <span class="value">75%</span>
                                </div>
                                <div class="archive-stat">
                                    <span class="label">Cân nhắc</span>
                                    <span class="value">25%</span>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/AdminDoWithViolation?action=statusViolationPaid" class="cyber-btn">
                                <span>Quản lý</span>
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
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
        document.addEventListener('DOMContentLoaded', function() {
            // Sidebar toggle
            const sidebarToggle = document.getElementById('sidebar-toggle');
            const adminWrapper = document.querySelector('.admin-wrapper');
            
            sidebarToggle.addEventListener('click', function() {
                adminWrapper.classList.toggle('sidebar-collapsed');
            });
            
            // Message box auto-hide
            const msgBox = document.getElementById('msgBox');
            if (msgBox) {
                const closeBtn = msgBox.querySelector('.close-btn');
                
                // Show message with animation
                gsap.fromTo(msgBox, {
                    opacity: 0,
                    y: -50
                }, {
                    opacity: 1,
                    y: 0,
                    duration: 0.5
                });
                
                // Auto hide after 5 seconds
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
                
                // Close button
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
            
            // Animate cards on load
            const cards = document.querySelectorAll('.card');
            gsap.from(cards, {
                duration: 0.6,
                opacity: 0,
                y: 30,
                stagger: 0.1,
                ease: "power2.out"
            });
            
            // Stats animation
            const statFills = document.querySelectorAll('.stat-fill');
            gsap.from(statFills, {
                width: 0,
                duration: 1.5,
                ease: "power2.out",
                delay: 0.5
            });
            
            // Progress bar animations
            const progressBars = document.querySelectorAll('.progress');
            gsap.from(progressBars, {
                width: 0,
                duration: 1.5,
                ease: "power2.out",
                delay: 0.8
            });
            
            // Hover effects for cards
            cards.forEach(card => {
                card.addEventListener('mouseenter', () => {
                    gsap.to(card, {
                        scale: 1.02,
                        boxShadow: '0 8px 30px rgba(0, 243, 255, 0.2)',
                        duration: 0.3
                    });
                });
                
                card.addEventListener('mouseleave', () => {
                    gsap.to(card, {
                        scale: 1,
                        boxShadow: '0 4px 20px rgba(0, 243, 255, 0.1)',
                        duration: 0.3
                    });
                });
            });
            
            // Chart bar animations
            const chartBars = document.querySelectorAll('.chart-bar');
            gsap.from(chartBars, {
                height: 0,
                duration: 1,
                stagger: 0.1,
                ease: "elastic.out(1, 0.5)",
                delay: 1
            });
            
            // Glowing effect for buttons
            const cyberBtns = document.querySelectorAll('.cyber-btn');
            cyberBtns.forEach(btn => {
                setInterval(() => {
                    gsap.to(btn, {
                        boxShadow: '0 0 15px rgba(0, 243, 255, 0.7)',
                        duration: 1,
                        yoyo: true,
                        repeat: 1
                    });
                }, 3000);
            });
        });
    </script>
</body>
</html>
