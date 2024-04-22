/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Controller.java to edit this template
 */
package fpt.aptech.CattleManagementClient.controller;

import fpt.aptech.CattleManagementClient.entities.Category;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import org.springframework.http.*;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

/**
 *
 * @author admin
 */
@Controller
public class CategoryController {

    private String urlca = "http://localhost:9999/api/category";
    private RestTemplate rest = new RestTemplate();

    @GetMapping("/category")
    public String index(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("list", rest.getForObject(urlca, List.class));
        return "Admin/category/category";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("category", new Category());
        return "Admin/category/create";
    }

    @PostMapping("/create")
    public String createObject(@ModelAttribute("category") Category newObject) {
        String createUrl = urlca + "/Createcategory"; 
        rest.postForEntity(createUrl, newObject, Category.class);
        return "redirect:/category";
    }

    @GetMapping("/details/{id}")
    public String detailscategory(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String cateUrlid = urlca + "/" + id;
        Category category = rest.getForObject(cateUrlid, Category.class);
        model.addAttribute("category", category);
        return "Admin/category/details";
    }

    @GetMapping("/edit/{id}")
    public String editcategory(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String cateUrl = urlca + "/" + id;
        Category category = rest.getForObject(cateUrl, Category.class);
        model.addAttribute("category", category);
        return "Admin/category/edit"; // Trả về tên của template HTML (editUser.html)
    }

    @PostMapping("/edit")
    public String updatecategory(@ModelAttribute Category updatedCategory) {
        String categoryurl = urlca + "/editcategory";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Category> requestEntity = new HttpEntity<>(updatedCategory, headers);
        ResponseEntity<String> response = rest.exchange(
                categoryurl,
                HttpMethod.PUT,
                requestEntity,
                String.class
        );

        if (response.getStatusCode() == HttpStatus.OK) {
            return "redirect:/category"; // Trả về trang thành công sau khi cập nhật
        } else {
            return "Error/errorPage"; // Xử lý lỗi nếu cần
        }
    }

    @GetMapping("/delete/{id}")
    public String Delete(@PathVariable int id, Model model) {
        String decategoryurl = urlca + "/" + id;
        try {
            rest.exchange(decategoryurl, HttpMethod.DELETE, null, String.class);
            return "redirect:/category";
        } catch (Exception e) {
            return "Error/errorPage";
        }
    }
}
