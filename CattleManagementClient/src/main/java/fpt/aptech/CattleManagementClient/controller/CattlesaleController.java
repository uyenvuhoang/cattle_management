/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Controller.java to edit this template
 */
package fpt.aptech.CattleManagementClient.controller;

import fpt.aptech.CattleManagementClient.entities.Cattlesale;
import fpt.aptech.CattleManagementClient.entities.User;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author admin
 */
@Controller
public class CattlesaleController {

    private String urlcattlesold = "http://localhost:9999/api/cattlesale";
    private RestTemplate rest = new RestTemplate();

    @RequestMapping("/cattlesold")
    public String page(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
        if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("list", rest.getForObject(urlcattlesold, List.class));
        return "Admin/cattlesold/cattlesold";
    }

    @GetMapping("/detailscattlesold/{id}")
    public String detailscattle(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
        if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String cattleone = urlcattlesold + "/" + id;
        Cattlesale cattlesold = rest.getForObject(cattleone, Cattlesale.class);
        model.addAttribute("cattlesold", cattlesold);
        return "Admin/cattlesold/detailscattlesold"; // Trả về tên của template HTML (editUser.html)
    }

    @GetMapping("/editcattlesold/{id}")
    public String editcattlesold(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
        if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String cattleone = urlcattlesold + "/" + id;
        Cattlesale cattlesold = rest.getForObject(cattleone, Cattlesale.class);
        model.addAttribute("cattlesold", cattlesold);
        return "Admin/cattlesold/editcattlesold"; // Trả về tên của template HTML (editUser.html)
    }

    @PostMapping("/editcattlesold")
    public String updatesold(@ModelAttribute Cattlesale updateCattlesale) {
        String cattlesoldurl = urlcattlesold + "/Createcattlesale";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Cattlesale> requestEntity = new HttpEntity<>(updateCattlesale, headers);
        ResponseEntity<String> response = rest.exchange(
                cattlesoldurl,
                HttpMethod.POST,
                requestEntity,
                String.class
        );

        if (response.getStatusCode() == HttpStatus.CREATED) {
            return "redirect:/cattlesold"; 
        } else {
            return "Error/errorPage"; // Xử lý lỗi nếu cần
        }
    }

    @GetMapping("/deletecattlesold/{id}")
    public String Delete(@PathVariable int id, Model model) {
        String cattlesoldurl = urlcattlesold + "/" + id;
        try {
            rest.exchange(cattlesoldurl, HttpMethod.DELETE, null, String.class);
            return "redirect:/cattlesold";
        } catch (Exception e) {
            return "Error/errorPage";
        }
    }
}
