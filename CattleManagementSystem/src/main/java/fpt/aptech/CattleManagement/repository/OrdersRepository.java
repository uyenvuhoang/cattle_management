/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Repository.java to edit this template
 */
package fpt.aptech.CattleManagement.repository;

import fpt.aptech.CattleManagement.entities.Orders;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author admin
 */
public interface OrdersRepository extends JpaRepository<Orders, Integer> {
    
}
