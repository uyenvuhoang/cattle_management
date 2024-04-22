/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Controller.java to edit this template
 */
package fpt.aptech.CattleManagementClient.controller;

import fpt.aptech.CattleManagementClient.dto.SignUpDto;
import fpt.aptech.CattleManagementClient.entities.User;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import java.util.List;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author admin
 */
@Controller
public class AuthController {

    private String url = "http://localhost:9999/api/auth";
    private RestTemplate rest = new RestTemplate();

    @RequestMapping("/listuser")
    public String index(Model model, HttpSession session) {
        // Truy xuất tên người dùng từ phiên làm việc
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        // Thêm tên người dùng vào mô hình
        model.addAttribute("username", username);

        model.addAttribute("list", rest.getForObject(url, List.class));
        return "Auth/index";
    }
    
    

    @RequestMapping("/login")
    public String login(Model model) {
        model.addAttribute("login", new User());

        return "Auth/login";
    }

    @PostMapping("/login")
    public String login(Model model, @ModelAttribute("user") User user, HttpSession session, RedirectAttributes redirectAttributes) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<User> request = new HttpEntity<>(user, headers);

        try {
            ResponseEntity<User> response = rest.exchange(
                    url + "/login",
                    HttpMethod.POST,
                    request,
                    User.class);

            if (response.getStatusCode() == HttpStatus.ACCEPTED) {
                session.setAttribute("username", response.getBody().getUsername());
                return "redirect:/admin";
            } else if (response.getStatusCode() == HttpStatus.OK) {
                session.setAttribute("username", response.getBody().getUsername());
                session.setAttribute("user", response.getBody().getId());
                return "redirect:/";
            } else {
                model.addAttribute("error", "Login failed");
                return "redirect:/login";
            }
        } catch (Exception ex) {
            // Xử lý lỗi từ API đăng nhập
            redirectAttributes.addFlashAttribute("error", "Error during login: " + ex.getMessage());
            return "redirect:/login";
        }

    }

    @GetMapping("/register")
    public String register(Model model) {
//        SignUpDto user = new SignUpDto();
        model.addAttribute("signupDto", new SignUpDto());
        return "Auth/register";
    }

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("signupDto") SignUpDto signUpDto,
            Model model, RedirectAttributes redirectAttributes, HttpSession session) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<SignUpDto> request = new HttpEntity<>(signUpDto, headers);
        try {
            ResponseEntity<String> response = rest.exchange(
                    url + "/register",
                    HttpMethod.POST,
                    request,
                    String.class);
            if (response.getStatusCode() == HttpStatus.OK) {
                // Đăng nhập thành công, chuyển hướng đến trang index.html
                String username = (String) session.getAttribute("username");
                // Thêm tên người dùng vào mô hình
                model.addAttribute("username", username);
                return "redirect:/login";
            } else if (response.getStatusCode() == HttpStatus.FOUND) {
                redirectAttributes.addFlashAttribute("error", "Email already exists");
                return "redirect:/register";
            } else {
                redirectAttributes.addFlashAttribute("error", "register failed");
                return "redirect:/login";
            }
        } catch (Exception ex) {
            // Xử lý lỗi từ API đăng nhập
            redirectAttributes.addFlashAttribute("error", "Error during login: " + ex.getMessage());
            return "redirect:/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        // Invalidate the session to log the user out
        session.invalidate();
        return "redirect:/";
    }
}
