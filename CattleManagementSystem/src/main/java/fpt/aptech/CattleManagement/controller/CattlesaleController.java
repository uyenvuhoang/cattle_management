/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/RestController.java to edit this template
 */
package fpt.aptech.CattleManagement.controller;

import fpt.aptech.CattleManagement.entities.Cattlesale;
import fpt.aptech.CattleManagement.service.CattlesaleService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.*;

/**
 *
 * @author admin
 */
@RestController
@RequestMapping("/api/cattlesale")
public class CattlesaleController {
    @Autowired 
    CattlesaleService cattlesaleService;
    
    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    public List<Cattlesale> findallCattlesale() {
        return cattlesaleService.FindAll();
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Cattlesale findbyidCattlesale(@PathVariable int id) {
        return cattlesaleService.findbyId(id);
    }

    @PostMapping("/Createcattlesale")
    @ResponseStatus(HttpStatus.CREATED)
    public void savecattlesale(@RequestBody Cattlesale newcattlesale) {
       cattlesaleService.save(newcattlesale);
    }

     @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deletecategory(@PathVariable int id) {
        cattlesaleService.deletecattlesale(id);
    }
}
