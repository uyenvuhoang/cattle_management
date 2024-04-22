/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package fpt.aptech.CattleManagement.service;

import fpt.aptech.CattleManagement.entities.Category;
import fpt.aptech.CattleManagement.repository.CategoryRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class CategoryService {

    @Autowired
    CategoryRepository categoryRepository;

    public List<Category> FindAll() {
        return categoryRepository.findAll();
    }

    public Category findbyId(int id) {
        return categoryRepository.findById(id).get();
    }

    public void save(Category newcategory) {
        categoryRepository.save(newcategory);
    }

    public Category updateCategory(Category upcategory) {
        return categoryRepository.save(upcategory);
    }

    public void deletecate(int id) {
        Category c = categoryRepository.findById(id).get();
        categoryRepository.delete(c);
    }
}
