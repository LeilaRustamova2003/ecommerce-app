package com.example.ecommerce_app;

import javax.persistence.*;

@Entity
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    private double price;
    private double oldPrice;
    private String imageUrl;
    private String description;
    private int stock;
    private String category;

    public Product() {}

    public Product(int id, String name, double price, double oldPrice,
                   String imageUrl, String description, int stock, String category) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.oldPrice = oldPrice;
        this.imageUrl = imageUrl;
        this.description = description;
        this.stock = stock;
        this.category = category;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public double getOldPrice() { return oldPrice; }
    public String getImageUrl() { return imageUrl; }
    public String getDescription() { return description; }
    public int getStock() { return stock; }
    public String getCategory() { return category; }

    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setPrice(double price) { this.price = price; }
    public void setOldPrice(double oldPrice) { this.oldPrice = oldPrice; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public void setDescription(String description) { this.description = description; }
    public void setStock(int stock) { this.stock = stock; }
    public void setCategory(String category) { this.category = category; }
}