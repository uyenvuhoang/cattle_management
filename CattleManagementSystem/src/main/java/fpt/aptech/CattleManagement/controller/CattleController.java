/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/RestController.java to edit this template
 */
package fpt.aptech.CattleManagement.controller;

import fpt.aptech.CattleManagement.entities.Cattle;
import fpt.aptech.CattleManagement.entities.Cattlecategory;
import fpt.aptech.CattleManagement.entities.User;
import fpt.aptech.CattleManagement.service.CattleService;
import fpt.aptech.CattleManagement.service.CattlecategoryService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 *
 * @author admin
 */
@RestController
@RequestMapping("/api/cattle")
public class CattleController {

    @Autowired
    CattleService cattleService;

    @Autowired
    CattlecategoryService cattlecategoryService;

    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    public List<Cattle> findAll() {
        return cattleService.FindAll();
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Cattle cattleid(@PathVariable int id) {
        return cattleService.CattlebyId(id);
    }

    @GetMapping("/search")
    public List<Cattle> searchProductsByName(@RequestParam String name) {
        return cattleService.searchByName(name);
    }

    @GetMapping("/searchprice")
    public List<Cattle> searchProductsByPriceRange(
            @RequestParam(name = "min") double minPrice,
            @RequestParam(name = "max") double maxPrice
    ) {
        return cattleService.findByPrice(minPrice, maxPrice);
    }

    @GetMapping("/bycattlecategory")
    public List<Cattle> getProductsByCategory(@RequestParam("cattleCategoryId") Integer cattleCategoryId) {
        Cattlecategory ccategory = new Cattlecategory();
        ccategory.setCattleCategoryId(cattleCategoryId);
        List<Cattle> cattles = cattleService.findByIdCats(ccategory);
        return cattles;
    }

    @GetMapping("/count")
    @ResponseStatus(HttpStatus.OK)
    public long getCountOfRecords() {
        long count = cattleService.countCattle();
        return count;
    }

    @PostMapping("/createcattles")
    @ResponseStatus(HttpStatus.CREATED)
    public void SaveCattle(@RequestBody Cattle newcattle) {
        User u = new User();
        u.setId(1);
        newcattle.setUserId(u);
        cattleService.savecattle(newcattle);
    }

    @PutMapping("/editcattles")
    @ResponseStatus(HttpStatus.CREATED)
    public void EditCattle(@RequestBody Cattle newcattle) {
        User u = new User();
        u.setId(1);
        newcattle.setUserId(u);
        cattleService.savecattle(newcattle);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteCattle(@PathVariable int id) {
        cattleService.deletecattle(id);
    }
}
