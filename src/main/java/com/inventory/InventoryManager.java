package com.inventory;

import java.io.*;
import java.util.*;

public class InventoryManager {

    private String inventoryFilePath;
    private String stockInventoryFilePath;

    public InventoryManager(String inventoryFilePath, String stockInventoryFilePath) {
        this.inventoryFilePath = inventoryFilePath;
        this.stockInventoryFilePath = stockInventoryFilePath;
    }

    public void addItemToInventory(String username, Item item) throws IOException {
        File file = new File(inventoryFilePath);
        List<String> lines = new ArrayList<>();

        if (file.exists()) {
            BufferedReader reader = new BufferedReader(new FileReader(file));
            String line;
            while ((line = reader.readLine()) != null) lines.add(line);
            reader.close();
        }

        List<String> updatedLines = new ArrayList<>();
        boolean userFound = false;

        for (int i = 0; i < lines.size(); i++) {
            String line = lines.get(i);
            updatedLines.add(line);

            if (line.trim().equals(username)) {
                userFound = true;
                while (i + 1 < lines.size() && lines.get(i + 1).trim().isEmpty()) i++;
                updatedLines.add(item.toDataLine());
            }

            if (i + 1 < lines.size() && isUsername(line) && isUsername(lines.get(i + 1))) {
                updatedLines.add("");
            }
        }

        if (!userFound) {
            if (!lines.isEmpty()) updatedLines.add("");
            updatedLines.add(username);
            updatedLines.add(item.toDataLine());
        }

        BufferedWriter writer = new BufferedWriter(new FileWriter(inventoryFilePath));
        for (String l : updatedLines) {
            writer.write(l);
            writer.newLine();
        }
        writer.close();
    }

    public void updateStockInventory(Item item) throws IOException {
        List<String> updatedStock = new ArrayList<>();
        BufferedReader reader = new BufferedReader(new FileReader(stockInventoryFilePath));
        String line;
        while ((line = reader.readLine()) != null) {
            if (line.contains(item.getName()) && line.contains(item.getCompany())) {
                String[] parts = line.split(",");
                int newStock = Integer.parseInt(parts[3]) - item.getQuantity();
                updatedStock.add(parts[0] + "," + parts[1] + "," + parts[2] + "," + newStock + "," + parts[4] + "," + parts[5] + "," + parts[6]);
            } else {
                updatedStock.add(line);
            }
        }
        reader.close();

        BufferedWriter writer = new BufferedWriter(new FileWriter(stockInventoryFilePath));
        for (String s : updatedStock) {
            writer.write(s + "\n");
        }
        writer.close();
    }

    private boolean isUsername(String line) {
        return !line.contains(",") && !line.trim().isEmpty();
    }
}
