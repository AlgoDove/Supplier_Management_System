<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile - Inventory Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #0077b6, #00b4d8);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h2{
            text-align: center;
            margin-bottom: 30px;
        }

        .container {
            background-color: #ffffff;
            padding: 50px 30px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            max-width: 420px;
            width: 100%;
            animation: fadeIn 1s ease-in-out;
        }


        .hero i {
            font-size: 48px;
            color: #00b4d8;
            margin-bottom: 10px;
        }

        h2 {
            font-size: 28px;
            color: #222;
            font-weight: 600;
        }


        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            font-weight: 500;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }

        .input-group input {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
            outline: none;
            transition: border 0.3s ease;
        }

        .input-group input:focus {
            border-color: #00b4d8;
        }

        .button {
            width: 100%;
            padding: 14px;
            margin-top: 10px;
            border: none;
            border-radius: 10px;
            font-size: 17px;
            font-weight: 500;
            color: white;
            background: linear-gradient(90deg, #00b4d8, #0077b6);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 183, 255, 0.3);
        }

        .button-link {
            display: block;
            width: 100%;
            text-align: center;
            padding: 12px;
            background: linear-gradient(90deg, #00b4d8, #0077b6);
            color: white;
            border-radius: 10px;
            font-size: 17px;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            margin-top: 10px;
            transition: all 0.3s ease;
        }

        .button-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 183, 255, 0.3);
        }

        .footer {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .footer a {
            color: #0077b6;
            text-decoration: none;
            font-weight: 500;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Update Profile</h2>

    <% String error = request.getParameter("error");
        if (error != null) { %>
    <p class="error"><%= error %></p>
    <% } %>

    <form action="UpdateServlet" method="post">
        <div class="input-group">
            <label for="current-username">Current Username</label>
            <input type="text" id="current-username" name="currentUsername" required>
        </div>
        <div class="input-group">
            <label for="current-password">Current Password</label>
            <input type="password" id="current-password" name="currentPassword" required>
        </div>
        <div class="input-group">
            <label for="new-username">New Username</label>
            <input type="text" id="new-username" name="newUsername" required>
        </div>
        <div class="input-group">
            <label for="new-password">New Password</label>
            <input type="password" id="new-password" name="newPassword" required>
        </div>
        <button type="submit" name="role" value="update" class="button update-btn">Update Password</button>
    </form>


    <div class="footer">
        <p><a href="userDashboard.jsp">Back to Dashboard</a></p>
    </div>
</div>

</body>
</html>
