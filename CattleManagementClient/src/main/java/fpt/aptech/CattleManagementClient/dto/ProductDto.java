/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fpt.aptech.CattleManagementClient.dto;

import fpt.aptech.CattleManagementClient.entities.Category;
import fpt.aptech.CattleManagementClient.entities.User;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author admin
 */
public class ProductDto {

    private Integer id;

    private String productname;

    private Double sale;

    private MultipartFile image;

    private String date;

    private double price;

    private Integer quantity;

    private String units;

    private String description;

    private String status;

    private Category categoryid;

    public ProductDto() {
    }

    public ProductDto(Integer id, String productname, Double sale, MultipartFile image, String date, double price, Integer quantity, String units, String description, String status, Category categoryid) {
        this.id = id;
        this.productname = productname;
        this.sale = sale;
        this.image = image;
        this.date = date;
        this.price = price;
        this.quantity = quantity;
        this.units = units;
        this.description = description;
        this.status = status;
        this.categoryid = categoryid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname;
    }

    public Double getSale() {
        return sale;
    }

    public void setSale(Double sale) {
        this.sale = sale;
    }

    public MultipartFile getImage() {
        return image;
    }

    public void setImage(MultipartFile image) {
        this.image = image;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public String getUnits() {
        return units;
    }

    public void setUnits(String units) {
        this.units = units;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Category getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(Category categoryid) {
        this.categoryid = categoryid;
    }

   
    
    
}
