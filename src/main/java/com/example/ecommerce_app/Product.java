package com.example.ecommerce_app;

public class Product {
    private int id;
    private String name;
    private double price;
    private double oldPrice;
    private String imageUrl;
    private String description;
    private int stock;
    private String category;

    public Product(int id, String name, double price, double oldPrice, String imageUrl, String description, int stock, String category) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.oldPrice = oldPrice;
        this.imageUrl = imageUrl;
        this.description = description;
        this.stock = stock;
        this.category = category;
    }

    // Getters
    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public double getOldPrice() { return oldPrice; }
    public String getImageUrl() { return imageUrl; }
    public String getDescription() { return description; }
    public int getStock() { return stock; }
    public String getCategory() { return category; }
}