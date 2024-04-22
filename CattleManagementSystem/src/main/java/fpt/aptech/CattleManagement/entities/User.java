/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package fpt.aptech.CattleManagement.entities;

/**
 *
 * @author admin
 */
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "users", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"username"}),
    @UniqueConstraint(columnNames = {"email"})
})
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String username;
    private String email;
    private String password;
    private String country;
    private String phone;
    private String role;

    @OneToMany(mappedBy = "userId")
    @JsonIgnore
    private List<Cattle> cattleList;
    @OneToMany(mappedBy = "userId")
    @JsonIgnore
    private List<Product> productList;
    @OneToMany(mappedBy = "userId")
    @JsonIgnore
    private List<Cattlesale> cattlesaleList;
    @OneToMany(mappedBy = "userId")
    @JsonIgnore
    private List<Productcart> productcarts;
    @OneToMany(mappedBy = "userId")
    @JsonIgnore
    private List<Blog> blogs;
    @OneToMany(mappedBy = "userId")
    @JsonIgnore
    private List<Orders> orderses;
}
