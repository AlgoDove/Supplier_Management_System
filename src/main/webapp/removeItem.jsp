<%@ page import="java.io.*, java.nio.file.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sessionObj = request.getSession();
    String username = (String) sessionObj.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String inventoryFile = "D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\inventory.txt";
    List<String> lines = Files.readAllLines(Paths.get(inventoryFile));
    Set<String> categories = new LinkedHashSet<>();
    boolean userFound = false;

    for (String line : lines) {
        if (line.trim().isEmpty()) continue;
        if (line.equals(username)) {
            userFound = true;
            continue;
        }
        if (userFound && line.contains(",")) {
            String category = line.split(",")[0]; // Extract category name
            categories.add(category);
        } else if (userFound) {
            break; // Stop when reaching another user
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remove Item - Inventory Management</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #00bcd4, #008cba);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            background: #fff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
        }

        .hero {
            text-align: center;
            margin-bottom: 30px;
        }

        .hero i {
            font-size: 50px;
            color: #00bcd4;
            margin-bottom: 15px;
        }

        h1 {
            font-size: 28px;
            font-weight: 600;
            color: #333;
        }

        .input-group {
            margin-bottom: 25px;
        }

        .input-group label {
            font-size: 15px;
            color: #333;
            font-weight: 600;
            margin-bottom: 6px;
            display: block;
        }

        .input-group select {
            width: 100%;
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .input-group select:focus {
            border-color: #00bcd4;
            box-shadow: 0 0 0 0.15rem rgba(0, 188, 212, 0.25);
            outline: none;
        }

        .button {
            width: 100%;
            padding: 12px 0;
            background-color: #00bcd4;
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .button:hover {
            background-color: #0097a7;
        }

        .footer {
            text-align: center;
            margin-top: 25px;
        }

        .footer a {
            color: #008cba;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: text-decoration 0.2s ease;
        }

        .footer a:hover {
            text-decoration: underline;
        }
    </style>

</head>
<body>

<div class="container">
    <div class="hero">
        <i class="bi bi-trash"></i>
        <h1>Remove Last Item</h1>
    </div>

    <form action="RemoveItemServlet" method="post">
        <div class="input-group">
            <label for="itemType">Select Category</label>
            <select id="itemType" name="itemType" required>
                <option value="">-- Select Category --</option>
                <% for (String category : categories) { %>
                <option value="<%= category %>"><%= category %></option>
                <% } %>
            </select>
        </div>

        <div class="input-group">
            <label for="itemName">Select Item</label>
            <select id="itemName" name="itemName" required>
                <option value="">-- Select Item --</option>
            </select>
        </div>

        <button type="submit" class="button">Remove Item</button>
    </form>

    <div class="footer">
        <p><a href="userDashboard.jsp">Back to Dashboard</a></p>
    </div>
</div>

<script>
    $(document).ready(function () {
        $("#itemType").change(function () {
            var category = $(this).val();
            if (category !== "") {
                $.ajax({
                    type: "POST",
                    url: "FetchItemsServlet",
                    data: { category: category },
                    success: function (response) {
                        $("#itemName").html(response);
                    }
                });
            } else {
                $("#itemName").html('<option value="">-- Select Item --</option>');
            }
        });
    });
</script>

</body>
</html>
