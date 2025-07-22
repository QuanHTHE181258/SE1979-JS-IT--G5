package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.service.BlogService;
import project.demo.coursemanagement.entities.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

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
        String idParam = request.getParameter("id");
        Blog blog = null;
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                blog = blogService.getBlogById(id);
            } catch (NumberFormatException ignored) {}
        }
        request.setAttribute("blog", blog);
        request.getRequestDispatcher("/WEB-INF/views/blog_detail.jsp").forward(request, response);
    }
} 