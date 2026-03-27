package com.example.ecommerce_app;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class HomeController {

    @GetMapping("/")
    public String index(@RequestParam(value = "search", required = false) String search,
                        @RequestParam(value = "category", required = false) String category,
                        Model model) {

        List<Product> productList = new ArrayList<>();

        // Data Format: (id, name, currentPrice, oldPrice, imageUrl, description, stock, category)
        productList.add(new Product(1, "iPhone 15 Pro", 3599.00, 3999.00,
                "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-naturaltitanium",
                "Apple's latest flagship, A17 Pro chip.", 10, "Smartphones"));

        productList.add(new Product(2, "MacBook Air M3", 4299.00, 4599.00,
                "https://i.ytimg.com/vi/I80RHCBAhkg/maxresdefault.jpg",
                "Supercharged by M3 chip, 13.6-inch.", 5, "Laptops"));

        productList.add(new Product(3, "Apple Watch Series 9", 1299.00, 1299.00,
                "https://maxmobiles.ru/images/companies/1/Product/Apple%20Watch/Apple%20Watch%20Series%209/50.jpg?1707398072332",
                "Smarter, brighter, mightier.", 0, "Wearables"));

        // 1. Search Logic
        if (search != null && !search.isEmpty()) {
            productList = productList.stream()
                    .filter(p -> p.getName().toLowerCase().contains(search.toLowerCase()))
                    .collect(Collectors.toList());
        }

        // 2. Category Filter Logic
        if (category != null && !category.isEmpty()) {
            productList = productList.stream()
                    .filter(p -> p.getCategory().equalsIgnoreCase(category))
                    .collect(Collectors.toList());
        }

        model.addAttribute("productList", productList);
        model.addAttribute("userName", "Leila");
        model.addAttribute("searchQuery", search); // To keep the search text in the input box

        return "index";
    }
}