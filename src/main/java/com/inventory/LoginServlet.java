package com.inventory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private final String FILE_PATH = "D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\users.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Encapsulated User object
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User loginUser = new User(username, password);

        // Use abstraction to handle authentication
        UserAuthenticator authenticator = new UserAuthenticator(FILE_PATH);
        boolean isValidUser = authenticator.authenticate(loginUser);

        HttpSession session = request.getSession();

        if (isValidUser) {
            session.setAttribute("username", username);
            response.sendRedirect("userDashboard.jsp");
        } else {
            session.setAttribute("error", "Invalid username or password!");
            response.sendRedirect("login.jsp");
        }
    }
}
