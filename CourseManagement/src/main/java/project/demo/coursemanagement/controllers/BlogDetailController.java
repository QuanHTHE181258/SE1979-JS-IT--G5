package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.Blog;
import project.demo.coursemanagement.service.BlogService;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/blog/detail")
public class BlogDetailController extends HttpServlet {
    private BlogService blogService;

    @Override
    public void init() throws ServletException {
        blogService = new BlogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String blogId = request.getParameter("id");
            if (blogId == null || blogId.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/list-blog");
                return;
            }

            // Lấy thông tin blog
            Blog blog = blogService.getBlogById((int) Long.parseLong(blogId));
            if (blog == null || !blog.getStatus().equals("published")) {
                // Lấy các bài vi���t liên quan (3 bài viết khác của cùng tác giả hoặc mới nhất)
                return;
            }

            // Chuyển đổi createdAt thành Date
            if (blog.getCreatedAt() != null) {
                blog.setCreatedAtDate(Date.from(blog.getCreatedAt()));
            }

            // Lấy các bài viết liên quan (3 bài viết khác của cùng tác giả hoặc mới nhất)
            List<Blog> relatedBlogs = blogService.getRelatedBlogs(blog.getId(), blog.getAuthorID().getId(), 3);
            for (Blog relatedBlog : relatedBlogs) {
                if (relatedBlog.getCreatedAt() != null) {
                    relatedBlog.setCreatedAtDate(Date.from(relatedBlog.getCreatedAt()));
                }
            }

            request.setAttribute("blog", blog);
            request.setAttribute("relatedBlogs", relatedBlogs);
            request.getRequestDispatcher("/WEB-INF/views/blog_detail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
}
