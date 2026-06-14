package com.example.ecommerce_app;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.security.crypto.password.PasswordEncoder;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.when;

class DataInitializerTest {

    @Mock
    private ProductRepository productRepository;

    @Mock
    private AppUserRepository userRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    // Test 1
    @Test
    void testPasswordEncoderEncodes() {
        when(passwordEncoder.encode("user123")).thenReturn("$2a$encoded");
        String result = passwordEncoder.encode("user123");
        assertNotNull(result);
        assertTrue(result.startsWith("$2a$"));
    }

    // Test 2
    @Test
    void testProductRepositoryCountIsZero() {
        when(productRepository.count()).thenReturn(0L);
        assertEquals(0L, productRepository.count());
    }

    // Test 3
    @Test
    void testUserRepositoryCountIsZero() {
        when(userRepository.count()).thenReturn(0L);
        assertEquals(0L, userRepository.count());
    }

    // Test 4
    @Test
    void testAppUserCreation() {
        AppUser user = new AppUser("testuser", "encodedPass", "ROLE_USER");
        assertEquals("testuser", user.getUsername());
        assertEquals("ROLE_USER", user.getRole());
    }

    // Test 5
    @Test
    void testProductCreation() {
        Product p = new Product(0, "Test", 100.0, 200.0, "img.jpg", "desc", 5, "Phone");
        assertEquals("Test", p.getName());
        assertEquals(100.0, p.getPrice());
        assertEquals("Phone", p.getCategory());
    }
}