package com.example.ecommerce_app;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
public class HomeController {

    private final ProductService productService;

    public HomeController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/")
    public String index(@RequestParam(value = "search", required = false) String search,
                        @RequestParam(value = "category", required = false) String category,
                        Model model) {
        List<Product> productList;

        if (search != null && !search.isEmpty()) {
            productList = productService.searchProducts(search);
        } else if (category != null && !category.isEmpty()) {
            productList = productService.getByCategory(category);
        } else {
            productList = productService.getAllProducts();
        }

        model.addAttribute("productList", productList);
        model.addAttribute("searchQuery", search);
        return "index";
    }

    @GetMapping("/product/{id}")
    public String getProductDetails(@PathVariable("id") int id, Model model) {
        Product product = productService.getById(id);
        if (product == null) return "redirect:/";
        model.addAttribute("product", product);
        return "product-details";
    }

    @GetMapping("/profile")
    public String profile() {
        return "profile";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/admin")
    public String admin(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        return "admin";
    }
}