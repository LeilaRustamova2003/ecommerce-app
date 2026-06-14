package com.example.ecommerce_app;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@Service
public class ProductService {

    private final ProductRepository repository;

    public ProductService(ProductRepository repository) {
        this.repository = repository;
    }

    @Cacheable("products")
    public List<Product> getAllProducts() {
        return repository.findAll();
    }

    @CacheEvict(value = "products", allEntries = true)
    public void evictProductCache() {}

    public List<Product> searchProducts(String name) {
        return repository.findByNameContainingIgnoreCase(name);
    }

    public List<Product> getByCategory(String category) {
        return repository.findByCategoryIgnoreCase(category);
    }

    public Product getById(int id) {
        return repository.findById(id).orElse(null);
    }

    @Async
    public CompletableFuture<Integer> getStockAsync(int productId) {
        Product p = repository.findById(productId).orElse(null);
        int stock = (p != null) ? p.getStock() : 0;
        return CompletableFuture.completedFuture(stock);
    }
}