<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>

<%
    // Get registration details
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm-password");

    // Validate password match
    if (!password.equals(confirmPassword)) {
        response.sendRedirect("register.jsp?error=Passwords do not match!");
        return;
    }

    // File to store registered users
    File file = new File("D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\users.txt");
    BufferedWriter bw = null;

    try {
        if (!file.exists()) {
            file.createNewFile();
        }

        bw = new BufferedWriter(new FileWriter(file, true));

        // Write user details in the required format
        bw.write("name:" + username + "\n");
        bw.write("password:" + password + "\n");
        bw.write("------------------------------------------------------\n");
        bw.newLine();

        response.sendRedirect("login.jsp?message=Registration successful. Please log in.");
    } catch (IOException e) {
        response.getWriter().println("Error saving registration details: " + e.getMessage());
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
