<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    // Check if the user is logged in
    HttpSession session1 = request.getSession(false);
    String user = (session1 != null) ? (String) session1.getAttribute("username") : null;

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Inventory Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #00bcd4, #008cba);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            animation: fadeIn 1s ease-in-out;
        }

        .container {
            background: #fff;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            max-width: 700px;
            width: 100%;
            text-align: center;
        }

        .hero i {
            font-size: 60px;
            color: #00bcd4;
            margin-bottom: 20px;
        }

        h1 {
            font-size: 30px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }

        .welcome {
            font-size: 18px;
            color: #666;
            margin-bottom: 25px;
        }

        p {
            color: #555;
            font-size: 16px;
            margin-bottom: 25px;
        }

        .button {
            display: inline-block;
            text-decoration: none;
            padding: 14px 24px;
            background: linear-gradient(90deg, #00bcd4, #008cba);
            color: white;
            border-radius: 10px;
            font-weight: 500;
            font-size: 16px;
            margin: 10px;
            transition: all 0.3s ease;
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 188, 212, 0.3);
        }

        .footer {
            margin-top: 30px;
        }

        .footer a {
            color: #008cba;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }

            .button {
                font-size: 14px;
                padding: 12px 20px;
                margin: 8px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="hero">
        <i class="bi bi-box-seam"></i>
        <h1>Inventory Dashboard</h1>
        <p class="welcome">Welcome, <strong><%= user %></strong>!</p>
    </div>

    <p>Manage your inventory with ease. Add, remove, and view items efficiently.</p>

    <a href="addItem.jsp" class="button">Add Item</a>
    <a href="removeItem.jsp" class="button">Remove Item</a>
    <a href="viewItem.jsp" class="button">View Items</a>


    <div class="footer">
        <p><a href="userDashboard.jsp">Back to User Dashboard</a></p>
    </div>
</div>

</body>
</html>
