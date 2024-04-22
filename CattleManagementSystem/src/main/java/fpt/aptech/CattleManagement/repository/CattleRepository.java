/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Repository.java to edit this template
 */
package fpt.aptech.CattleManagement.repository;

import fpt.aptech.CattleManagement.entities.Cattle;
import fpt.aptech.CattleManagement.entities.Cattlecategory;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author admin
 */
public interface CattleRepository extends JpaRepository<Cattle, Integer> {

    @Query("SELECT c FROM Cattle c WHERE c.price BETWEEN :min AND :max")
    List<Cattle> findByPrice(@Param("min") double min, @Param("max") double max);

    @Query("SELECT c FROM Cattle c WHERE c.cattleCategoryId= :cattleCategoryId")
    List<Cattle> findByIdcat(@Param("cattleCategoryId") Cattlecategory cattleCategoryId);

    @Query(value = "SELECT * FROM Cattle c WHERE c.name LIKE %:name%", nativeQuery = true)
    List<Cattle> findCattleByNameLike(@Param("name") String name);
}
