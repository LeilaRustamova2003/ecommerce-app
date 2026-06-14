package com.example.ecommerce_app;

import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ProductServiceTest {

    @Mock
    private ProductRepository productRepository;

    @InjectMocks
    private ProductService productService;

    private AutoCloseable closeable;

    @BeforeEach
    void setUp() {
        closeable = MockitoAnnotations.openMocks(this);
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
    }

    // Test 1
    @Test
    @DisplayName("getAllProducts returns all products")
    void testGetAllProducts() {
        List<Product> expected = Arrays.asList(
                new Product(1, "iPhone", 3599.0, 3999.0, "img.jpg", "desc", 10, "Phone"),
                new Product(2, "MacBook", 4299.0, 4599.0, "img.jpg", "desc", 5, "Computer")
        );
        when(productRepository.findAll()).thenReturn(expected);

        List<Product> result = productService.getAllProducts();

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(productRepository, times(1)).findAll();
    }

    // Test 2
    @Test
    @DisplayName("getById returns product when exists")
    void testGetByIdFound() {
        Product product = new Product(1, "iPhone", 3599.0, 3999.0, "img.jpg", "desc", 10, "Phone");
        when(productRepository.findById(1)).thenReturn(Optional.of(product));

        Product result = productService.getById(1);

        assertNotNull(result);
        assertEquals("iPhone", result.getName());
        assertEquals("Phone", result.getCategory());
    }

    // Test 3
    @Test
    @DisplayName("getById returns null when not found")
    void testGetByIdNotFound() {
        when(productRepository.findById(999)).thenReturn(Optional.empty());

        Product result = productService.getById(999);

        assertNull(result);
    }

    // Test 4 - Parameterized
    @ParameterizedTest
    @ValueSource(strings = {"iPhone", "Samsung", "MacBook"})
    @DisplayName("searchProducts calls repository for any query")
    void testSearchParameterized(String query) {
        when(productRepository.findByNameContainingIgnoreCase(query)).thenReturn(java.util.Collections.emptyList());

        List<Product> result = productService.searchProducts(query);

        assertNotNull(result);
        verify(productRepository).findByNameContainingIgnoreCase(query);
    }

    // Test 5
    @Test
    @DisplayName("getByCategory returns correct products")
    void testGetByCategory() {
        List<Product> computers = Arrays.asList(
                new Product(3, "MacBook", 4299.0, 4599.0, "img.jpg", "desc", 5, "Computer"),
                new Product(4, "Dell", 3800.0, 4100.0, "img.jpg", "desc", 3, "Computer")
        );
        when(productRepository.findByCategoryIgnoreCase("Computer")).thenReturn(computers);

        List<Product> result = productService.getByCategory("Computer");

        assertEquals(2, result.size());
        result.forEach(p -> assertEquals("Computer", p.getCategory()));
    }
}