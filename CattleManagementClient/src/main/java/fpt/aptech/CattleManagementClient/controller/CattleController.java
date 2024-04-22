/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Controller.java to edit this template
 */
package fpt.aptech.CattleManagementClient.controller;

import fpt.aptech.CattleManagementClient.dto.CattleDto;
import fpt.aptech.CattleManagementClient.entities.Cattle;
import fpt.aptech.CattleManagementClient.entities.Cattlecategory;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import java.io.File;
import java.io.IOException;
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
public class CattleController {

    private String urlCattle = "http://localhost:9999/api/cattle";
    private String urlcattlecategory = "http://localhost:9999/api/cattlecategory";
    private String urlcattlesold = "http://localhost:9999/api/cattlesale";
    private RestTemplate rest = new RestTemplate();

    @Value("${upload.path}")
    private String fileUpload;

    @GetMapping("/cattle")
    public String index(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("list", rest.getForObject(urlCattle, List.class));

        return "Admin/cattle/cattle";
    }

    @PostMapping("/searchcattle")
    public String searchByName(Model model, @RequestParam String name) {
        if (name == null) {
            model.addAttribute("list", rest.getForObject(urlCattle, List.class));
            return "Admin/cattle/cattle";
        } else {
            String productUrl = urlCattle + "/search?name=" + name;

            ResponseEntity<List<Cattle>> responseEntity = rest.exchange(
                    productUrl,
                    HttpMethod.GET,
                    null,
                    new ParameterizedTypeReference<List<Cattle>>() {
            });

            List<Cattle> cattles = responseEntity.getBody();

            model.addAttribute("list", cattles);

            // Redirect to "/product"
            return "Admin/cattle/cattle";
        }
    }

    @GetMapping("/createcattle")
    public String Createcattle(Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        model.addAttribute("cattle", new Cattle());
        List<Cattlecategory> lcategory = rest.getForObject(urlcattlecategory, List.class);
        model.addAttribute("cattlecategory", lcategory);
        return "Admin/cattle/createcattle";
    }

    @PostMapping("/createcattle")
    public String Createcattle(@Valid @ModelAttribute("cattle") CattleDto newcattle,
            Model model, RedirectAttributes redirectAttributes) throws IOException {
        MultipartFile file = newcattle.getImage();
        String fileName = file.getOriginalFilename();
        FileCopyUtils.copy(newcattle.getImage().getBytes(), new File(fileUpload, fileName));
        if (file.isEmpty()) {
            return "Admin/cattle/createcattle";
        }

        Cattle cattle = new Cattle();
        cattle.setCattleId(newcattle.getCattleId());
        cattle.setName(newcattle.getName());
        cattle.setPrice(newcattle.getPrice());
        cattle.setImage(fileName);
        cattle.setGender(newcattle.getGender());
        cattle.setWeight(newcattle.getWeight());
        cattle.setClassify(newcattle.getClassify());
        cattle.setDateOfBirth(newcattle.getDateOfBirth());
        cattle.setStatus(false);
        cattle.setDescription(newcattle.getDescription());
        cattle.setCattleCategoryId(newcattle.getCattleCategoryId());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Cattle> request = new HttpEntity<>(cattle, headers);
        try {
            ResponseEntity<String> response = rest.exchange(
                    urlCattle + "/createcattles",
                    HttpMethod.POST,
                    request,
                    String.class);
            if (response.getStatusCode() == HttpStatus.CREATED) {
                return "redirect:/cattle";
            } else {
                return "Admin/cattle/createcattle";
            }
        } catch (Exception ex) {
            redirectAttributes.addFlashAttribute("error", "Error during create: " + ex.getMessage());
            return "redirect:/createcattle";
        }
    }

