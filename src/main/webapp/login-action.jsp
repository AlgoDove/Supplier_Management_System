<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>
<%
    // Get registration details from form
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // File that stores registered users (username:password format)
    String filePath = application.getRealPath("users.txt");
    File file = new File("D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\users.txt");
    BufferedWriter bw = null;

    try {
        // If file doesn't exist, create a new one
        if (!file.exists()) {
            file.createNewFile();
        }

        bw = new BufferedWriter(new FileWriter(file, true)); // Append mode

        // Write new user details to the file
        bw.write(username + ":" + password);
        bw.newLine();

        // Redirect to login page after successful registration
        response.sendRedirect("login.jsp?message=Registration successful. Please log in.");
    } catch (Exception e) {
        response.getWriter().println("Error saving registration details.");
    } finally {
        if (bw != null) {
            try {
                bw.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
%>
