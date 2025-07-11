package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.BlogDAO;
import project.demo.coursemanagement.dao.impl.BlogDAOImpl;
import project.demo.coursemanagement.entities.Blog;
import java.util.List;

public class BlogService {
    private BlogDAO blogDAO;

    public BlogService() {
        this.blogDAO = new BlogDAOImpl();
    }

    public List<Blog> getAllBlogs() {
        return blogDAO.getAllBlogs();
    }

    public Blog getBlogById(int id) {
        return blogDAO.getBlogById(id);
    }
} 