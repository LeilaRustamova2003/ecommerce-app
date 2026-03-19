package com.example.ecommerce_app.controller;
        import org.springframework.stereotype.Controller;
        import org.springframework.ui.Model;
        import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("message", "Hello Mr., the Spring project is working!");
        model.addAttribute("student", "Leila Rustamova");
        return "index";
    }
}
