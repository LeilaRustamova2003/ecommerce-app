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
        List<Product> productList = new ArrayList<>();


        productList.add(new Product(1, "iPhone 15 Pro", 3599.00,
                "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-naturaltitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692845710811",
                "Apple's latest flagship, A17 Pro chip."));

        productList.add(new Product(2, "MacBook Air M3", 4299.00,
                "https://p.turbosquid.com/ts-thumb/2P/b7OlEw/IG/gray06/jpg/1709794616/1920x1080/fit_q87/60fb232038e55b7107d3acf05a1bf439f064e97b/gray06.jpg",
                "Supercharged by M3 chip, 13.6-inch."));

        productList.add(new Product(3, "Apple Watch Series 9", 1299.00,
                "https://xn--80acvibpxfdi5h.xn--e1anecbk3a.xn--p1ai/wp-content/uploads/2023/10/apple-watch-s9-kategoriya.jpg",
                "Smarter, brighter, mightier."));

        model.addAttribute("productList", productList);
        model.addAttribute("userName", "Leila");

        return "index";
    }
}