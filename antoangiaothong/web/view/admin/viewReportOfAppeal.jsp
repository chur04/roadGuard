<%-- 
    Document   : viewReportOfAppeal
    Created on : 16 thg 3, 2025, 00:15:33
    Author     : im_chur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết vi phạm - Cyberpunk Admin</title>
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
            padding: 30px;
        }
        
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
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
            margin-bottom: 30px;
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
        
        .cyber-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin: 20px 0;
            overflow-x: auto;
            display: block;
        }
        
        .cyber-table-wrapper {
            position: relative;
            overflow-x: auto;
            border-radius: 8px;
            border: 1px solid rgba(0, 243, 255, 0.2);
            background: rgba(10, 10, 32, 0.3);
        }
        
        .cyber-table th,
        .cyber-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(0, 243, 255, 0.1);
            position: relative;
        }
        
        .cyber-table th {
            background: rgba(0, 243, 255, 0.1);
            color: var(--primary);
            font-family: 'Orbitron', sans-serif;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 1px;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        
        .cyber-table th::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, var(--primary), transparent);
        }
        
        .cyber-table tr {
            transition: all 0.3s ease;
        }
        
        .cyber-table tr:hover {
            background: rgba(0, 243, 255, 0.05);
        }
        
        .cyber-table tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.02);
        }
        
        .cyber-table tr:nth-child(even):hover {
            background: rgba(0, 243, 255, 0.05);
        }
        
        .cyber-table td {
            color: var(--light);
            font-size: 14px;
        }
        
        .media-link {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            background: rgba(0, 243, 255, 0.1);
            border: 1px solid rgba(0, 243, 255, 0.3);
            border-radius: 4px;
            color: var(--primary);
            font-family: 'Orbitron', sans-serif;
            font-size: 12px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .media-link:hover {
            background: rgba(0, 243, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 243, 255, 0.2);
        }
        
        .media-link i {
            margin-right: 6px;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 20px;
            font-family: 'Orbitron', sans-serif;
            font-size: 12px;
            font-weight: 500;
        }
        
        .status-paid {
            background: rgba(0, 255, 102, 0.1);
            color: var(--success);
            border: 1px solid rgba(0, 255, 102, 0.3);
        }
        
        .status-unpaid {
            background: rgba(255, 56, 96, 0.1);
            color: var(--danger);
            border: 1px solid rgba(255, 56, 96, 0.3);
        }
        
        .status-badge i {
            margin-right: 6px;
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
        
        .empty-message {
            text-align: center;
            padding: 30px;
            color: rgba(224, 224, 255, 0.6);
            font-style: italic;
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
        
        /* Image preview */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(5, 5, 16, 0.9);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .modal-content {
            max-width: 80%;
            max-height: 80%;
            position: relative;
            border: 1px solid var(--primary);
            box-shadow: 0 0 30px rgba(0, 243, 255, 0.3);
        }
        
        .modal-image {
            max-width: 100%;
            max-height: 100%;
            display: block;
        }
        
        .modal-close {
            position: absolute;
            top: -20px;
            right: -20px;
            width: 40px;
            height: 40px;
            background: var(--dark);
            border: 1px solid var(--primary);
            border-radius: 50%;
            color: var(--primary);
            font-size: 18px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .modal-close:hover {
            background: var(--primary);
            color: var(--dark);
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
        @media (max-width: 992px) {
            .cyber-table {
                font-size: 14px;
            }
            
            .cyber-table th,
            .cyber-table td {
                padding: 12px 10px;
            }
        }
        
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .page-title {
                font-size: 24px;
            }
            
            .cyber-table {
                font-size: 13px;
            }
            
            .cyber-table th,
            .cyber-table td {
                padding: 10px 8px;
            }
            
            .media-link {
                padding: 5px 10px;
                font-size: 11px;
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
                        <i class="fas fa-file-alt"></i>
                        Chi tiết vi phạm
                    </h1>
                    <p class="page-subtitle">Xem thông tin chi tiết về các vi phạm liên quan đến khiếu nại</p>
                </div>
                
                <div class="cyber-table-wrapper">
                    <table class="cyber-table">
                        <thead>
                            <tr>
                                <th>Mã vi phạm</th>
                                <th>Mã người vi phạm</th>
                                <th>Loại vi phạm</th>
                                <th>Mô tả</th>
                                <th>Hình ảnh</th>
                                <th>Video</th>
                                <th>Địa điểm</th>
                                <th>Ngày báo cáo</th>
                                <th>Tiền phạt</th>
                                <th>Ngày phạt</th>
                                <th>Biển số</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty violationusers}">
                                    <c:forEach var="violation" items="${violationusers}">
                                        <tr>
                                            <td>#${violation.violationID}</td>
                                            <td>#${violation.violatorID}</td>
                                            <td>${violation.violationType}</td>
                                            <td>${violation.description}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty violation.imageURL}">
                                                        <a href="javascript:void(0)" class="media-link image-link" data-src="uploads/${violation.imageURL}">
                                                            <i class="fas fa-image"></i> Xem ảnh
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="no-media">Không có</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty violation.videoURL}">
                                                        <a href="uploads/${violation.videoURL}" target="_blank" class="media-link">
                                                            <i class="fas fa-video"></i> Xem video
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="no-media">Không có</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${violation.location}</td>
                                            <td>${violation.reportDate}</td>
                                            <td>${violation.fineAmount} VNĐ</td>
                                            <td>${violation.fineDate}</td>
                                            <td>${violation.plateNumber}</td>   
                                            <td>
                                                <c:choose>
                                                    <c:when test="${violation.paidStatus}"> 
                                                        <span class="status-badge status-paid">
                                                            <i class="fas fa-check-circle"></i> Đã thanh toán
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-unpaid">
                                                            <i class="fas fa-times-circle"></i> Chưa thanh toán
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="12" class="empty-message">Không có dữ liệu vi phạm nào được tìm thấy</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
                
                <a href="${pageContext.request.contextPath}/admin/adminReceiveAppeals.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách khiếu nại
                </a>
            </div>
        </div>
    </div>
    
    <!-- Image Modal -->
    <div id="imageModal" class="modal">
        <div class="modal-content">
            <img id="modalImage" class="modal-image" src="" alt="Hình ảnh vi phạm">
            <div class="modal-close" id="closeModal">
                <i class="fas fa-times"></i>
            </div>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/gsap.min.js"></script>
    
</body>
</html>
