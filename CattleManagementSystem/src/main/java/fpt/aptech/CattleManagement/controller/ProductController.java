/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/RestController.java to edit this template
 */
package fpt.aptech.CattleManagement.controller;

import fpt.aptech.CattleManagement.entities.Category;
import fpt.aptech.CattleManagement.entities.Product;
import fpt.aptech.CattleManagement.entities.User;
import fpt.aptech.CattleManagement.service.CategoryService;
import fpt.aptech.CattleManagement.service.ProductService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 *
 * @author admin
 */
@RestController
@RequestMapping("/api/product")
public class ProductController {

    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;

    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    public List<Product> findallproduct() {
        return productService.FindAll();
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Product ProductbyId(@PathVariable int id) {
        return productService.productbyId(id);
    }
     @GetMapping("/countproduct")
    @ResponseStatus(HttpStatus.OK)
    public long getCountOfRecords() {
        long count = productService.countProduct();
        return count;
    }

    @GetMapping("/search")
    public List<Product> searchProductsByName(@RequestParam String productname) {
        return productService.searchByName(productname);
    }

    @GetMapping("/searchprice")
    public List<Product> searchProductsByPriceRange(
            @RequestParam(name = "min") double minPrice,
            @RequestParam(name = "max") double maxPrice
    ) {
        return productService.findByPrice(minPrice, maxPrice);
    }

    @GetMapping("/bycategory")
    public List<Product> getProductsByCategory(@RequestParam("categoryid") Integer categoryid) {
        Category category = new Category();
        category.setId(categoryid);
        List<Product> products = productService.findByIdCats(category);
        return products;
    }

    @PostMapping("/createproduct")
    @ResponseStatus(HttpStatus.CREATED)
    public void saveproduct(@Validated @RequestBody Product newproduct) {
        User user = new User();
        user.setId(1);
        newproduct.setUserId(user);

        productService.saveproduct(newproduct);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteproduct(@PathVariable int id) {
        productService.deleteproduct(id);
    }

    @PutMapping("/editproduct")
    @ResponseStatus(HttpStatus.CREATED)
    public void editproduct(@Validated @RequestBody Product newproduct) {
        User user = new User();
        user.setId(1);

        newproduct.setUserId(user);

        productService.saveproduct(newproduct);
    }
}
