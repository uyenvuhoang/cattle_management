/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package fpt.aptech.CattleManagement.service;

import fpt.aptech.CattleManagement.entities.Cattlecategory;
import fpt.aptech.CattleManagement.repository.CattlecategoryRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class CattlecategoryService {
    @Autowired
    CattlecategoryRepository cattlecategoryRepository;

    
    public List<Cattlecategory> FindAll(){
        return cattlecategoryRepository.findAll();
    }
    
    public Cattlecategory findbyId(int id){
        return cattlecategoryRepository.findById(id).get();
    }
    
    public void save(Cattlecategory newcattlecategory){
        cattlecategoryRepository.save(newcattlecategory);
    }
    
    public void deletecate(int id){
      Cattlecategory cattlecategory = cattlecategoryRepository.findById(id).get();
      cattlecategoryRepository.delete(cattlecategory);
    }
}