    @GetMapping("/detailscattle/{id}")
    public String detailscattle(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String cattleone = urlCattle + "/" + id;
        Cattle cattle = rest.getForObject(cattleone, Cattle.class);
        model.addAttribute("cattle", cattle);
        return "Admin/cattle/detailscattle"; // Trả về tên của template HTML (editUser.html)
    }

    @GetMapping("/editcattle/{id}")
    public String editcattle(@PathVariable int id, Model model, HttpSession session) {
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        if (username == null) {
            return "redirect:/login";
        }
         if (!username.equals("Admin")) {
            return "redirect:/";
        }
        String cattleone = urlCattle + "/" + id;
        Cattle cattle = rest.getForObject(cattleone, Cattle.class);
        model.addAttribute("cattle", cattle);

        ResponseEntity<Cattlecategory[]> responseEntity = rest.getForEntity(urlcattlecategory, Cattlecategory[].class);
        Cattlecategory[] categories = responseEntity.getBody();

        model.addAttribute("cattlecategory", categories);
        return "Admin/cattle/editcattle"; // Trả về tên của template HTML (editUser.html)
    }

    @PostMapping("/editcattle/{id}")
    public String Editcattle(@ModelAttribute("CattleDto") CattleDto cattleDto, @PathVariable int id,
            Model model, RedirectAttributes redirectAttributes) throws IOException {
        try {
            String cattleone = urlCattle + "/" + id;
            Cattle cattle = rest.getForObject(cattleone, Cattle.class);

            MultipartFile file = cattleDto.getImage();
            if (file != null && !file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                FileCopyUtils.copy(file.getBytes(), new File(fileUpload, fileName));

                // Cập nhật thông tin sản phẩm với hình ảnh mới
                cattle.setName(cattleDto.getName());
                cattle.setPrice(cattleDto.getPrice());
                cattle.setGender(cattleDto.getGender());
                cattle.setImage(fileName);
                cattle.setWeight(cattleDto.getWeight());
                cattle.setClassify(cattleDto.getClassify());
                cattle.setDateOfBirth(cattleDto.getDateOfBirth());
                cattle.setStatus(cattleDto.getStatus());
                cattle.setDescription(cattleDto.getDescription());
                cattle.setCattleCategoryId(cattleDto.getCattleCategoryId());
            } else {
                // Không có tệp tin mới, giữ nguyên hình ảnh cũ
                cattle.setName(cattleDto.getName());
                cattle.setPrice(cattleDto.getPrice());
                cattle.setGender(cattleDto.getGender());
                cattle.setWeight(cattleDto.getWeight());
                cattle.setClassify(cattleDto.getClassify());
                cattle.setDateOfBirth(cattleDto.getDateOfBirth());
                cattle.setStatus(cattleDto.getStatus());
                cattle.setDescription(cattleDto.getDescription());
                cattle.setCattleCategoryId(cattleDto.getCattleCategoryId());
            }

            // ... xử lý các thông tin khác và lưu vào cơ sở dữ liệu
            String createUrl = urlCattle + "/editcattles"; // Endpoint của RESTful API để tạo đối tượng mới
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Cattle> requestEntity = new HttpEntity<>(cattle, headers);
            ResponseEntity<String> response = rest.exchange(
                    createUrl,
                    HttpMethod.PUT,
                    requestEntity,
                    String.class
            );

            if (response.getStatusCode() == HttpStatus.CREATED) {
                return "redirect:/cattle"; // Trả về trang thành công sau khi cập nhật
            } else {
                return "Error/errorPage"; // Xử lý lỗi nếu cần
            }
        } catch (IOException e) {
            return "Failed to upload file: " + e.getMessage();
        }

    }

    @GetMapping("/deletecattle/{id}")
    public String Delete(@PathVariable int id, Model model) {
        String producturl = urlCattle + "/" + id;
        try {
            rest.exchange(producturl, HttpMethod.DELETE, null, String.class);
            return "redirect:/cattle";
        } catch (Exception e) {
            return "Error/errorPage";
        }
    }
}
