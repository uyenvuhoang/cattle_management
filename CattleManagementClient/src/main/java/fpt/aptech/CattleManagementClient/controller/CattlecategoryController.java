/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Controller.java to edit this template
 */
package fpt.aptech.CattleManagementClient.controller;

import fpt.aptech.CattleManagementClient.entities.Cattlecategory;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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
public class CattlecategoryController {

    private String urlcattle = "http://localhost:9999/api/cattlecategory";
    private RestTemplate rest = new RestTemplate();

    @GetMapping("/cattlecategory")
    public String index(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("list", rest.getForObject(urlcattle, List.class));
        return "Admin/cattlecategory/cattlecategory";
    }

    @GetMapping("/detailsbreeds/{id}")
    public String detailscattle(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String cattleone = urlcattle + "/" + id;
        Cattlecategory cattlecategory = rest.getForObject(cattleone, Cattlecategory.class);
        model.addAttribute("breeds", cattlecategory);
        return "Admin/cattlecategory/detailsbreeds"; // Trả về tên của template HTML (editUser.html)
    }

    @GetMapping("/createcattlecategory")
    public String showcattlecategory(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("cattlecategory", new Cattlecategory());
        return "Admin/cattlecategory/createcattlecategory";
    }

    @PostMapping("/createcattlecategory")
    public String createcattlecategory(@ModelAttribute("cattlecategory") Cattlecategory newObject) {
        String createUrl = urlcattle + "/createcattlecategory"; // Endpoint của RESTful API để tạo đối tượng mới
        rest.postForEntity(createUrl, newObject, Cattlecategory.class);
        return "redirect:/cattlecategory";
    }

    @GetMapping("/editbreeds/{id}")
    public String editcategory(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String breedsUrl = urlcattle + "/" + id;
        Cattlecategory cattlecategory = rest.getForObject(breedsUrl, Cattlecategory.class);
        model.addAttribute("breeds", cattlecategory);
        return "Admin/cattlecategory/editbreeds"; // Trả về tên của template HTML (editUser.html)
    }

    @PostMapping("/editbreeds")
    public String updateUser(@ModelAttribute Cattlecategory upbreeds) {
        String categoryurl = urlcattle + "/editcattlecategory";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Cattlecategory> requestEntity = new HttpEntity<>(upbreeds, headers);
        ResponseEntity<String> response = rest.exchange(
                categoryurl,
                HttpMethod.PUT,
                requestEntity,
                String.class
        );

        if (response.getStatusCode() == HttpStatus.CREATED) {
            return "redirect:/cattlecategory"; // Trả về trang thành công sau khi cập nhật
        } else {
            return "Error/errorPage"; // Xử lý lỗi nếu cần
        }
    }

    @GetMapping("/deletebreeds/{id}")
    public String Delete(@PathVariable int id, Model model) {
        String breedsurl = urlcattle + "/" + id;
        try {
            rest.exchange(breedsurl, HttpMethod.DELETE, null, String.class);
            return "redirect:/cattlecategory";
        } catch (Exception e) {
            return "Error/errorPage";
        }
    }
}
