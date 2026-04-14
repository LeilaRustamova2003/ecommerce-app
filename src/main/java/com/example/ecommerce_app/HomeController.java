package com.example.ecommerce_app;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;
import java.util.List;

@Controller
public class HomeController {

    private final ProductService productService;

    // Dependency Injection გამოყენება
    public HomeController(ProductService productService) {
        this.productService = productService;
    }

    // (See More)
    @GetMapping("/product/{id}")
    public String getProductDetails(@PathVariable("id") int id, Model model) {
        Product product = productService.getById(id);

        if(product == null){
            return "redirect:/";
        }

        model.addAttribute("product", product);
        model.addAttribute("userName", "User");

        return "product-details";
    }

    @GetMapping("/")
    public String index(@RequestParam(value = "search", required = false) String search,
                        @RequestParam(value = "category", required = false) String category,
                        Model model) {

        List<Product> productList;

        // მონაცემების ფილტრაცია სერვისის მეშვეობით
        if (search != null && !search.isEmpty()) {
            productList = productService.searchProducts(search);
        } else if (category != null && !category.isEmpty()) {
            productList = productService.getByCategory(category);
        } else {
            productList = productService.getAllProducts();
        }

        model.addAttribute("productList", productList);
        model.addAttribute("userName", "Leila");
        model.addAttribute("searchQuery", search);

        return "index";
    }
}