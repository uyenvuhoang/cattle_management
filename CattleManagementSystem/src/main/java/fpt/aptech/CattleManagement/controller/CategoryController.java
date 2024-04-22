/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/RestController.java to edit this template
 */
package fpt.aptech.CattleManagement.controller;

import fpt.aptech.CattleManagement.entities.Category;
import fpt.aptech.CattleManagement.service.CategoryService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

/**
 *
 * @author admin
 */
@RestController
@RequestMapping("/api/category")
public class CategoryController {

    @Autowired
    CategoryService categoryService;

    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    public List<Category> findallcategory() {
        return categoryService.FindAll();
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Category findbyidcategory(@PathVariable int id) {
        return categoryService.findbyId(id);
    }

    @PostMapping("/Createcategory")
    @ResponseStatus(HttpStatus.CREATED)
    public void savecategory(@RequestBody Category newcategory) {
        categoryService.save(newcategory);
    }

     @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deletecategory(@PathVariable int id) {
        categoryService.deletecate(id);
    }
    @PutMapping("/editcategory")
    @ResponseStatus(HttpStatus.OK)
    public Category editcategory(@RequestBody Category updatecategory) {
       return categoryService.updateCategory(updatecategory);
    }

   
}
