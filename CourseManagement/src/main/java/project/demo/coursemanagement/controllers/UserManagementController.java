package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManagementController", urlPatterns = {"/admin/user-management"})
public class UserManagementController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get list of students (using role 'USER') and teachers
        List<User> students = userService.getUsers(null, "USER", 1); // Changed from "STUDENT" to "USER"
        List<User> teachers = userService.getUsers(null, "TEACHER", 1); // Assuming role name is 'TEACHER'

        // Set lists as request attributes
        request.setAttribute("students", students);
        request.setAttribute("teachers", teachers);

        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/views/user_management.jsp").forward(request, response);
    }

    // TODO: Add doPost method if needed for future actions
} 