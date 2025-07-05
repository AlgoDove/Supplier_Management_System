package com.inventory;

import java.io.*;
import java.nio.file.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
    private static final String USER_FILE_PATH = "D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\users.txt";
    private static final String INVENTORY_FILE_PATH = "D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\inventory.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentUsername = request.getParameter("currentUsername").trim();
        String currentPassword = request.getParameter("currentPassword").trim();
        String newUsername = request.getParameter("newUsername").trim();
        String newPassword = request.getParameter("newPassword").trim();

        File userFile = new File(USER_FILE_PATH);
        File inventoryFile = new File(INVENTORY_FILE_PATH);

        if (!userFile.exists() || !inventoryFile.exists()) {
            response.sendRedirect("update.jsp?error=Required file(s) not found!");
            return;
        }

        List<String> userLines = Files.readAllLines(Paths.get(USER_FILE_PATH));
        boolean found = false;

        // Step 1: Locate and update the user in users.txt
        for (int i = 0; i < userLines.size(); i++) {
            String line = userLines.get(i).trim();

            if (line.startsWith("name:")) {
                String foundUsername = line.substring(5).trim();

                if (i + 1 < userLines.size() && userLines.get(i + 1).trim().equals("password:" + currentPassword)) {
                    if (foundUsername.equals(currentUsername)) {
                        // Update username and password
                        userLines.set(i, "name:" + newUsername);
                        userLines.set(i + 1, "password:" + newPassword);
                        found = true;
                        break;
                    }
                }
            }
        }

        if (!found) {
            response.sendRedirect("update.jsp?error=Invalid username or password!");
            return;
        }

        // Save updated users.txt file
        Files.write(Paths.get(USER_FILE_PATH), userLines);

        // Step 2: Update inventory.txt to reflect new username
        List<String> inventoryLines = Files.readAllLines(Paths.get(INVENTORY_FILE_PATH));
        List<String> updatedInventoryLines = new ArrayList<>();
        boolean isUserSection = false;

        for (String line : inventoryLines) {
            if (line.trim().equals(currentUsername)) {
                updatedInventoryLines.add(newUsername);
                isUserSection = true;
            } else if (!line.contains(",")) { // Non-item lines
                isUserSection = false;
                updatedInventoryLines.add(line);
            } else {
                updatedInventoryLines.add(line); // Keep item details unchanged
            }
        }

        // Save updated inventory.txt
        Files.write(Paths.get(INVENTORY_FILE_PATH), updatedInventoryLines);

        response.sendRedirect("dashboard.jsp?message=Profile updated successfully.");
    }
}
