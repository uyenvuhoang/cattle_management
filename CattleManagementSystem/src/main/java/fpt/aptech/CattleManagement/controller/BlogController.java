/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/RestController.java to edit this template
 */
package fpt.aptech.CattleManagement.controller;

import fpt.aptech.CattleManagement.entities.Blog;
import fpt.aptech.CattleManagement.entities.User;
import fpt.aptech.CattleManagement.service.BlogService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
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
@RequestMapping("/api/blog")
public class BlogController {

    @Autowired
    BlogService blogService;

    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    public List<Blog> findallcategory() {
        return blogService.FindAll();
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Blog findbyidblog(@PathVariable int id) {
        return blogService.findbyId(id);
    }

    @PostMapping("/createblog")
    @ResponseStatus(HttpStatus.CREATED)
    public void savecategory(@RequestBody Blog newblog) {
          User u = new User();
        u.setId(1);
        newblog.setUserId(u);
        blogService.save(newblog);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteblog(@PathVariable int id) {
        blogService.deleteblog(id);
    }

    @PutMapping("/editblog")
    @ResponseStatus(HttpStatus.OK)
    public Blog editcategory(@RequestBody Blog updateblog) {
        return blogService.updateblog(updateblog);
    }
}
