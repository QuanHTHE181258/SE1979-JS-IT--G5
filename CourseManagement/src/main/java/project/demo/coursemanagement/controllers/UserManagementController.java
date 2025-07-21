package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.annotations.RequireRole;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManagementController", urlPatterns = {"/admin/user-management"})
@RequireRole({"ADMIN", "USER_MANAGER"})
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
        String keyword = request.getParameter("keyword");
        request.setAttribute("keyword", keyword);

        // Get student list
        List<User> students = userService.getUsers(keyword, "Student", 1);
        // Get teacher list
        List<User> teachers = userService.getUsers(keyword, "Teacher", 1);

        // Pass the two separate lists to the JSP
        request.setAttribute("students", students);
        request.setAttribute("teachers", teachers);

        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/views/user_management.jsp").forward(request, response);
    }
} 