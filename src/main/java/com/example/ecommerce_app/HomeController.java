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
                "https://www.apple.com/v/macbook-air-13-and-15-m3/a/images/overview/hero/hero__f1j9y92976iu_large_2x.jpg",
                "Supercharged by M3 chip, 13.6-inch."));

        productList.add(new Product(3, "Apple Watch Series 9", 1299.00,
                "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MT633_VW_34FR+watch-case-45-aluminum-starlight-nc-s9_VW_34FR+watch-face-45-aluminum-starlight-s9_VW_34FR?wid=2000&hei=2000&fmt=png-alpha&.v=1694507905182",
                "Smarter, brighter, mightier."));

        model.addAttribute("productList", productList);
        model.addAttribute("userName", "Leila");

        return "index";
    }
}