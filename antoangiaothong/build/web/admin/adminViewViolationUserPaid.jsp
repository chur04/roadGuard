<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Violation User List</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/gsap.min.js"></script>
    <style>
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
        input[type="text"] {
            width: 50%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #00f3ff;
            border-radius: 5px;
            background: #111;
            color: #fff;
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
        .paid {
            color: #00ff66;
            font-weight: bold;
        }
        .unpaid {
            color: #ff3860;
            font-weight: bold;
        }
        a {
            color: #ff00a0;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-shadow: 0 0 10px #ff00a0;
        }
    </style>
</head>
<body>

<h2>Tổng kho vi phạm</h2>

<!-- Ô tìm kiếm -->
<input type="text" id="searchInput" placeholder="Tìm kiếm vi phạm...." onkeyup="filterTable()">

<c:choose>
    <c:when test="${not empty admingetViolationUserListPaid}">
        <table id="violationTable">
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
            </tr>
            <c:forEach var="violation" items="${admingetViolationUserListPaid}">
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
                        <span class="paid">Paid</span>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
        <p>No violations found</p>
    </c:otherwise>
</c:choose>

<br>
<a href="${pageContext.request.contextPath}/view/admin.jsp" class="btn">Back to Home</a>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        gsap.to("body", {opacity: 1, duration: 1});
        gsap.to("table", {opacity: 1, y: 0, duration: 1, delay: 0.5});
    });

    function filterTable() {
        let input = document.getElementById("searchInput").value.toLowerCase();
        let table = document.getElementById("violationTable");
        let rows = table.getElementsByTagName("tr");

        for (let i = 1; i < rows.length; i++) {
            let text = rows[i].textContent.toLowerCase();
            rows[i].style.display = text.includes(input) ? "" : "none";
        }
    }
</script>

</body>
</html>
    