package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.service.BlogService;
import project.demo.coursemanagement.entities.Blog;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/blog/list")
public class BlogController extends HttpServlet {
    private BlogService blogService;

    @Override
    public void init() throws ServletException {
        blogService = new BlogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Blog> blogList = blogService.getAllBlogs();
        request.setAttribute("blogList", blogList);
        request.getRequestDispatcher("/WEB-INF/views/blog_list.jsp").forward(request, response);
    }
}