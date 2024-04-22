/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package fpt.aptech.CattleManagement.service;

import fpt.aptech.CattleManagement.entities.Cattle;
import fpt.aptech.CattleManagement.entities.Cattlecategory;
import fpt.aptech.CattleManagement.repository.CattleRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class CattleService {
    @Autowired 
    CattleRepository cattleRepository;
    
    public List<Cattle> FindAll(){
       return cattleRepository.findAll();
    }
    
    public Cattle CattlebyId(int id){
        return cattleRepository.findById(id).get();
    }
    
       public List<Cattle> searchByName(String name) {
        return cattleRepository.findCattleByNameLike(name);
    }

    public List<Cattle> findByIdCats(Cattlecategory cattleCategoryId) {
        return cattleRepository.findByIdcat(cattleCategoryId);
    }

    public List<Cattle> findByPrice(double min, double max) {
        return cattleRepository.findByPrice(min, max);
    }
    
    public void savecattle(Cattle newcattle){
        cattleRepository.save(newcattle);
    }
    
    public void deletecattle(int id){
      Cattle decattle = cattleRepository.findById(id).get();
        cattleRepository.delete(decattle);
    }
    
    public int countCattle(){
       return (int) cattleRepository.count();
    }
}
