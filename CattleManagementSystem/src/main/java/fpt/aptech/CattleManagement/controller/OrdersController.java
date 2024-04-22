/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/RestController.java to edit this template
 */
package fpt.aptech.CattleManagement.controller;

import fpt.aptech.CattleManagement.entities.Orders;
import fpt.aptech.CattleManagement.service.OrdersService;
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
@RequestMapping("/api/orders")
public class OrdersController {

    @Autowired
    OrdersService ordersService;

    @GetMapping()
    @ResponseStatus(HttpStatus.OK)
    public List<Orders> findalloders() {
        return ordersService.FindAll();
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Orders findbyidorder(@PathVariable int id) {
        return ordersService.findbyId(id);
    }

    @PostMapping("/createoders")
    @ResponseStatus(HttpStatus.CREATED)
    public void saveprodutcart(@RequestBody Orders neworders) {
        ordersService.save(neworders);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteorders(@PathVariable int id) {
        ordersService.deleteorders(id);
    }

    @PutMapping("/editorders")
    @ResponseStatus(HttpStatus.OK)
    public Orders editproductcart(@RequestBody Orders uporders) {
        return ordersService.updateorders(uporders);
    }
}
