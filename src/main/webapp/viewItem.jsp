<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.nio.file.Files, java.nio.file.Paths, java.util.*" %>
<%@ page import="utils.UserUtils" %>



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
    List<String[]> userItems = new ArrayList<>();

    for (String line : lines) {
        if (line.equals(username)) {
            userFound = true;
            continue;
        }
        if (userFound) {
            if (line.trim().isEmpty()) break; // Stop reading if a blank line is found
            userItems.add(line.split(",")); // Convert each line into an array
        }
    }

    // Apply Merge Sort on userItems (sorting by expiry date)
    if (!userItems.isEmpty()) {
        UserUtils.mergeSort(userItems, 0, userItems.size() - 1);
    }

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View User Items</title>
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
        }
        .container {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 1000px;
            width: 100%;
            text-align: center;
        }
        h1 {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
        }
        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #00bcd4;
            color: white;
            font-weight: bold;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            background-color: #00bcd4;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #008cba;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Welcome, <%= username %>!</h1>
    <p>Here are your available stock details (Sorted by Expiry Date using Merge Sort):</p>

    <div class="table-container">
        <% if (!userItems.isEmpty()) { %>
        <table>
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
            <% for (String[] details : userItems) {
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
            <tr>
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
        </table>
        <% } else { %>
        <p style="color: #888;">No items found.</p>
        <% } %>
    </div>

    <div>
        <a href="dashboard.jsp" class="button">Back to Inventory Dashboard</a>
    </div>
</div>

</body>
</html>
