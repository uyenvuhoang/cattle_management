/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package fpt.aptech.CattleManagement.service;

import fpt.aptech.CattleManagement.entities.Comment;
import fpt.aptech.CattleManagement.repository.CommentRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class CommentService {
    @Autowired
    CommentRepository commentRepository;

    
    public List<Comment> FindAll(){
        return commentRepository.findAll();
    }
    
    
    public void save(Comment newcomment){
        commentRepository.save(newcomment);
    }
    
    public void deletecomment(int id){
      Comment comment = commentRepository.findById(id).get();
      commentRepository.delete(comment);
    }
}
