package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.UserService;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.impl.UserDAOImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManagementController", urlPatterns = {"/admin/user-management", "/admin/user-management/*"})
public class UserManagementController extends HttpServlet {
    private UserService userService;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        this.userService = new UserService();
        this.userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        request.setAttribute("keyword", keyword);

        // Get list of all users
        List<User> allUsers = userService.getUsers(keyword, null, 1);

        // Set lists as request attributes
        request.setAttribute("students", allUsers);
        request.setAttribute("teachers", allUsers);

        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/views/user_management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/admin/user-management");
            return;
        }

        // Handle specific user actions
        response.sendRedirect(request.getContextPath() + "/admin/user-management?error=User status management is not supported");
    }
}