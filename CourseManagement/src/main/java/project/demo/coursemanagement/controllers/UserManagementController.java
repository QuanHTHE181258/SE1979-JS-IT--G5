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

@WebServlet(name = "UserManagementController", urlPatterns = {"/admin/user-management", "/admin/user-management/*"})
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
        System.out.println("line 28"+ keyword);
        request.setAttribute("keyword", keyword);

        // Lấy danh sách học sinh
        List<User> students = userService.getUsers(keyword, "Student", 1);
        // Lấy danh sách giảng viên
        List<User> teachers = userService.getUsers(keyword, "Teacher", 1);

        // Truyền hai danh sách riêng biệt sang JSP
        request.setAttribute("students", students);
        request.setAttribute("teachers", teachers);

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