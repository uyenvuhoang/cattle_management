/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Controller.java to edit this template
 */
package fpt.aptech.CattleManagementClient.controller;

import fpt.aptech.CattleManagementClient.entities.Blog;
import fpt.aptech.CattleManagementClient.entities.Productcart;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author admin
 */
@Controller
public class BlogController {

    private String urlblog = "http://localhost:9999/api/blog";
     private String urlproductcart = "http://localhost:9999/api/productcart";
    private RestTemplate rest = new RestTemplate();

    @Value("${upload.path}")
    private String fileUpload;

    @GetMapping("/blog")
    public String page(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        model.addAttribute("lblog", rest.getForObject(urlblog, List.class));
        double totalAmount = 0.0;
        ResponseEntity<List<Productcart>> response = rest.exchange(
                urlproductcart,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Productcart>>() {
        }
        );
        List<Productcart> p = response.getBody();
        model.addAttribute("pcart", p);
        for (Productcart productcart : p) {
            if (username == null) {
               return "Admin/blog/blog";
            }
            if (username.equals(productcart.getUserId().getUsername())) {
                if (productcart.getStatus() == false) {
                    totalAmount += productcart.getSubtotal();
                }
            }
        }
        model.addAttribute("totlal", totalAmount);
        return "Admin/blog/blog";
    }

    @GetMapping("/listblog")
    public String listblog(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("listblog", rest.getForObject(urlblog, List.class));
        return "Admin/blog/listblog";
    }

    @GetMapping("/createblog")
    public String showCreateForm(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("blog", new Blog());
        return "Admin/blog/createblog";
    }

    @PostMapping("/createblog")
    public String createblog(@ModelAttribute("blog") Blog blog,
            @Valid BindingResult result, Model model,
            @RequestParam("file") MultipartFile file,
            RedirectAttributes redirectAttributes) throws IOException {
        if (result.hasErrors()) {
            return "Admin/blog/createblog";
        }
        String fileName = file.getOriginalFilename();
        String filePath = fileUpload + "/" + fileName;
        File dest = new File(filePath);
        FileCopyUtils.copy(file.getBytes(), dest);

        Date date = new Date();

        blog.setImage(fileName);
        blog.setDate(date.toString());
        try {
            String createUrl = urlblog + "/createblog"; // Endpoint của RESTful API để tạo đối tượng mới
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Blog> requestEntity = new HttpEntity<>(blog, headers);
            ResponseEntity<String> response = rest.exchange(
                    createUrl,
                    HttpMethod.POST,
                    requestEntity,
                    String.class
            );

            if (response.getStatusCode() == HttpStatus.CREATED) {
                return "redirect:/listblog"; // Trả về trang thành công sau khi cập nhật
            } else {
                return "Error/errorPage"; // Xử lý lỗi nếu cần
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return "redirect:/listblog";
    }

    @GetMapping("/detailsblog/{id}")
    public String detailsblog(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String cateUrlid = urlblog + "/" + id;
        Blog blog = rest.getForObject(cateUrlid, Blog.class);
        model.addAttribute("blog", blog);
        return "Admin/blog/detailsblog";
    }

    @GetMapping("/deleteblog/{id}")
    public String Deleteblog(@PathVariable int id, Model model) {
        String deblogurl = urlblog + "/" + id;
        try {
            rest.exchange(deblogurl, HttpMethod.DELETE, null, String.class);
            return "redirect:/listblog";
        } catch (Exception e) {
            return "Error/errorPage";
        }
    }

    @GetMapping("/editblog/{id}")
    public String editblog(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String blogUrl = urlblog + "/" + id;
        Blog blog = rest.getForObject(blogUrl, Blog.class);
        model.addAttribute("blog", blog);
        return "Admin/blog/editblog"; // Trả về tên của template HTML (editUser.html)
    }

    @PostMapping("/editcattle")
    public String editblog(@ModelAttribute("blog") Blog blog,
            @Valid BindingResult result, Model model,
            @RequestParam("file") MultipartFile file,
            RedirectAttributes redirectAttributes) throws IOException {
        if (result.hasErrors()) {
            return "Admin/blog/createblog";
        }

        Date date = new Date();
        if (file != null && !file.isEmpty()) {
            String fileName = file.getOriginalFilename();
            String filePath = fileUpload + "/" + fileName;
            File dest = new File(filePath);
            FileCopyUtils.copy(file.getBytes(), dest);
            blog.setImage(fileName);
        }
        blog.setDate(date.toString());

        try {
            String createUrl = urlblog + "/editblog"; // Endpoint của RESTful API để tạo đối tượng mới
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Blog> requestEntity = new HttpEntity<>(blog, headers);
            ResponseEntity<String> response = rest.exchange(
                    createUrl,
                    HttpMethod.PUT,
                    requestEntity,
                    String.class
            );

            if (response.getStatusCode() == HttpStatus.OK) {
                return "redirect:/listblog"; // Trả về trang thành công sau khi cập nhật
            } else {
                return "Error/errorPage"; // Xử lý lỗi nếu cần
            }
        } catch (Exception e) {
            e.getMessage();
        }
        return "redirect:/listblog";
    }
}
