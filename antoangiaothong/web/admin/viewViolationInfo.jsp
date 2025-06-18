<%-- 
    Document   : viewViolationInfo
    Created on : 10 thg 3, 2025, 08:33:13
    Author     : im_chur
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.VehiclesDAO, model.VehicleUser" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin phương tiện - Cyberpunk Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #00f3ff;
            --primary-dark: #00a2b3;
            --secondary: #ff00a0;
            --accent: #fffc00;
            --success: #00ff66;
            --danger: #ff3860;
            --warning: #ffdd57;
            --info: #00d1ff;
            --dark: #0a0a20;
            --darker: #050510;
            --light: #e0e0ff;
            --card-bg: rgba(10, 10, 32, 0.7);
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }
        
        .container {
            width: 100%;
            max-width: 800px;
        }
        
        .cyber-card {
            background: var(--card-bg);
            border-radius: 10px;
            border: 1px solid rgba(0, 243, 255, 0.2);
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.3), 0 0 20px rgba(0, 243, 255, 0.2);
            padding: 30px;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
        }
        
        .cyber-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
        }
        
        .cyber-card::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 243, 255, 0.1), transparent);
            z-index: 0;
        }
        
        .card-content {
            position: relative;
            z-index: 1;
        }
        
        .card-header {
            margin-bottom: 30px;
            position: relative;
            padding-bottom: 15px;
        }
        
        .card-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 1px;
            background: linear-gradient(90deg, var(--primary), transparent);
        }
        
        .page-title {
            font-family: 'Orbitron', sans-serif;
            font-size: 28px;
            color: var(--primary);
            margin-bottom: 10px;
            text-shadow: 0 0 5px rgba(0, 243, 255, 0.5);
            letter-spacing: 1px;
            display: flex;
            align-items: center;
        }
        
        .page-title i {
            margin-right: 12px;
            font-size: 24px;
        }
        
        .page-subtitle {
            font-size: 16px;
            color: rgba(224, 224, 255, 0.8);
            line-height: 1.5;
        }
        
        .plate-info {
            background: rgba(0, 243, 255, 0.05);
            border: 1px solid rgba(0, 243, 255, 0.2);
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
        }
        
        .plate-info i {
            font-size: 24px;
            color: var(--primary);
            margin-right: 15px;
        }
        
        .plate-number {
            font-family: 'Orbitron', sans-serif;
            font-size: 18px;
            color: var(--light);
            letter-spacing: 1px;
        }
        
        .plate-label {
            font-size: 14px;
            color: rgba(224, 224, 255, 0.6);
            margin-bottom: 5px;
        }
        
        .info-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin: 20px 0;
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid rgba(0, 243, 255, 0.2);
        }
        
        .info-table th {
            background: rgba(0, 243, 255, 0.1);
            color: var(--primary);
            font-family: 'Orbitron', sans-serif;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 1px;
            padding: 15px;
            text-align: left;
            width: 40%;
            border-bottom: 1px solid rgba(0, 243, 255, 0.1);
        }
        
        .info-table td {
            background: rgba(255, 255, 255, 0.02);
            color: var(--light);
            padding: 15px;
            border-bottom: 1px solid rgba(0, 243, 255, 0.1);
        }
        
        .info-table tr:last-child th,
        .info-table tr:last-child td {
            border-bottom: none;
        }
        
        .info-table tr:hover td {
            background: rgba(0, 243, 255, 0.05);
        }
        
        .info-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 24px;
            height: 24px;
            background: rgba(0, 243, 255, 0.1);
            border-radius: 50%;
            margin-right: 10px;
            color: var(--primary);
            font-size: 12px;
        }
        
        .error-message {
            background: rgba(255, 56, 96, 0.1);
            border: 1px solid var(--danger);
            border-radius: 5px;
            padding: 15px;
            margin: 20px 0;
            color: var(--danger);
            display: flex;
            align-items: center;
        }
        
        .error-message i {
            font-size: 24px;
            margin-right: 15px;
        }
        
        .empty-message {
            background: rgba(255, 221, 87, 0.1);
            border: 1px solid var(--warning);
            border-radius: 5px;
            padding: 15px;
            margin: 20px 0;
            color: var(--warning);
            display: flex;
            align-items: center;
            text-align: center;
            justify-content: center;
        }
        
        .empty-message i {
            font-size: 24px;
            margin-right: 15px;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            background: rgba(0, 243, 255, 0.1);
            border: 1px solid rgba(0, 243, 255, 0.3);
            border-radius: 5px;
            color: var(--primary);
            font-family: 'Orbitron', sans-serif;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.3s ease;
            margin-top: 20px;
        }
        
        .back-link:hover {
            background: rgba(0, 243, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 243, 255, 0.2);
        }
        
        .back-link i {
            margin-right: 8px;
        }
        
        /* Glowing elements */
        .glow-border {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }
        
        .glow-line {
            position: absolute;
            background: var(--primary);
        }
        
        .glow-line-top {
            top: 0;
            left: 0;
            width: 100%;
            height: 1px;
            box-shadow: 0 0 10px 1px var(--primary);
        }
        
        .glow-line-right {
            top: 0;
            right: 0;
            width: 1px;
            height: 100%;
            box-shadow: 0 0 10px 1px var(--primary);
        }
        
        .glow-line-bottom {
            bottom: 0;
            left: 0;
            width: 100%;
            height: 1px;
            box-shadow: 0 0 10px 1px var(--primary);
        }
        
        .glow-line-left {
            top: 0;
            left: 0;
            width: 1px;
            height: 100%;
            box-shadow: 0 0 10px 1px var(--primary);
        }
        
        /* Animations */
        @keyframes pulse {
            0% { box-shadow: 0 0 10px rgba(0, 243, 255, 0.3); }
            50% { box-shadow: 0 0 20px rgba(0, 243, 255, 0.5); }
            100% { box-shadow: 0 0 10px rgba(0, 243, 255, 0.3); }
        }
        
        .cyber-card {
            animation: pulse 3s infinite;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .cyber-card {
                padding: 20px;
            }
            
            .page-title {
                font-size: 24px;
            }
            
            .plate-number {
                font-size: 16px;
            }
            
            .info-table th,
            .info-table td {
                padding: 12px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="cyber-card">
            <div class="glow-border">
                <div class="glow-line glow-line-top"></div>
                <div class="glow-line glow-line-right"></div>
                <div class="glow-line glow-line-bottom"></div>
                <div class="glow-line glow-line-left"></div>
            </div>
            
            <div class="card-content">
                <div class="card-header">
                    <h1 class="page-title">
                        <i class="fas fa-car-side"></i>
                        Thông tin phương tiện
                    </h1>
                    <p class="page-subtitle">Chi tiết thông tin về phương tiện và chủ sở hữu</p>
                </div>
                
                <%
                    String plateNumber = request.getParameter("plateNumber");
                    if (plateNumber == null || plateNumber.isEmpty()) {
                %>
                <div class="error-message">
                    <i class="fas fa-exclamation-triangle"></i>
                    <div>
                        <strong>Lỗi:</strong> Không nhận được biển số xe!
                    </div>
                </div>
                <% } else { %>
                <div class="plate-info">
                    <i class="fas fa-id-card"></i>
                    <div>
                        <div class="plate-label">Biển số xe</div>
                        <div class="plate-number"><%= plateNumber %></div>
                    </div>
                </div>
                <% } %>
                
                <c:choose>
                    <c:when test="${vehicle != null}">
                        <table class="info-table">
                            <tr>
                                <th><span class="info-icon"><i class="fas fa-id-card"></i></span> Biển số</th>
                                <td>${vehicle.plateNumber}</td>
                            </tr>
                            <tr>
                                <th><span class="info-icon"><i class="fas fa-building"></i></span> Hãng xe</th>
                                <td>${vehicle.brand}</td>
                            </tr>
                            <tr>
                                <th><span class="info-icon"><i class="fas fa-car"></i></span> Loại xe</th>
                                <td>${vehicle.model}</td>
                            </tr>
                            <tr>
                                <th><span class="info-icon"><i class="fas fa-user"></i></span> Chủ sở hữu</th>
                                <td>${vehicle.fullName}</td>
                            </tr>
                            <tr>
                                <th><span class="info-icon"><i class="fas fa-envelope"></i></span> Email</th>
                                <td>${vehicle.email}</td>
                            </tr>
                            <tr>
                                <th><span class="info-icon"><i class="fas fa-phone"></i></span> Số điện thoại</th>
                                <td>${vehicle.phone}</td>
                            </tr>
                            <tr>
                                <th><span class="info-icon"><i class="fas fa-fingerprint"></i></span> ID Người Dùng</th>
                                <td>${vehicle.userID}</td>
                            </tr>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-message">
                            <i class="fas fa-info-circle"></i>
                            Không có thông tin phương tiện.
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <a href="${pageContext.request.contextPath}/admin/adminReceiveReports.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách báo cáo
                </a>
            </div>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/gsap.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate card on load
            gsap.from('.cyber-card', {
                y: 30,
                opacity: 0,
                duration: 0.8,
                ease: "power3.out"
            });
            
            // Animate table rows
            gsap.from('.info-table tr', {
                y: 20,
                opacity: 0,
                duration: 0.5,
                stagger: 0.1,
                delay: 0.3,
                ease: "power2.out"
            });
            
            // Animate plate info
            gsap.from('.plate-info', {
                y: 20,
                opacity: 0,
                duration: 0.5,
                delay: 0.2,
                ease: "power2.out"
            });
            
            // Animate error message if present
            const errorMessage = document.querySelector('.error-message');
            if (errorMessage) {
                gsap.from(errorMessage, {
                    y: 20,
                    opacity: 0,
                    duration: 0.5,
                    delay: 0.2
                });
            }
            
            // Animate empty message if present
            const emptyMessage = document.querySelector('.empty-message');
            if (emptyMessage) {
                gsap.from(emptyMessage, {
                    y: 20,
                    opacity: 0,
                    duration: 0.5,
                    delay: 0.2
                });
            }
            
            // Back link hover effect
            const backLink = document.querySelector('.back-link');
            
            backLink.addEventListener('mouseenter', () => {
                gsap.to(backLink, {
                    scale: 1.05,
                    duration: 0.3
                });
            });
            
            backLink.addEventListener('mouseleave', () => {
                gsap.to(backLink, {
                    scale: 1,
                    duration: 0.3
                });
            });
            
            // Add hover effects for table rows
            const tableRows = document.querySelectorAll('.info-table tr');
            
            tableRows.forEach(row => {
                row.addEventListener('mouseenter', () => {
                    gsap.to(row.querySelector('td'), {
                        backgroundColor: 'rgba(0, 243, 255, 0.05)',
                        duration: 0.3
                    });
                });
                
                row.addEventListener('mouseleave', () => {
                    gsap.to(row.querySelector('td'), {
                        backgroundColor: 'rgba(255, 255, 255, 0.02)',
                        duration: 0.3
                    });
                });
            });
        });
    </script>
</body>
</html>
