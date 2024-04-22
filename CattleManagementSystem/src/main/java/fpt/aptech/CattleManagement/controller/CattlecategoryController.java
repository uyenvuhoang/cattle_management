/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/RestController.java to edit this template
 */
package fpt.aptech.CattleManagement.controller;

import fpt.aptech.CattleManagement.entities.Cattlecategory;
import fpt.aptech.CattleManagement.service.CattlecategoryService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

/**
 *
 * @author admin
 */
@RestController
@RequestMapping("/api/cattlecategory")
public class CattlecategoryController {
    @Autowired
    CattlecategoryService cattlecategoryService;
     @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    public List<Cattlecategory> findallCattlecategory() {
        return cattlecategoryService.FindAll();
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Cattlecategory findbyidcattlecategory(@PathVariable int id) {
        return cattlecategoryService.findbyId(id);
    }

    @PostMapping("/createcattlecategory")
    @ResponseStatus(HttpStatus.CREATED)
    public void savecattlecategory(@RequestBody Cattlecategory newcattlecategory) {
       cattlecategoryService.save(newcattlecategory);
    }

    @PutMapping("/editcattlecategory")
    @ResponseStatus(HttpStatus.CREATED)
    public void editcattlecategory(@RequestBody Cattlecategory newcattlecategory) {
       cattlecategoryService.save(newcattlecategory);
    }
    
    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deletecattlecategory(@PathVariable int id) {
        cattlecategoryService.deletecate(id);
    }
}
