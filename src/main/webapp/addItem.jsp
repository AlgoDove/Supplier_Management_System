<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Item - Inventory Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #00bcd4, #008cba);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            max-width: 500px;
            width: 100%;
        }

        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
        }

        .form-control {
            border-radius: 6px;
            border: 1px solid #ccc;
            padding: 10px 12px;
            transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }

        .form-control:focus {
            border-color: #00bcd4;
            box-shadow: 0 0 0 0.2rem rgba(0, 188, 212, 0.25);
        }

        .btn-primary {
            background-color: #00bcd4;
            border-color: #00bcd4;
            border-radius: 6px;
            padding: 10px 16px;
            font-weight: 600;
            transition: background-color 0.2s ease;
        }

        .btn-primary:hover {
            background-color: #0097a7;
            border-color: #0097a7;
        }
    </style>

    <script>
        // Function to set today's date as the purchase date
        function setPurchaseDate() {
            let today = new Date();
            let yyyy = today.getFullYear();
            let mm = String(today.getMonth() + 1).padStart(2, '0'); // Month is 0-based
            let dd = String(today.getDate()).padStart(2, '0');
            let formattedDate = yyyy + '-' + mm + '-' + dd;

            document.getElementById("purchaseDate").value = formattedDate;
        }
        window.onload = setPurchaseDate;
    </script>

</head>
<body>

<%
    // Read suppliersInventory.txt and store data
    String filePath ="D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\stockInventory.txt";
    Map<String, Map<String, Map<String, List<String[]>>>> inventoryData = new LinkedHashMap<>();

    String currentSupplier = null;

    try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
        String line;
        while ((line = br.readLine()) != null) {
            if (!line.contains(",")) {
                currentSupplier = line.trim();
                continue;
            }

            String[] parts = line.split(",");
            if (parts.length >= 7) {
                String category = parts[1].trim();
                String itemName = parts[2].trim();
                String price = parts[4].trim();
                String expiryDate = parts[6].trim();
                String company = parts[0].trim(); // Added company

                inventoryData.putIfAbsent(category, new LinkedHashMap<>());
                inventoryData.get(category).putIfAbsent(itemName, new LinkedHashMap<>());
                inventoryData.get(category).get(itemName).putIfAbsent(company, new ArrayList<>());
                inventoryData.get(category).get(itemName).get(company).add(new String[]{price, expiryDate});
            }
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
%>


<div class="container">
    <h2 class="text-center">Add New Item</h2>
    <form action="AddItemServlet" method="post">

        <!-- Category Selection -->
        <div class="mb-3">
            <label for="itemType" class="form-label">Item Type</label>
            <select id="itemType" name="itemType" class="form-select" required onchange="updateItems()">
                <option value="">Select Category</option>
                <% for (String category : inventoryData.keySet()) { %>
                <option value="<%= category %>"><%= category %></option>
                <% } %>
            </select>
        </div>

        <!-- Item Selection -->
        <div class="mb-3">
            <label for="itemName" class="form-label">Item Name</label>
            <select id="itemName" name="itemName" class="form-select" required onchange="updateCompanies()">
                <option value="">Select Item</option>
            </select>
        </div>

        <!-- Company Selection -->
        <div class="mb-3">
            <label for="companyName" class="form-label">Company Name</label>
            <select id="companyName" name="companyName" class="form-select" required onchange="updateDetails()">
                <option value="">Select Company</option>
            </select>
        </div>

        <!-- Quantity Input -->
        <div class="mb-3">
            <label for="itemQuantity" class="form-label">Quantity</label>
            <input type="number" id="itemQuantity" name="itemQuantity" class="form-control" required placeholder="Enter item quantity" oninput="updateTotalPrice()">
        </div>

        <!-- Price per Item (Read-Only) -->
        <div class="mb-3">
            <label for="itemPrice" class="form-label">Price per Item</label>
            <input type="number" id="itemPrice" name="itemPrice" class="form-control" readonly>
        </div>

        <!-- Total Price (Read-Only) -->
        <div class="mb-3">
            <label for="totalPrice" class="form-label">Total Price</label>
            <input type="number" id="totalPrice" name="totalPrice" class="form-control" readonly>
        </div>

        <!-- Purchase Date (User Selectable) -->
        <div class="mb-3">
            <label for="purchaseDate" class="form-label">Purchase Date</label>
            <input type="date" id="purchaseDate" name="purchaseDate" class="form-control" required>
        </div>

        <!-- Expiry Date (Read-Only) -->
        <div class="mb-3">
            <label for="expiryDate" class="form-label">Expiry Date</label>
            <input type="date" id="expiryDate" name="expiryDate" class="form-control" readonly>
        </div>

        <button type="submit" class="btn btn-primary w-100">Add Item</button>
    </form>
</div>

<script>
    var inventoryData = {
        <% for (String category : inventoryData.keySet()) { %>
        "<%= category %>": {
            <% for (String item : inventoryData.get(category).keySet()) { %>
            "<%= item %>": {
                <% for (String company : inventoryData.get(category).get(item).keySet()) {
                    String[] details = inventoryData.get(category).get(item).get(company).get(0);
                %>
                "<%= company %>": { price: "<%= details[0] %>", expiryDate: "<%= details[1] %>" },
                <% } %>
            },
            <% } %>
        },
        <% } %>
    };

    function updateItems() {
        var category = document.getElementById("itemType").value;
        var itemSelect = document.getElementById("itemName");
        itemSelect.innerHTML = '<option value="">Select Item</option>';

        if (category in inventoryData) {
            for (var item in inventoryData[category]) {
                itemSelect.innerHTML += `<option value="${item}">${item}</option>`;
            }
        }
        updateCompanies();
    }

    function updateCompanies() {
        var category = document.getElementById("itemType").value;
        var item = document.getElementById("itemName").value;
        var companySelect = document.getElementById("companyName");
        companySelect.innerHTML = '<option value="">Select Company</option>';

        if (category in inventoryData && item in inventoryData[category]) {
            for (var company in inventoryData[category][item]) {
                companySelect.innerHTML += `<option value="${company}">${company}</option>`;
            }
        }
        updateDetails();
    }

    function updateDetails() {
        var category = document.getElementById("itemType").value;
        var item = document.getElementById("itemName").value;
        var company = document.getElementById("companyName").value;

        if (category in inventoryData && item in inventoryData[category] && company in inventoryData[category][item]) {
            document.getElementById("itemPrice").value = inventoryData[category][item][company].price;
            document.getElementById("expiryDate").value = inventoryData[category][item][company].expiryDate;
        }
        updateTotalPrice();
    }

    function updateTotalPrice() {
        var quantity = document.getElementById("itemQuantity").value;
        var price = document.getElementById("itemPrice").value;
        document.getElementById("totalPrice").value = quantity * price;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
