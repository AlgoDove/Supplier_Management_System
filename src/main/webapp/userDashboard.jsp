<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import=" java.nio.file.Files, java.nio.file.Paths" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<%
    HttpSession sessionObj = request.getSession();
    String username = (String) sessionObj.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String filePath = "D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\inventory.txt";
    List<String> lines = Files.readAllLines(Paths.get(filePath));

    boolean userFound = false;
    List<String> userItems = new ArrayList<>();
    Set<String> categories = new HashSet<>();

    for (String line : lines) {
        if (line.equals(username)) {
            userFound = true;
            continue;
        }
        if (userFound) {
            if (line.trim().isEmpty()) break; // Stop reading if a blank line is found
            userItems.add(line);
            String[] details = line.split(",");
            if (details.length == 7) {
                categories.add(details[0]); // Add category
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
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
            max-width: 900px;
            width: 100%;
            text-align: center;
        }

        h1 {
            font-size: 30px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }

        p {
            color: #555;
            margin-bottom: 20px;
        }

        .filter-container {
            margin-top: 15px;
        }

        select {
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 16px;
            outline: none;
            font-family: 'Poppins', sans-serif;
        }

        .table-container {
            margin-top: 20px;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
            font-size: 15px;
        }

        th {
            background-color: #00bcd4;
            color: white;
            font-weight: 600;
        }

        td {
            background-color: #f9f9f9;
        }

        .button {
            display: inline-block;
            text-decoration: none;
            padding: 14px 22px;
            background: linear-gradient(90deg, #00bcd4, #008cba);
            color: white;
            border-radius: 10px;
            font-weight: 500;
            font-size: 16px;
            margin: 15px 10px 0 10px;
            transition: all 0.3s ease;
            font-family: 'Poppins', sans-serif;
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 188, 212, 0.3);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }

            th, td {
                font-size: 13px;
                padding: 8px;
            }

            select {
                width: 100%;
            }
        }
    </style>

    <script>
        function filterItems() {
            var selectedCategory = document.getElementById("categoryFilter").value;
            var rows = document.querySelectorAll("#itemsTable tbody tr");

            rows.forEach(row => {
                var category = row.getAttribute("data-category");
                if (selectedCategory === "all" || category === selectedCategory) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
    </script>
</head>
<body>

<div class="container">
    <h1>Welcome, <%= username %>!</h1>
    <p>Here are your available stock details:</p>

    <div class="filter-container">
        <label for="categoryFilter">Filter by Category:</label>
        <select id="categoryFilter" onchange="filterItems()">
            <option value="all">All Categories</option>
            <% for (String category : categories) { %>
            <option value="<%= category %>"><%= category %></option>
            <% } %>
        </select>
    </div>

    <div class="table-container">
        <% if (!userItems.isEmpty()) { %>
        <table id="itemsTable">
            <thead>
            <tr>
                <th>Item Name</th>
                <th>Item Type</th>
                <th>Company</th>
                <th>Quantity</th>
                <th>Price per Item</th>
                <th>Total Price</th>
                <th>Purchase Date</th>
                <th>Expiry Date</th>
            </tr>
            </thead>
            <tbody>
            <% for (String item : userItems) {
                String[] details = item.split(",");
                if (details.length == 7) {
                    String itemType = details[0];
                    String itemName = details[1];
                    String company = details[2];
                    int quantity = Integer.parseInt(details[3]);
                    double price = Double.parseDouble(details[4]);
                    double totalPrice = quantity * price;
                    String purchaseDate = details[5];
                    String expiryDate = details[6];
            %>
            <tr data-category="<%= itemType %>">
                <td><%= itemName %></td>
                <td><%= itemType %></td>
                <td><%= company %></td>
                <td><%= quantity %></td>
                <td><%= price %>/=</td>
                <td><%= totalPrice %>/=</td>
                <td><%= purchaseDate %></td>
                <td><%= expiryDate %></td>
            </tr>
            <% }
            } %>
            </tbody>
        </table>
        <% } else { %>
        <p style="color: #888;">No items found.</p>
        <% } %>
    </div>

    <div>
        <a href="dashboard.jsp" class="button">Track Inventory</a>
        <a href="LogoutServlet" class="button">Logout</a>
    </div>
</div>

</body>
</html>
