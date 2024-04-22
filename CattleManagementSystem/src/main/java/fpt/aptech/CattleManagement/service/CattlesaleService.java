/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package fpt.aptech.CattleManagement.service;

import fpt.aptech.CattleManagement.entities.Cattlesale;
import fpt.aptech.CattleManagement.repository.CattlesaleRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class CattlesaleService {
    @Autowired
    CattlesaleRepository cattlesaleRepository;
    
    public List<Cattlesale> FindAll(){
        return cattlesaleRepository.findAll();
    }
    
    public Cattlesale findbyId(int id){
        return cattlesaleRepository.findById(id).get();
    }
    
    public void save(Cattlesale newCattlesale){
        cattlesaleRepository.save(newCattlesale);
    }
    
    public void deletecattlesale(int id){
      Cattlesale Cattlesale = cattlesaleRepository.findById(id).get();
      cattlesaleRepository.delete(Cattlesale);
    }
}
