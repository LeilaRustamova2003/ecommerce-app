package com.example.ecommerce_app;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import java.time.LocalDateTime;

@Component
public class ScheduledTasks {

    private static final Logger log = LoggerFactory.getLogger(ScheduledTasks.class);
    private final ProductService productService;

    public ScheduledTasks(ProductService productService) {
        this.productService = productService;
    }

    @Scheduled(fixedRate = 300000)
    public void evictProductCache() {
        productService.evictProductCache();
        log.info("Cache evicted at {}", LocalDateTime.now());
    }

    @Scheduled(cron = "0 * * * * *")
    public void heartbeat() {
        log.info("Heartbeat at {}", LocalDateTime.now());
    }
}