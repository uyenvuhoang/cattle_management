/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Controller.java to edit this template
 */
package fpt.aptech.CattleManagementClient.controller;

import fpt.aptech.CattleManagementClient.dto.ProductDto;
import fpt.aptech.CattleManagementClient.entities.Category;
import fpt.aptech.CattleManagementClient.entities.Product;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author admin
 */
@Controller
public class ProductController {

    private String urlproduct = "http://localhost:9999/api/product";
    private String urlca = "http://localhost:9999/api/category";
    private RestTemplate rest = new RestTemplate();

    @Value("${upload.path}")
    private String fileUpload;

    @GetMapping("/product")
    public String index(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("list", rest.getForObject(urlproduct, List.class));
        return "Admin/product/product";
    }

    @PostMapping("/search")
    public String searchByName(Model model, @RequestParam String productname) {
        if (productname == null) {
            model.addAttribute("list", rest.getForObject(urlproduct, List.class));
            return "Admin/product/product";
        } else {
            String productUrl = urlproduct + "/search?productname=" + productname;

            ResponseEntity<List<Product>> responseEntity = rest.exchange(
                    productUrl,
                    HttpMethod.GET,
                    null,
                    new ParameterizedTypeReference<List<Product>>() {
            });

            List<Product> products = responseEntity.getBody();

            model.addAttribute("list", products);

            // Redirect to "/product"
            return "Admin/product/product";
        }
    }

    @GetMapping("/createproduct")
    public String Createproduct(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("product", new Product());

        ResponseEntity<Category[]> responseEntity = rest.getForEntity(urlca, Category[].class);
        Category[] categories = responseEntity.getBody();

        model.addAttribute("category", categories);
        return "Admin/product/createproduct";
    }

    @PostMapping("/createproduct")
    public String Createproduct(@ModelAttribute("productDto") ProductDto newproduct,
            Model model, RedirectAttributes redirectAttributes) throws IOException {
        MultipartFile file = newproduct.getImage();
        if (file.isEmpty()) {
            return "Please select a file to upload";
        }

        try {
            String fileName = file.getOriginalFilename();
            FileCopyUtils.copy(newproduct.getImage().getBytes(), new File(fileUpload, fileName));

            Product product = new Product();
            product.setId(newproduct.getId());
            product.setProductname(newproduct.getProductname());
            product.setSale(newproduct.getSale());
            product.setImage(fileName);
            product.setDate(newproduct.getDate());
            product.setPrice(newproduct.getPrice());
            product.setQuantity(newproduct.getQuantity());
            product.setUnits(newproduct.getUnits());
            product.setDescription(newproduct.getDescription());
            product.setStatus(newproduct.getStatus());
            product.setCategoryid(newproduct.getCategoryid());

            // ... xử lý các thông tin khác và lưu vào cơ sở dữ liệu
            String createUrl = urlproduct + "/createproduct"; // Endpoint của RESTful API để tạo đối tượng mới
            rest.postForEntity(createUrl, product, Product.class);
            return "redirect:/product";
        } catch (IOException e) {
            return "Failed to upload file: " + e.getMessage();
        }

    }

    @GetMapping("/detailsproduct/{id}")
    public String detailsproduct(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String productone = urlproduct + "/" + id;
        Product product = rest.getForObject(productone, Product.class);
        model.addAttribute("product", product);

//        List<Category> lcategory = rest.getForObject(urlca, List.class);
//        model.addAttribute("category", lcategory);
        return "Admin/product/detailsproduct"; // Trả về tên của template HTML (editUser.html)
    }

    @GetMapping("/editproduct/{id}")
    public String editproduct(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String productone = urlproduct + "/" + id;
        Product product = rest.getForObject(productone, Product.class);
        model.addAttribute("product", product);

        ResponseEntity<Category[]> responseEntity = rest.getForEntity(urlca, Category[].class);
        Category[] categories = responseEntity.getBody();

        model.addAttribute("category", categories);
        return "Admin/product/editproduct"; // Trả về tên của template HTML (editUser.html)
    }

    @PostMapping("/editproduct/{id}")
    public String Editproduct(@ModelAttribute("productDto") ProductDto product, @PathVariable int id,
            Model model, RedirectAttributes redirectAttributes) throws IOException {
        try {
            String productone = urlproduct + "/" + id;
            Product existingProduct = rest.getForObject(productone, Product.class);

            MultipartFile file = product.getImage();
            if (file != null && !file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                FileCopyUtils.copy(file.getBytes(), new File(fileUpload, fileName));

                // Cập nhật thông tin sản phẩm với hình ảnh mới
                existingProduct.setProductname(product.getProductname());
                existingProduct.setPrice(product.getPrice());
                existingProduct.setQuantity(product.getQuantity());
                existingProduct.setImage(fileName);
                existingProduct.setCategoryid(product.getCategoryid());
                existingProduct.setSale(product.getSale());
                existingProduct.setDate(product.getDate());
                existingProduct.setUnits(product.getUnits());
                existingProduct.setDescription(product.getDescription());
                existingProduct.setStatus(product.getStatus());
            } else {
                // Không có tệp tin mới, giữ nguyên hình ảnh cũ
                existingProduct.setProductname(product.getProductname());
                existingProduct.setPrice(product.getPrice());
                existingProduct.setQuantity(product.getQuantity());
                existingProduct.setCategoryid(product.getCategoryid());
                existingProduct.setSale(product.getSale());
                existingProduct.setDate(product.getDate());
                existingProduct.setUnits(product.getUnits());
                existingProduct.setDescription(product.getDescription());
                existingProduct.setStatus(product.getStatus());
            }

            // ... xử lý các thông tin khác và lưu vào cơ sở dữ liệu
            String createUrl = urlproduct + "/editproduct"; // Endpoint của RESTful API để tạo đối tượng mới
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Product> requestEntity = new HttpEntity<>(existingProduct, headers);
            ResponseEntity<String> response = rest.exchange(
                    createUrl,
                    HttpMethod.PUT,
                    requestEntity,
                    String.class
            );

            if (response.getStatusCode() == HttpStatus.CREATED) {
                return "redirect:/product"; // Trả về trang thành công sau khi cập nhật
            } else {
                return "Error/errorPage"; // Xử lý lỗi nếu cần
            }
        } catch (IOException e) {
            return "Failed to upload file: " + e.getMessage();
        }

    }

    @GetMapping("/deleteproduct/{id}")
    public String Delete(@PathVariable int id, Model model) {
        String producturl = urlproduct + "/" + id;
        try {
            rest.exchange(producturl, HttpMethod.DELETE, null, String.class);
            return "redirect:/product";
        } catch (Exception e) {
            return "Error/errorPage";
        }
    }

}
