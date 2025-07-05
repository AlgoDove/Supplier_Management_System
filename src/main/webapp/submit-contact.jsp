<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<html>
<head>
    <title>Contact Us - Response Submitted</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f4f4f4;
            padding-top: 100px;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px #ccc;
            display: inline-block;
        }
        h1 {
            color: #333;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            text-decoration: none;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            font-size: 16px;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Thank You for Your Submission!</h1>
    <p>Your message has been successfully submitted.</p>
    <a href="index.jsp" class="button">Go back to Home</a>

    <%
        // Getting form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // File path where we will store the responses (use absolute path for production)
        String filePath = application.getRealPath("/") + "contact_responses.txt";

        // Prepare the text to be written to the file
        String responseText = "Name: " + name + "\n" +
                "Email: " + email + "\n" +
                "Subject: " + subject + "\n" +
                "Message: " + message + "\n" +
                "------------------------------------------------------\n";

        try {
            // Writing to the file (append mode)
            FileWriter fileWriter = new FileWriter("C:\\Users\\paves\\Videos\\Inventory-Management-System\\contact_responses.txt", true);
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            bufferedWriter.write(responseText);  // Write the form data
            bufferedWriter.close();  // Close the file after writing
        } catch (IOException e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>
</div>
</body>
</html>
