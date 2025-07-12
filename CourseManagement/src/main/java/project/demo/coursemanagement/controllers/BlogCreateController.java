package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.service.BlogService;
import project.demo.coursemanagement.entities.Blog;
import project.demo.coursemanagement.entities.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/blog/create")
public class BlogCreateController extends HttpServlet {
    private BlogService blogService;

    @Override
    public void init() throws ServletException {
        blogService = new BlogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form tạo blog
        request.getRequestDispatcher("/WEB-INF/views/blog_create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý tạo blog mới
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String imageURL = request.getParameter("imageURL");
        String status = request.getParameter("status");
        
        // Lấy user hiện tại từ session
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login");
            return;
        }

        Blog blog = new Blog();
        blog.setTitle(title);
        blog.setContent(content);
        blog.setImageURL(imageURL);
        blog.setStatus(status);
        blog.setAuthorID(currentUser);

        boolean success = blogService.createBlog(blog);
        if (success) {
            response.sendRedirect("list");
        } else {
            request.setAttribute("error", "Failed to create blog");
            request.getRequestDispatcher("/WEB-INF/views/blog_create.jsp").forward(request, response);
        }
    }
} 