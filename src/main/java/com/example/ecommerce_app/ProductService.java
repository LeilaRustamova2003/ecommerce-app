package com.example.ecommerce_app;

import org.springframework.stereotype.Service;
import java.util.List;

@Service // Stereotype Annotation: სერვისის ფენა
public class ProductService {

    private final ProductRepository repository;

    // Dependency Injection: კონსტრუქტორის მეშვეობით
    public ProductService(ProductRepository repository) {
        this.repository = repository;
    }

    public List<Product> getAllProducts() {
        return repository.findAll();
    }

    public List<Product> searchProducts(String name) {
        return repository.findByNameContainingIgnoreCase(name);
    }

    public List<Product> getByCategory(String category) {
        return repository.findByCategoryIgnoreCase(category);
    }

    public Product getById(int id) {
        return repository.findById(id).orElse(null);
    }
}