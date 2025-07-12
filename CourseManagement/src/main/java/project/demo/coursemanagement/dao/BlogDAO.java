package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.Blog;
import java.util.List;

public interface BlogDAO {
    List<Blog> getAllBlogs();
    Blog getBlogById(int id);
    boolean createBlog(Blog blog);
    boolean updateBlog(Blog blog);
} 