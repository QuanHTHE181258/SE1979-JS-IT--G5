package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.service.BlogService;
import project.demo.coursemanagement.entities.Blog;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet({"/blog/list", "/admin/blog/list"})
public class BlogController extends HttpServlet {
    private BlogService blogService;

    @Override
    public void init() throws ServletException {
        blogService = new BlogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        project.demo.coursemanagement.entities.User currentUser = project.demo.coursemanagement.utils.SessionUtil.getUserFromSession(request);
        String userRole = project.demo.coursemanagement.utils.SessionUtil.getUserRole(request);
        java.util.List<project.demo.coursemanagement.entities.Blog> blogList;
        if (project.demo.coursemanagement.utils.SessionUtil.isAdmin(request)) {
            blogList = blogService.getAllBlogs();
        } else if (currentUser != null) {
            blogList = blogService.getBlogsForUser(currentUser.getId());
        } else {
            blogList = blogService.getPublishedBlogs();
        }
        request.setAttribute("blogList", blogList);
        request.getRequestDispatcher("/WEB-INF/views/blog_list.jsp").forward(request, response);
    }
}