/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fpt.aptech.CattleManagement.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import java.util.List;
import lombok.*;

/**
 *
 * @author admin
 */
@Entity
@Table(name = "Cattle")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Cattle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "cattle_id")
    private Integer cattleId;
    @Column(name = "name")
    private String name;
    @Column(name = "price")
    private Double price;
    @Column(name = "image")
    private String image;
    @Column(name = "gender")
    private Boolean gender;
    @Column(name = "weight")
    private Double weight;
    @Column(name = "classify")
    private String classify;
    @Column(name = "date_of_birth")
    private String dateOfBirth;
    @Column(name = "status")
    private Boolean status;
    @Column(name = "description")
    private String description;

    @JoinColumn(name = "cattle_category_id", referencedColumnName = "cattle_category_id")
    @ManyToOne
    private Cattlecategory cattleCategoryId;
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    @ManyToOne
    private User userId;
    @OneToMany(mappedBy = "cattleId")
    @JsonIgnore
    private List<Cattlesale> cattlesaleList;
}
