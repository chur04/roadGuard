<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String violatorID = request.getParameter("violatorID");
    String plateNumber = request.getParameter("plateNumber");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Send Notification</title>
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
        form {
            background: rgba(10, 10, 32, 0.7);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 243, 255, 0.2);
            display: inline-block;
            text-align: left;
            opacity: 0;
            transform: translateY(20px);
        }
        table {
            width: 100%;
        }
        td {
            padding: 10px;
        }
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            background: rgba(0, 243, 255, 0.1);
            color: #00f3ff;
            font-size: 14px;
        }
        input[type="submit"] {
            background: rgba(255, 221, 87, 0.2);
            color: #ffdd57;
            cursor: pointer;
            transition: all 0.3s;
        }
        input[type="submit"]:hover {
            background: rgba(255, 221, 87, 0.3);
            box-shadow: 0 0 10px rgba(255, 221, 87, 0.5);
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

<h2>Send Notification</h2>

<form action="${pageContext.request.contextPath}/AdminDoWithViolation" method="POST">
    <table>
        <tr>
            <td>Người vi phạm (ID):</td>
            <td><input type="text" name="violatorID" value="<%= violatorID %>" readonly></td>
        </tr>
        <tr>
            <td>Biển số xe:</td>
            <td><input type="text" name="plateNumber" value="<%= plateNumber %>" readonly></td>
        </tr>
        <tr>
            <td>Text:</td>
            <td><input type="text" name="notification"></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="SEND"></td>
        </tr>
    </table>
</form>

<br>
<a href="${pageContext.request.contextPath}/view/admin.jsp">Back to Home</a>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        gsap.to("body", {opacity: 1, duration: 1});
        gsap.to("form", {opacity: 1, y: 0, duration: 1, delay: 0.5});
    });
</script>

</body>
</html>