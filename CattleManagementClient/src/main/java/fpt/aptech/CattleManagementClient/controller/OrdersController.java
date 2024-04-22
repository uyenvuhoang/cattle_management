/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Controller.java to edit this template
 */
package fpt.aptech.CattleManagementClient.controller;

import fpt.aptech.CattleManagementClient.entities.Orders;
import fpt.aptech.CattleManagementClient.entities.Productcart;
import fpt.aptech.CattleManagementClient.entities.User;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.core.ParameterizedTypeReference;
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
public class OrdersController {

    private String urlorders = "http://localhost:9999/api/orders";
    private String urlproductcart = "http://localhost:9999/api/productcart";
    private RestTemplate rest = new RestTemplate();

    @RequestMapping("/checkout")
    public String checkout(Model model, HttpSession session) {
        double totalAmount = 0.0;
        int totalIterations = 0;

        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        model.addAttribute("orders", new Orders());
        model.addAttribute("productcart", new Productcart());
//        Map<Integer, Integer> userIdCounts = new HashMap<>();
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
                return "Admin/shopingcart/mycart";
            }
            if (username.equals(productcart.getUserId().getUsername())) {
                if (productcart.getStatus() == false) {
                    totalAmount += productcart.getSubtotal();
                    totalIterations++;
                }
            }
        }
        model.addAttribute("totalIterations", totalIterations);
        model.addAttribute("totlal", totalAmount);
        return "Home/order/checkout";
    }

    @PostMapping("/checkout")
    public String page(Model model, HttpSession session, RedirectAttributes redirectAttributes,
            @ModelAttribute("orders") Orders orders, @ModelAttribute("productcart") Productcart productcart) {
        Integer userone = (Integer) session.getAttribute("user");
        User user = new User();
        user.setId(userone);
        orders.setUserId(user);
        Date date = new Date();
        orders.setUpdatedate(date.toString());
        orders.setStatus("In progress");

        ResponseEntity<List<Productcart>> productcarts = rest.exchange(
                urlproductcart,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Productcart>>() {
        }
        );
        List<Productcart> p = productcarts.getBody();

        for (Productcart productcart1 : p) {
            if (productcart1.getStatus() == false) {
                productcart.setId(productcart1.getId());
                productcart.setQuantity(productcart1.getQuantity());
                productcart.setSellingprice(productcart1.getSellingprice());
                productcart.setSubtotal(productcart1.getSubtotal());
                productcart.setProductid(productcart1.getProductid());
                productcart.setUserId(productcart1.getUserId());
                productcart.setStatus(true);
                productcart.setStartdate(date.toString());
                String createUrl = urlproductcart + "/createproductcart";
                rest.postForEntity(createUrl, productcart, Productcart.class);
            }
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Orders> request = new HttpEntity<>(orders, headers);

        try {
            ResponseEntity<String> response = rest.exchange(
                    urlorders + "/createoders",
                    HttpMethod.POST,
                    request,
                    String.class);
            if (response.getStatusCode() == HttpStatus.CREATED) {
                return "Home/order/ordersuccess";
            } else {
                return "Admin/shopingcart/mycart";
            }
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("error", "Error during create: " + ex.getMessage());
            return "redirect:/errorPage";
        }
    }

    @GetMapping("/order")
    public String order(Model model, HttpSession session) {
        double totalAmount = 0.0;
        int totalIterations = 0;

        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
        if (!username.equals("Admin")) {
            return "redirect:/";
        }
        ResponseEntity<List<Orders>> response = rest.exchange(
                urlorders,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Orders>>() {
        }
        );
        List<Orders> o = response.getBody();

        model.addAttribute("oders", o);

        return "Home/order/order";
    }

    @GetMapping("/detailsorder/{id}")
    public String detailsproduct(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
        if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String orderone = urlorders + "/" + id;
        Orders orders = rest.getForObject(orderone, Orders.class);
        model.addAttribute("order", orders);

        ResponseEntity<List<Productcart>> response = rest.exchange(
                urlproductcart,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Productcart>>() {
        }
        );
        List<Productcart> p = response.getBody();

        model.addAttribute("pcart", p);

        return "Home/order/detailsorder";
    }

    @GetMapping("/oroderedit/{id}")
    public String editorder(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
        if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String orderone = urlorders + "/" + id;
        Orders orders = rest.getForObject(orderone, Orders.class);
        model.addAttribute("order", orders);

        ResponseEntity<List<Productcart>> response = rest.exchange(
                urlproductcart,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Productcart>>() {
        }
        );
        List<Productcart> p = response.getBody();

        model.addAttribute("pcart", p);

        return "Home/order/oroderedit"; // Trả về tên của template HTML (editUser.html)
    }

    @PostMapping("/oroderedit")
    public String updateorder(@ModelAttribute Orders updateOrders) {
        String orderurl = urlorders + "/editorders";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Orders> requestEntity = new HttpEntity<>(updateOrders, headers);
        ResponseEntity<String> response = rest.exchange(
                orderurl,
                HttpMethod.PUT,
                requestEntity,
                String.class
        );

        if (response.getStatusCode() == HttpStatus.OK) {
            return "redirect:/order";
        } else {
            return "Error/errorPage"; // Xử lý lỗi nếu cần
        }
    }

    @GetMapping("/purchasehistory")
    public String purchasehistory(Model model, HttpSession session) {
        double totalAmount = 0.0;
        int totalIterations = 0;

        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }

        ResponseEntity<List<Orders>> response = rest.exchange(
                urlorders,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Orders>>() {
        }
        );
        List<Orders> o = response.getBody();

        model.addAttribute("oders", o);

        return "Home/order/purchasehistory";
    }

    @GetMapping("/detailpurchasehistory/{id}")
    public String detailhistory(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }

        String orderone = urlorders + "/" + id;
        Orders orders = rest.getForObject(orderone, Orders.class);
        model.addAttribute("order", orders);

        ResponseEntity<List<Productcart>> response = rest.exchange(
                urlproductcart,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Productcart>>() {
        }
        );
        List<Productcart> p = response.getBody();

        model.addAttribute("pcart", p);

        return "Home/order/detailpurchasehistory";
    }

    @GetMapping("/ordersuccess")
    public String ordersuccess(Model model, HttpSession session) {
        return "Admin/shopingcart/mycart";
    }

}
