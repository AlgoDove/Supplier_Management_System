package com.inventory;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RemoveItemServlet")
public class RemoveItemServlet extends HttpServlet {
    private static final String INVENTORY_FILE = "D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\inventory.txt";
    private static final String REMOVED_ITEM_FILE = "D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\removedItem.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String category = request.getParameter("itemType");
        List<String> lines = Files.readAllLines(Paths.get(INVENTORY_FILE));
        List<String> updatedLines = new ArrayList<>();
        boolean userFound = false;
        Stack<String> categoryStack = new Stack<>();

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(INVENTORY_FILE))) {
            for (int i = 0; i < lines.size(); i++) {
                String line = lines.get(i).trim();

                if (line.isEmpty()) {
                    writer.newLine(); // Maintain spacing
                    continue;
                }

                if (line.equals(username)) {
                    userFound = true;
                    writer.write(line);
                    writer.newLine();
                    continue;
                }

                if (userFound && line.contains(",")) {
                    if (line.startsWith(category + ",")) {
                        categoryStack.push(line);
                    } else {
                        writer.write(line);
                        writer.newLine();
                    }
                } else {
                    writer.write(line);
                    writer.newLine();
                }
            }

            if (!categoryStack.isEmpty()) {
                String removedItem = categoryStack.pop();
                appendToRemovedFile(username, removedItem);
            }

            while (!categoryStack.isEmpty()) {
                writer.write(categoryStack.pop());
                writer.newLine();
            }
        }

        response.sendRedirect("userDashboard.jsp");
    }

    private void appendToRemovedFile(String username, String removedItem) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REMOVED_ITEM_FILE, true))) {
            writer.write(username);
            writer.newLine();
            writer.write(removedItem);
            writer.newLine();
            writer.newLine(); // Add spacing
        }
    }
}
