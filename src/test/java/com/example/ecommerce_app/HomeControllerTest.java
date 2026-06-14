package com.example.ecommerce_app;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class HomeControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ProductService productService;

    @Test
    @DisplayName("GET / returns index page")
    @WithMockUser
    void testIndexPage() throws Exception {
        when(productService.getAllProducts()).thenReturn(List.of(
                new Product(1, "iPhone", 3599.0, 3999.0, "img.jpg", "desc", 10, "Phone")
        ));

        mockMvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(view().name("index"))
                .andExpect(model().attributeExists("productList"));
    }

    @Test
    @DisplayName("GET /product/1 returns product-details")
    @WithMockUser
    void testProductDetailsFound() throws Exception {
        Product product = new Product(1, "MacBook", 4299.0, 4599.0, "img.jpg", "desc", 5, "Computer");
        when(productService.getById(1)).thenReturn(product);

        mockMvc.perform(get("/product/1"))
                .andExpect(status().isOk())
                .andExpect(view().name("product-details"));
    }

    @Test
    @DisplayName("GET /product/999 redirects to /")
    @WithMockUser
    void testProductDetailsNotFound() throws Exception {
        when(productService.getById(999)).thenReturn(null);

        mockMvc.perform(get("/product/999"))
                .andExpect(status().is3xxRedirection());
    }
}