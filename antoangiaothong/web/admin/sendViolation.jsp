<%-- 
    Document   : sendViolation
    Created on : 11 thg 3, 2025, 00:43:56
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gửi thông báo vi phạm - Cyberpunk Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #00f3ff;
            --primary-dark: #00a2b3;
            --secondary: #ff00a0;
            --accent: #fffc00;
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
        
        .page-subtitle {
            font-size: 16px;
            color: rgba(224, 224, 255, 0.8);
            line-height: 1.5;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
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
        
        .form-control::placeholder {
            color: rgba(224, 224, 255, 0.4);
        }
        
        .form-icon {
            position: absolute;
            top: 42px;
            right: 15px;
            color: var(--primary);
            font-size: 18px;
            pointer-events: none;
        }
        
        .form-textarea {
            min-height: 120px;
            resize: vertical;
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
        
        .error-message {
            background: rgba(255, 56, 96, 0.1);
            border: 1px solid var(--danger);
            border-radius: 5px;
            padding: 15px;
            margin-top: 20px;
            color: var(--danger);
            font-size: 14px;
            position: relative;
        }
        
        .error-message::before {
            content: '\f071';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-right: 10px;
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
        
        /* Date picker styling */
        input[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(1) brightness(1.5) sepia(100%) saturate(10000%) hue-rotate(180deg);
            cursor: pointer;
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
                    <h1 class="page-title">Gửi thông báo vi phạm</h1>
                    <p class="page-subtitle">Nhập thông tin chi tiết về mức phạt và thông báo cho người vi phạm</p>
                </div>
                
                <form action="${pageContext.request.contextPath}/Adminaction" method="POST" id="violationForm">
                    <div class="form-group">
                        <label for="fineamount" class="form-label">Số tiền phạt</label>
                        <input type="text" id="fineamount" name="fineamount" class="form-control" placeholder="Nhập số tiền phạt (VNĐ)" required>
                        <i class="fas fa-money-bill-wave form-icon"></i>
                    </div>
                    
                    <div class="form-group">
                        <label for="finedate" class="form-label">Ngày phạt</label>
                        <input type="date" id="finedate" name="finedate" class="form-control" required>
                        <i class="fas fa-calendar-alt form-icon"></i>
                    </div>
                    
                    <div class="form-group">
                        <label for="message" class="form-label">Nội dung thông báo</label>
                        <textarea id="message" name="message" class="form-control form-textarea" placeholder="Nhập nội dung thông báo chi tiết về vi phạm..." required></textarea>
                        <i class="fas fa-comment form-icon" style="top: 42px;"></i>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" name="action" value="SEND" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> Gửi thông báo
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/adminReceiveReports.jsp" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Hủy
                        </a>
                    </div>
                </form>
                
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                <div class="error-message">
                    <%= error %>
                </div>
                <% } %>
                
                <a href="${pageContext.request.contextPath}/admin/adminReceiveReports.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách báo cáo
                </a>
            </div>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/gsap.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Set default date to today
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('finedate').value = today;
            
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
            const violationForm = document.getElementById('violationForm');
            
            violationForm.addEventListener('submit', function(event) {
                const fineAmount = document.getElementById('fineamount').value.trim();
                const fineDate = document.getElementById('finedate').value.trim();
                const message = document.getElementById('message').value.trim();
                
                if (fineAmount === '' || fineDate === '' || message === '') {
                    event.preventDefault();
                    alert('Vui lòng điền đầy đủ thông tin!');
                    return;
                }
                
                // Validate fine amount is a number
                if (isNaN(fineAmount) || fineAmount <= 0) {
                    event.preventDefault();
                    alert('Số tiền phạt phải là số dương!');
                    return;
                }
            });
            
            
            
            // Error message animation if present
            const errorMessage = document.querySelector('.error-message');
            if (errorMessage) {
                gsap.from(errorMessage, {
                    y: 20,
                    opacity: 0,
                    duration: 0.5,
                    delay: 0.5
                });
            }
        });
    </script>
</body>
</html>
