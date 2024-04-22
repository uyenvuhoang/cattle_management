/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package fpt.aptech.CattleManagement.service;

import fpt.aptech.CattleManagement.entities.Orders;
import fpt.aptech.CattleManagement.repository.OrdersRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class OrdersService {
     @Autowired
     OrdersRepository ordersRepository;
    
    public List<Orders> FindAll() {
        return ordersRepository.findAll();
    }
    
    public Orders findbyId(int id) {
        return ordersRepository.findById(id).get();
    }
    
    public void save(Orders neworder) {
        ordersRepository.save(neworder);
    }
    
    public Orders updateorders(Orders uporders) {
        return ordersRepository.save(uporders);
    }
    
    public void deleteorders(int id) {
        Orders cart = ordersRepository.findById(id).get();
        ordersRepository.delete(cart);
    }
}
