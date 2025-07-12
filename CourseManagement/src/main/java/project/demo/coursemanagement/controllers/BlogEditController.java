package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.service.BlogService;
import project.demo.coursemanagement.entities.Blog;
import project.demo.coursemanagement.entities.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/blog/edit")
public class BlogEditController extends HttpServlet {
    private BlogService blogService;

    @Override
    public void init() throws ServletException {
        blogService = new BlogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form chỉnh sửa blog
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Blog blog = blogService.getBlogById(id);
                if (blog != null) {
                    // Kiểm tra quyền chỉnh sửa
                    User currentUser = (User) request.getSession().getAttribute("currentUser");
                    if (currentUser != null && (currentUser.getId() == blog.getAuthorID().getId() || "ADMIN".equals(currentUser.getRole()))) {
                        request.setAttribute("blog", blog);
                        request.getRequestDispatcher("/WEB-INF/views/blog_edit.jsp").forward(request, response);
                        return;
                    }
                }
            } catch (NumberFormatException ignored) {}
        }
        response.sendRedirect("list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý cập nhật blog
        String idParam = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String imageURL = request.getParameter("imageURL");
        String status = request.getParameter("status");
        
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Blog blog = blogService.getBlogById(id);
                if (blog != null) {
                    // Kiểm tra quyền chỉnh sửa
                    User currentUser = (User) request.getSession().getAttribute("currentUser");
                    if (currentUser != null && (currentUser.getId() == blog.getAuthorID().getId() || "ADMIN".equals(currentUser.getRole()))) {
                        blog.setTitle(title);
                        blog.setContent(content);
                        blog.setImageURL(imageURL);
                        blog.setStatus(status);

                        boolean success = blogService.updateBlog(blog);
                        if (success) {
                            response.sendRedirect("detail?id=" + id);
                        } else {
                            request.setAttribute("error", "Failed to update blog");
                            request.setAttribute("blog", blog);
                            request.getRequestDispatcher("/WEB-INF/views/blog_edit.jsp").forward(request, response);
                        }
                        return;
                    }
                }
            } catch (NumberFormatException ignored) {}
        }
        response.sendRedirect("list");
    }
} 