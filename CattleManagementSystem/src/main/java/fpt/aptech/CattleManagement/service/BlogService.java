/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package fpt.aptech.CattleManagement.service;

import fpt.aptech.CattleManagement.entities.Blog;
import fpt.aptech.CattleManagement.repository.BlogRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author admin
 */
@Service
public class BlogService {

    @Autowired
    BlogRepository blogRepository;

    public List<Blog> FindAll() {
        return blogRepository.findAll();
    }

    public Blog findbyId(int id) {
        return blogRepository.findById(id).get();
    }

    public void save(Blog newblog) {
        blogRepository.save(newblog);
    }

    public Blog updateblog(Blog upblog) {
        return blogRepository.save(upblog);
    }

    public void deleteblog(int id) {
        Blog blogdelete = blogRepository.findById(id).get();
        blogRepository.delete(blogdelete);
    }
}
