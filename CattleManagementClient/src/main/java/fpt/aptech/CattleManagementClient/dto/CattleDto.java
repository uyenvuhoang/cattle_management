/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fpt.aptech.CattleManagementClient.dto;

import fpt.aptech.CattleManagementClient.entities.Cattlecategory;
import fpt.aptech.CattleManagementClient.entities.Cattlesale;
import fpt.aptech.CattleManagementClient.entities.User;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author admin
 */
public class CattleDto {

    private Integer cattleId;

    private String name;

    private Double price;

    private MultipartFile image;

    private Boolean gender;
 
    private Double weight;

    private String classify;
    
    private String dateOfBirth;

    private Boolean status;
    
    private String description;
    
    private Cattlecategory cattleCategoryId;

    private User userId;

    private List<Cattlesale> cattlesaleList;

    public CattleDto() {
    }

    public CattleDto(Integer cattleId, String name, Double price, MultipartFile image, Boolean gender, Double weight, String classify, String dateOfBirth, Boolean status, String description, Cattlecategory cattleCategoryId, User userId, List<Cattlesale> cattlesaleList) {
        this.cattleId = cattleId;
        this.name = name;
        this.price = price;
        this.image = image;
        this.gender = gender;
        this.weight = weight;
        this.classify = classify;
        this.dateOfBirth = dateOfBirth;
        this.status = status;
        this.description = description;
        this.cattleCategoryId = cattleCategoryId;
        this.userId = userId;
        this.cattlesaleList = cattlesaleList;
    }

    public Integer getCattleId() {
        return cattleId;
    }

    public void setCattleId(Integer cattleId) {
        this.cattleId = cattleId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public MultipartFile getImage() {
        return image;
    }

    public void setImage(MultipartFile image) {
        this.image = image;
    }

    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public String getClassify() {
        return classify;
    }

    public void setClassify(String classify) {
        this.classify = classify;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Cattlecategory getCattleCategoryId() {
        return cattleCategoryId;
    }

    public void setCattleCategoryId(Cattlecategory cattleCategoryId) {
        this.cattleCategoryId = cattleCategoryId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    public List<Cattlesale> getCattlesaleList() {
        return cattlesaleList;
    }

    public void setCattlesaleList(List<Cattlesale> cattlesaleList) {
        this.cattlesaleList = cattlesaleList;
    }

    
    
}
