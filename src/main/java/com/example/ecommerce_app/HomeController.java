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

        // Format: (id, name, price, oldPrice, imageUrl, description, stock, category)

        // Smartphones Category
        productList.add(new Product(1, "iPhone 15 Pro", 3599.0, 3999.0, "https://media.idownloadblog.com/wp-content/uploads/2023/09/iPhone-15-regular-and-pro.jpg", "A17 Pro chip.", 10, "Phone"));
        productList.add(new Product(2, "Samsung Galaxy S24", 2800.0, 3100.0, "https://avatars.mds.yandex.net/get-mpic/5249393/img_id638847272890887797.png/orig", "AI powered smartphone.", 8, "Phone"));

        // Laptops Category
        productList.add(new Product(3, "MacBook Air M3", 4299.0, 4599.0, "https://i.ytimg.com/vi/UFyC5SgtVDU/maxresdefault.jpg", "Supercharged by M3.", 5, "Computer"));
        productList.add(new Product(4, "Dell XPS 15", 3800.0, 4100.0, "https://avatars.mds.yandex.net/get-mpic/4362548/img_id411826385836613756.jpeg/orig", "InfinityEdge display.", 3, "Computer"));

        // Watches Category
        productList.add(new Product(5, "Apple Watch Series 9", 1299.0, 1399.0, "https://main-cdn.sbermegamarket.ru/mid9/hlr-system/-23/339/060/112/710/32/100065084348b0.png", "Smarter, brighter.", 15, "Watch"));
        productList.add(new Product(6, "Garmin Fenix 7", 1500.0, 1500.0, "https://cdn1.ozone.ru/s3/multimedia-1-r/7123807827.jpg", "Rugged outdoor watch.", 4, "Watch"));

        // Audio Category
        productList.add(new Product(7, "Sony WH-1000XM5", 950.0, 1100.0, "https://www.cactus.md/ijpg.ashx?i=/i/products/32/162561.jpg", "Noise cancelling.", 12, "Audio"));
        productList.add(new Product(8, "AirPods Pro 2", 650.0, 750.0, "https://basket-21.wbbasket.ru/vol3680/part368030/368030542/images/big/1.webp", "MagSafe charging.", 20, "Audio"));

        // Accessories Category
        productList.add(new Product(9, "Samsung T7 SSD", 450.0, 500.0, "https://i.ytimg.com/vi/dWktvLj-ino/hq720.jpg", "1TB Portable SSD.", 25, "PC Accessory"));
        productList.add(new Product(10, "Logitech MX Master 3S", 300.0, 350.0, "https://i.rtings.com/assets/products/tfI79vsP/logitech-mx-master-3s/design-medium.jpg?format=auto", "Wireless mouse.", 15, "PC Accessory"));

        // Tablet Category
        productList.add(new Product(11, "iPad Air M2", 2100.0, 2400.0,  "https://p.turbosquid.com/ts-thumb/LD/GP6s9d/xv/1/jpg/1744127052/1920x1080/fit_q87/cc6074ddd21c5e532c641015ee08dc5f28908c00/1.jpg",  "11-inch display, M2 chip.", 7, "Tablet"));
        productList.add(new Product(12, "Samsung Galaxy Tab S9", 1850.0, 1850.0,  "https://i.ebayimg.com/images/g/yyYAAeSwUW1o5Tnq/s-l1600.jpg",  "Dynamic AMOLED 2X.", 4, "Tablet"));

        // Search filtering logic
        if (search != null && !search.isEmpty()) {
            productList = productList.stream()
                    .filter(p -> p.getName().toLowerCase().contains(search.toLowerCase()))
                    .collect(Collectors.toList());
        }

        // Category filtering logic
        if (category != null && !category.isEmpty()) {
            productList = productList.stream()
                    .filter(p -> p.getCategory().equalsIgnoreCase(category))
                    .collect(Collectors.toList());
        }

        model.addAttribute("productList", productList);
        model.addAttribute("userName", "Leila");
        model.addAttribute("searchQuery", search);

        return "index";
    }
}