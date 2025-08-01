package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.Blog;
import java.util.List;

public interface BlogDAO {
    List<Blog> getAllBlogs();
    Blog getBlogById(int id);
    boolean createBlog(Blog blog);
    boolean updateBlog(Blog blog);
    boolean deleteBlog(int id);
    List<Blog> getPublishedBlogs();
    List<Blog> getBlogsForUser(int userId);
    List<Blog> getRelatedBlogs(int currentBlogId, int authorId, int limit);
}
