package com.inventory;

public class Item {
    private String type;
    private String name;
    private String company;
    private int quantity;
    private double price;
    private String purchaseDate;
    private String expiryDate;

    public Item(String type, String name, String company, int quantity, double price, String purchaseDate, String expiryDate) {
        this.type = type;
        this.name = name;
        this.company = company;
        this.quantity = quantity;
        this.price = price;
        this.purchaseDate = purchaseDate;
        this.expiryDate = expiryDate;
    }

    public String getType() { return type; }
    public String getName() { return name; }
    public String getCompany() { return company; }
    public int getQuantity() { return quantity; }
    public double getPrice() { return price; }
    public String getPurchaseDate() { return purchaseDate; }
    public String getExpiryDate() { return expiryDate; }

    public String toDataLine() {
        return type + "," + name + "," + company + "," + quantity + "," + price + "," + purchaseDate + "," + expiryDate;
    }
}
