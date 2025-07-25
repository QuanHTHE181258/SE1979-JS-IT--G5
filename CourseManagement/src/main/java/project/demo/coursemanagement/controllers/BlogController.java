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
        System.out.println("BlogController: Processing request for " + request.getRequestURI());

        // Check if user has admin role
        if (!project.demo.coursemanagement.utils.SessionUtil.isAdmin(request)) {
            // User is not an admin, set flash message and redirect to home page
            project.demo.coursemanagement.utils.SessionUtil.setFlashMessage(
                request, 
                "error", 
                "Access denied. Admin privileges required to access the blog section."
            );
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // If we get here, the user is an admin
        project.demo.coursemanagement.entities.User currentUser = project.demo.coursemanagement.utils.SessionUtil.getUserFromSession(request);
        String userRole = project.demo.coursemanagement.utils.SessionUtil.getUserRole(request);

        System.out.println("Current user: " + (currentUser != null ? currentUser.getId() : "null"));
        System.out.println("User role: " + userRole);

        java.util.List<project.demo.coursemanagement.entities.Blog> blogList;
        
        System.out.println("Loading all blogs for admin");
        blogList = blogService.getAllBlogs();

        System.out.println("Retrieved " + (blogList != null ? blogList.size() : 0) + " blogs");
        if (blogList != null && !blogList.isEmpty()) {
            System.out.println("First blog title: " + blogList.get(0).getTitle());
        }

        request.setAttribute("blogList", blogList);
        request.getRequestDispatcher("/WEB-INF/views/blog_list.jsp").forward(request, response);
    }
}