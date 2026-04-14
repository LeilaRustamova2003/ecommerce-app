package com.example.ecommerce_app;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

// JpaRepository გამოიყენება ბაზასთან სამუშაოდ
public interface ProductRepository extends JpaRepository<Product, Integer> {
    // Method-Name Queries: ავტომატური ფილტრაცია სახელის მიხედვით
    List<Product> findByNameContainingIgnoreCase(String name);
    List<Product> findByCategoryIgnoreCase(String category);
}
