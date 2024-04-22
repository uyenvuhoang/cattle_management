/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package fpt.aptech.CattleManagement.service;

import fpt.aptech.CattleManagement.entities.Category;
import fpt.aptech.CattleManagement.entities.Product;
import fpt.aptech.CattleManagement.repository.ProductRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class ProductService {

    @Autowired
    ProductRepository productRepository;

    public List<Product> FindAll() {
        return productRepository.findAll();
    }

    public List<Product> searchByName(String productname) {
        return productRepository.findProductsByNameLike(productname);
    }

    public List<Product> findByIdCats(Category categoryid) {
        return productRepository.findByIdcat(categoryid);
    }

    public List<Product> findByPrice(double min, double max) {
        return productRepository.findByPrice(min, max);
    }

    public Product productbyId(int id) {
        return productRepository.findById(id).get();
    }

    public void saveproduct(Product newproduct) {
        productRepository.save(newproduct);
    }

    public void deleteproduct(int id) {
        Product productId = productRepository.findById(id).get();
        productRepository.delete(productId);
    }
    
     public int countProduct(){
       return (int) productRepository.count();
    }
}
