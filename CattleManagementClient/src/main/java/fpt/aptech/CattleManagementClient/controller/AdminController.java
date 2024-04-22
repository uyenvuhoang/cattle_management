/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Controller.java to edit this template
 */
package fpt.aptech.CattleManagementClient.controller;

import fpt.aptech.CattleManagementClient.entities.Cattlesale;
import fpt.aptech.CattleManagementClient.entities.Orders;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
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
public class AdminController {

    private String urlCattle = "http://localhost:9999/api/cattle";
    private String urlorders = "http://localhost:9999/api/orders";
    private String urlproduct = "http://localhost:9999/api/product";
    private String urlcattlesold = "http://localhost:9999/api/cattlesale";

    private RestTemplate rest = new RestTemplate();

    @GetMapping("/admin")
    public String page(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        double totalamount = 0.0;
        ResponseEntity<String> response = rest.getForEntity(urlCattle + "/count", String.class);
        model.addAttribute("count", response.getBody());

        ResponseEntity<String> productcount = rest.getForEntity(urlproduct + "/countproduct", String.class);
        model.addAttribute("productcount", productcount.getBody());

        ResponseEntity<List<Orders>> totalmount = rest.exchange(
                urlorders,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Orders>>() {
        }
        );
        List<Orders> o = totalmount.getBody();

        model.addAttribute("oders", o);
        int countCash = 0;
        double totalCash = 0;
        int countpay = 0;
        double totalpay = 0;
        int countvnpay = 0;
        double totalvnpay = 0;
        for (Orders orders : o) {
            totalamount += orders.getTotal();
            if (orders.getPayments().equals("Cash On Delivery")) {
                totalCash += orders.getTotal();
                countCash++;
            }
            if (orders.getPayments().equals("paypal")) {
                totalpay += orders.getTotal();
                countpay++;
            }
            if (orders.getPayments().equals("VNPAY")) {
                totalvnpay += orders.getTotal();
                countvnpay++;
            }
        }
        model.addAttribute("totalamount", totalamount);
        model.addAttribute("cash", countCash);
        model.addAttribute("totalcash", totalCash);
        model.addAttribute("paypal", countpay);
        model.addAttribute("totalpay", totalpay);
        model.addAttribute("vnpay", countvnpay);
        model.addAttribute("totalvnpay", totalvnpay);
        
        double totalamoutcattle = 0.0;
        ResponseEntity<List<Cattlesale>> totalmountcatlesold = rest.exchange(
                urlcattlesold,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Cattlesale>>() {
        }
        );
        List<Cattlesale> c = totalmountcatlesold.getBody();

        for (Cattlesale cattlesale : c) {
            totalamoutcattle += cattlesale.getCattleId().getPrice();
        }

        model.addAttribute("totalamoutcattle", totalamoutcattle);

        return "/Admin/admin";
    }

//    @GetMapping("/count")
//    public String admin(Model model) {
//       
//        return "Admin/admin";
//    }
}
