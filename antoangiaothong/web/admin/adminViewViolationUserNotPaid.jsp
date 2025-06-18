<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Violation User List</title>
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/gsap.min.js"></script>
        <style>
            .search-input {
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 20px auto;
                width: 50%;
                background: rgba(0, 243, 255, 0.1);
                border-radius: 25px;
                padding: 10px;
                box-shadow: 0 0 15px rgba(0, 243, 255, 0.5);
                transition: 0.3s;
            }

            .search-input:hover {
                box-shadow: 0 0 20px rgba(0, 243, 255, 0.8);
            }

            .search-input i {
                position: absolute;
                left: 15px;
                color: #00f3ff;
                font-size: 18px;
            }

            .search-input input {
                width: 100%;
                padding: 10px 40px;
                font-size: 16px;
                border: none;
                outline: none;
                background: transparent;
                color: #e0e0ff;
                caret-color: #00f3ff;
            }

            .search-input input::placeholder {
                color: rgba(224, 224, 255, 0.6);
                transition: 0.3s;
            }

            .search-input input:focus::placeholder {
                color: transparent;
            }

            body {
                font-family: 'Roboto', sans-serif;
                background-color: #050510;
                color: #e0e0ff;
                text-align: center;
                padding: 20px;
                opacity: 0;
            }
            h2 {
                color: #00f3ff;
                text-shadow: 0 0 10px #00f3ff;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: rgba(10, 10, 32, 0.7);
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0, 243, 255, 0.2);
                overflow: hidden;
                margin-top: 20px;
                opacity: 0;
                transform: translateY(20px);
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid rgba(0, 243, 255, 0.2);
            }
            th {
                background-color: rgba(0, 243, 255, 0.1);
                color: #00f3ff;
            }
            tr:hover {
                background-color: rgba(0, 243, 255, 0.05);
            }
            a {
                color: #ff00a0;
                text-decoration: none;
                font-weight: bold;
            }
            a:hover {
                text-shadow: 0 0 10px #ff00a0;
            }
            .paid {
                color: #00ff66;
                font-weight: bold;
            }
            .unpaid {
                color: #ff3860;
                font-weight: bold;
            }
            .btn {
                display: inline-block;
                padding: 8px 12px;
                border-radius: 5px;
                color: #fff;
                text-decoration: none;
                font-size: 14px;
                transition: all 0.3s;
                border: 1px solid;
                opacity: 0;
                transform: translateY(20px);
            }
            .btn-notify {
                background: rgba(255, 221, 87, 0.2);
                color: #ffdd57;
                border-color: #ffdd57;
            }
            .btn-notify:hover {
                background: rgba(255, 221, 87, 0.3);
                box-shadow: 0 0 10px rgba(255, 221, 87, 0.5);
            }
        </style>
    </head>
    <body>

        <h2>Kho vi phạm chưa thanh toán</h2>

        <div class="search-input">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Tìm kiếm vi phạm...">
        </div>

        <c:choose>
            <c:when test="${not empty admingetViolationUserListNotPaid}">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Violation ID</th>
                            <th>Violator ID</th>
                            <th>Violation Type</th>
                            <th>Description</th>
                            <th>Image</th>
                            <th>Video</th>
                            <th>Location</th>
                            <th>Report Date</th>
                            <th>Fine Amount</th>
                            <th>Fine Date</th>
                            <th>Plate Number</th>
                            <th>Paid Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="violation" items="${admingetViolationUserListNotPaid}">
                            <tr>
                                <td>${violation.violationID}</td>
                                <td>${violation.violatorID}</td>
                                <td>${violation.violationType}</td>
                                <td>${violation.description}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty violation.imageURL}">
                                            <a href="uploads/${violation.imageURL}" target="_blank">View Image</a>
                                        </c:when>
                                        <c:otherwise>None</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty violation.videoURL}">
                                            <a href="uploads/${violation.videoURL}" target="_blank">View Video</a>
                                        </c:when>
                                        <c:otherwise>None</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${violation.location}</td>
                                <td>${violation.reportDate}</td>
                                <td>${violation.fineAmount}</td>
                                <td>${violation.fineDate}</td>
                                <td>${violation.plateNumber}</td>   
                                <td>
                                    <c:choose>
                                        <c:when test="${violation.paidStatus}"> 
                                            <span class="paid">Paid</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="unpaid">Unpaid</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/adminSendNotification.jsp?violatorID=${violation.violatorID}&plateNumber=${violation.plateNumber}" 
                                       class="btn btn-notify">Send Notification</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p>No violations found</p>
            </c:otherwise>
        </c:choose>

        <br>
        <a href="${pageContext.request.contextPath}/view/admin.jsp" class="btn btn-notify">Back to Home</a>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                gsap.to("body", {opacity: 1, duration: 1});
                gsap.to("table", {opacity: 1, y: 0, duration: 1, delay: 0.5});
                gsap.to(".btn", {opacity: 1, y: 0, duration: 1, delay: 1, stagger: 0.2});
            });



        </script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                console.log("DOM fully loaded and parsed.");

                const searchInput = document.getElementById('searchInput');
                const tableBody = document.querySelector('.data-table tbody');

                if (!searchInput) {
                    console.error("Không tìm thấy phần tử có ID 'searchInput'. Kiểm tra lại HTML.");
                    return;
                }

                if (!tableBody) {
                    console.error("Không tìm thấy phần tử '.data-table tbody'. Kiểm tra lại HTML.");
                    return;
                }

                searchInput.addEventListener('input', function () {
                    const searchTerm = this.value.toLowerCase();
                    const tableRows = tableBody.querySelectorAll('tr');

                    console.log("Tìm kiếm:", searchTerm);
                    console.log("Số hàng tìm thấy:", tableRows.length);

                    tableRows.forEach(row => {
                        const text = row.innerText.toLowerCase();
                        const shouldShow = text.includes(searchTerm);

                        console.log(`Hàng: "${text}", Hiển thị: ${shouldShow}`);

                        row.style.display = shouldShow ? '' : 'none';
                    });
                });
            });


        </script>


    </body>
</html>