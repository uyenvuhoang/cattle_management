/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/RestController.java to edit this template
 */
package fpt.aptech.CattleManagement.controller;

import fpt.aptech.CattleManagement.dto.SignUpDto;
import fpt.aptech.CattleManagement.entities.User;
import fpt.aptech.CattleManagement.repository.AuthRepository;
import fpt.aptech.CattleManagement.service.AuthService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 *
 * @author admin
 */
@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    AuthService authService;

    private final AuthRepository authRepository;

    public AuthController(AuthRepository authRepository) {
        this.authRepository = authRepository;
    }

    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    public List<User> findallcategory() {
        return authRepository.findAll();
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public User UserbyId(@PathVariable int id) {
        return authService.UserbyId(id);
    }

    @PutMapping("/edituser")
    @ResponseStatus(HttpStatus.CREATED)
    public void editcategory(@RequestBody User updateuser) {
        authService.Useredit(updateuser);
    }

    @PostMapping("/register")
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<String> registerUser(@RequestBody SignUpDto newUser) {
        // Kiểm tra xem username đã tồn tại chưa
        if (authRepository.findByEmail(newUser.getEmail()) != null) {
            return ResponseEntity.status(HttpStatus.FOUND).body("Email already exists");
        }
        // Lưu thông tin người dùng vào cơ sở dữ liệu
        User user = new User();
        user.setUsername(newUser.getUsername());
        user.setEmail(newUser.getEmail());
        user.setPassword(newUser.getPassword());
        user.setPhone(newUser.getPhone());
        user.setCountry(newUser.getCountry());
        user.setRole("User");
        authRepository.save(user);
        return ResponseEntity.ok("User registered successfully");
    }

    @PostMapping("/login")
    public ResponseEntity<User> loginUser(@RequestBody User user) {
        User existingUser = authRepository.findByEmail(user.getEmail());
        if (existingUser != null && existingUser.getPassword().equals(user.getPassword())) {
            if ("Admin".equals(existingUser.getRole())) {
                // Trả về thông tin người dùng cho người quản trị
                return ResponseEntity.status(HttpStatus.ACCEPTED).body(existingUser);
            } else if ("User".equals(existingUser.getRole())) {
                // Trả về thông tin người dùng cho người dùng thông thường
                return ResponseEntity.ok(existingUser);
            } else {
                // Trường hợp khác
                return ResponseEntity.status(HttpStatus.FORBIDDEN).body(null);
            }
        }
        // Trường hợp đăng nhập không thành công
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
    }

}
