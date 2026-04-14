package com.example.ecommerce_app;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import java.util.Arrays;

@Component // პროგრამის გაშვებისას ავტომატურად შესრულდება
public class DataInitializer implements CommandLineRunner {

    private final ProductRepository repository;

    public DataInitializer(ProductRepository repository) {
        this.repository = repository;
    }

    @Override
    public void run(String... args) throws Exception {
        // თუ ბაზა ცარიელია, შევავსოთ ჩვენი ძველი პროდუქტებით
        if (repository.count() == 0) {
            repository.saveAll(Arrays.asList(
                    new Product(0, "iPhone 15 Pro", 3599.0, 3999.0, "https://media.idownloadblog.com/wp-content/uploads/2023/09/iPhone-15-regular-and-pro.jpg", "A17 Pro chip.", 10, "Phone"),
                    new Product(0, "Samsung Galaxy S24", 2800.0, 3100.0, "https://avatars.mds.yandex.net/get-mpic/5249393/img_id638847272890887797.png/orig", "AI powered smartphone.", 8, "Phone"),
                    new Product(0, "MacBook Air M3", 4299.0, 4599.0, "https://i.ytimg.com/vi/UFyC5SgtVDU/maxresdefault.jpg", "Supercharged by M3.", 5, "Computer"),
                    new Product(0, "Dell XPS 15", 3800.0, 4100.0, "https://avatars.mds.yandex.net/get-mpic/4362548/img_id411826385836613756.jpeg/orig", "InfinityEdge display.", 3, "Computer"),
                    new Product(0, "Apple Watch Series 9", 1299.0, 1399.0, "https://main-cdn.sbermegamarket.ru/mid9/hlr-system/-23/339/060/112/710/32/100065084348b0.png", "Smarter, brighter.", 15, "Watch"),
                    new Product(0, "Garmin Fenix 7", 1500.0, 1500.0, "https://cdn1.ozone.ru/s3/multimedia-1-r/7123807827.jpg", "Rugged outdoor watch.", 4, "Watch"),
                    new Product(0, "Sony WH-1000XM5", 950.0, 1100.0, "https://www.cactus.md/ijpg.ashx?i=/i/products/32/162561.jpg", "Noise cancelling.", 12, "Audio"),
                    new Product(0, "AirPods Pro 2", 650.0, 750.0, "https://basket-21.wbbasket.ru/vol3680/part368030/368030542/images/big/1.webp", "MagSafe charging.", 20, "Audio"),
                    new Product(0, "Samsung T7 SSD", 450.0, 500.0, "https://i.ytimg.com/vi/dWktvLj-ino/hq720.jpg", "1TB Portable SSD.", 25, "PC Accessory"),
                    new Product(0, "Logitech MX Master 3S", 300.0, 350.0, "https://i.rtings.com/assets/products/tfI79vsP/logitech-mx-master-3s/design-medium.jpg?format=auto", "Wireless mouse.", 15, "PC Accessory"),
                    new Product(0, "iPad Air M2", 2100.0, 2400.0,  "https://p.turbosquid.com/ts-thumb/LD/GP6s9d/xv/1/jpg/1744127052/1920x1080/fit_q87/cc6074ddd21c5e532c641015ee08dc5f28908c00/1.jpg",  "11-inch display, M2 chip.", 7, "Tablet"),
                    new Product(0, "Samsung Galaxy Tab S9", 1850.0, 1850.0,  "https://i.ebayimg.com/images/g/yyYAAeSwUW1o5Tnq/s-l1600.jpg",  "Dynamic AMOLED 2X.", 4, "Tablet")
            ));
            System.out.println("მონაცემები წარმატებით ჩაიტვირთა ბაზაში!");
        }
    }
}