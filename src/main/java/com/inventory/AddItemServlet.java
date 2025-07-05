package com.inventory;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.util.*;

@WebServlet("/AddItemServlet")
public class AddItemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getSession().getAttribute("username").toString();

        Item item = new Item(
                request.getParameter("itemType"),
                request.getParameter("itemName"),
                request.getParameter("companyName"),
                Integer.parseInt(request.getParameter("itemQuantity")),
                Double.parseDouble(request.getParameter("itemPrice")),
                request.getParameter("purchaseDate"),
                request.getParameter("expiryDate")
        );

        String inventoryPath = "D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\inventory.txt";
        String stockInventoryPath = "D:\\Bimsara\\Sliit\\Year 1\\S2\\Project Last\\Inventory-Stock-Management-Final-Project\\src\\main\\webapp\\stockInventory.txt";

        InventoryManager manager = new InventoryManager(inventoryPath, stockInventoryPath);
        manager.addItemToInventory(username, item);
        manager.updateStockInventory(item);

        response.sendRedirect("userDashboard.jsp");
    }
}
