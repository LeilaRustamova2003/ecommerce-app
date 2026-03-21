package com.example.ecommerce_app;

        import org.springframework.stereotype.Controller;
        import org.springframework.ui.Model;
        import org.springframework.web.bind.annotation.GetMapping;
        import java.util.ArrayList;
        import java.util.List;

@Controller
public class HomeController {

    @GetMapping("/")
    public String index(Model model) {
        List<Product> products = new ArrayList<>();

        products.add(new Product(1, "iPhone 15 Pro", 3500.0, "128GB, Black Titanium"));
        products.add(new Product(2, "MacBook Air M3", 4200.0, "8GB RAM, 256GB SSD"));
        products.add(new Product(3, "Sony WH-1000XM5", 950.0, "Wireless Noise Cancelling"));

        model.addAttribute("productList", products);
        model.addAttribute("userName", "Leila Rustamova");
        return "index";
    }
}