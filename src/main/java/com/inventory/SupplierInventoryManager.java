package com.inventory;

import utils.CustomStack;
import java.io.*;
import java.util.*;

public class SupplierInventoryManager extends AbstractInventoryManager<StockEntry> {
    private final Map<String, CustomStack<StockEntry>> supplierStacks; //A Map to hold each supplier's username and their stack of items

    public SupplierInventoryManager(String supplierFile, String stockFile) throws IOException {
        super(supplierFile, stockFile);
        this.supplierStacks = new HashMap<>();
        loadInventory(); // Initial load
    }

    private void loadInventory() throws IOException {
        supplierStacks.clear();
        List<String> lines = readLines(); //Reads all lines from inventory.txt.
        String currentSupplier = null;
        CustomStack<StockEntry> currentStack = null;

        for (String line : lines) {
            if (line.trim().isEmpty()) continue;

            if (!line.contains(",")) {
                currentSupplier = line; //Sets currentSupplier
                currentStack = new CustomStack<>(); //Creates a new CustomStack for them
                supplierStacks.put(currentSupplier, currentStack);//Adds it to supplierStacks
            } else if (currentSupplier != null) {
                StockEntry entry = StockEntry.fromString(line);//Convert line to a StockEntry object
                currentStack.push(entry);//Push it onto the current supplier's stack
            }
        }
    }

    public void reloadInventory() throws IOException {
        loadInventory();
    } //refresh the stack data without restarting the program.

    @Override
    public void addStock(String supplierUsername, StockEntry entry) throws IOException {
        CustomStack<StockEntry> stack = supplierStacks.computeIfAbsent(
                supplierUsername,
                k -> new CustomStack<>()
        );

        stack.push(entry);
        saveInventoryToFile();
        appendToStockFile(entry.toString());
    }

    void saveInventoryToFile() throws IOException {
        List<String> lines = new ArrayList<>();

        for (Map.Entry<String, CustomStack<StockEntry>> entry : supplierStacks.entrySet()) {
            lines.add(entry.getKey());

            Object[] items = entry.getValue().getRemainingItems();
            for (Object obj : items) {
                StockEntry item = (StockEntry) obj;  // explicit cast here
                lines.add(item.toString());
            }

            lines.add("");
        }

        writeLines(lines);
    }

    public CustomStack<StockEntry> getSupplierStack(String supplierUsername) {
        return supplierStacks.get(supplierUsername);
    }
}
