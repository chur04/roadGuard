<%-- 
    Document   : responseAppeal
    Created on : 16 thg 3, 2025, 00:39:38
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Appeals" %>
<%@page import="java.util.Date" %>
<%
    int appealID = (Integer) request.getAttribute("appealID");
    int violationID = (Integer) request.getAttribute("violationID");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phản hồi khiếu nại - Cyberpunk Admin</title>
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
        }
        
        .container {
            width: 100%;
            max-width: 800px;
            padding: 20px;
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
        }
        
        .appeal-info {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 25px;
            padding: 15px;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            border: 1px solid rgba(0, 243, 255, 0.1);
        }
        
        .info-item {
            flex: 1 0 calc(50% - 15px);
            min-width: 200px;
        }
        
        .info-label {
            font-size: 12px;
            color: rgba(224, 224, 255, 0.7);
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .info-value {
            font-family: 'Orbitron', sans-serif;
            font-size: 16px;
            color: var(--primary);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            font-family: 'Orbitron', sans-serif;
            font-size: 14px;
            color: var(--light);
            margin-bottom: 8px;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(0, 243, 255, 0.3);
            border-radius: 5px;
            color: var(--light);
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 10px rgba(0, 243, 255, 0.3);
        }
        
        .form-select {
            appearance: none;
            padding-right: 30px;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%2300f3ff' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 16px;
        }
        
        .form-textarea {
            min-height: 120px;
            resize: vertical;
        }
        
        .status-option {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }
        
        .status-radio {
            display: none;
        }
        
        .status-label {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 15px;
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(0, 243, 255, 0.2);
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .status-label::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 243, 255, 0.1), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .status-label:hover::before {
            opacity: 1;
        }
        
        .status-icon {
            font-size: 24px;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }
        
        .status-text {
            font-family: 'Orbitron', sans-serif;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .status-approve .status-icon {
            color: var(--success);
        }
        
        .status-reject .status-icon {
            color: var(--danger);
        }
        
        .status-radio:checked + .status-label {
            border-color: var(--primary);
            box-shadow: 0 0 15px rgba(0, 243, 255, 0.3);
        }
        
        .status-radio:checked + .status-approve {
            border-color: var(--success);
            box-shadow: 0 0 15px rgba(0, 255, 102, 0.3);
        }
        
        .status-radio:checked + .status-reject {
            border-color: var(--danger);
            box-shadow: 0 0 15px rgba(255, 56, 96, 0.3);
        }
        
        .status-radio:checked + .status-label .status-text {
            color: var(--primary);
        }
        
        .status-radio:checked + .status-approve .status-text {
            color: var(--success);
        }
        
        .status-radio:checked + .status-reject .status-text {
            color: var(--danger);
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 25px;
            border-radius: 5px;
            font-family: 'Orbitron', sans-serif;
            font-size: 14px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            border: none;
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: all 0.6s ease;
        }
        
        .btn:hover::before {
            left: 100%;
        }
        
        .btn-primary {
            background: linear-gradient(90deg, var(--primary-dark), var(--primary));
            color: var(--dark);
            box-shadow: 0 0 15px rgba(0, 243, 255, 0.3);
        }
        
        .btn-primary:hover {
            background: linear-gradient(90deg, var(--primary), var(--primary-dark));
            box-shadow: 0 0 20px rgba(0, 243, 255, 0.5);
        }
        
        .btn-secondary {
            background: rgba(0, 0, 0, 0.3);
            border: 1px solid var(--primary);
            color: var(--primary);
        }
        
        .btn-secondary:hover {
            background: rgba(0, 243, 255, 0.1);
        }
        
        .btn i {
            margin-right: 8px;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            margin-top: 20px;
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .back-link:hover {
            color: var(--light);
            text-shadow: 0 0 5px var(--primary);
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
        
        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .cyber-card {
                padding: 20px;
            }
            
            .page-title {
                font-size: 24px;
            }
            
            .info-item {
                flex: 1 0 100%;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
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
                    <h1 class="page-title">Phản hồi khiếu nại</h1>
                    <p>Xử lý khiếu nại của người dùng và cung cấp phản hồi chính thức</p>
                </div>
                
                <div class="appeal-info">
                    <div class="info-item">
                        <div class="info-label">Mã khiếu nại</div>
                        <div class="info-value">#<%= appealID %></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Mã vi phạm</div>
                        <div class="info-value">#<%= violationID %></div>
                    </div>
                </div>
                
                <form action="${pageContext.request.contextPath}/AdminActionAppeal" method="post" id="responseForm">
                    <input type="hidden" name="appealID" value="<%= appealID %>">
                    <input type="hidden" name="violationID" value="<%= violationID %>">
                    
                    <div class="form-group">
                        <label class="form-label">Trạng thái xử lý</label>
                        <div class="status-option">
                            <input type="radio" id="statusApproved" name="status" value="Approved" class="status-radio" checked>
                            <label for="statusApproved" class="status-label status-approve">
                                <i class="fas fa-check-circle status-icon"></i>
                                <span class="status-text">Chấp nhận</span>
                            </label>
                            
                            <input type="radio" id="statusRejected" name="status" value="Rejected" class="status-radio">
                            <label for="statusRejected" class="status-label status-reject">
                                <i class="fas fa-times-circle status-icon"></i>
                                <span class="status-text">Từ chối</span>
                            </label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="adminResponse" class="form-label">Phản hồi của quản trị viên</label>
                        <textarea id="adminResponse" name="adminResponse" class="form-control form-textarea" placeholder="Nhập nội dung phản hồi chi tiết về khiếu nại này..." required></textarea>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> Gửi phản hồi
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/adminReceiveAppeals.jsp" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Hủy
                        </a>
                    </div>
                </form>
                
                <a href="${pageContext.request.contextPath}/admin/adminReceiveAppeals.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách khiếu nại
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
            
            // Animate form elements
            gsap.from('.form-group', {
                y: 20,
                opacity: 0,
                duration: 0.5,
                stagger: 0.1,
                delay: 0.3,
                ease: "power2.out"
            });
            
            // Status option hover effects
            const statusLabels = document.querySelectorAll('.status-label');
            
            statusLabels.forEach(label => {
                label.addEventListener('mouseenter', () => {
                    gsap.to(label, {
                        scale: 1.05,
                        duration: 0.3
                    });
                });
                
                label.addEventListener('mouseleave', () => {
                    gsap.to(label, {
                        scale: 1,
                        duration: 0.3
                    });
                });
            });
            
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
            
            // Form validation
            const responseForm = document.getElementById('responseForm');
            
            responseForm.addEventListener('submit', function(event) {
                const adminResponse = document.getElementById('adminResponse').value.trim();
                
                if (adminResponse === '') {
                    event.preventDefault();
                    alert('Vui lòng nhập nội dung phản hồi!');
                }
            });
        });
    </script>
</body>
</html>
