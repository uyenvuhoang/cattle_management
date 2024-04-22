/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package fpt.aptech.CattleManagement.service;

import fpt.aptech.CattleManagement.entities.User;
import fpt.aptech.CattleManagement.repository.AuthRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;


/**
 *
 * @author admin
 */
@Service
public class AuthService {

    @Autowired
    AuthRepository authRepository;

    public User UserbyId(@PathVariable int id) {
        return authRepository.findById(id).get();
    }

    public void Useredit(User edituser) {
        authRepository.save(edituser);
    }
}
