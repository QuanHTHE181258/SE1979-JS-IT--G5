package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.annotations.RequireRole;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.UserService;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManagementController", urlPatterns = {"/admin/user-management", "/admin/user-management/list"})
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
        String servletPath = request.getServletPath();
        String roleId = SessionUtil.getUserRole(request);
        if ("/admin/user-management".equals(servletPath) && "4".equals(roleId)) {
            response.sendRedirect(request.getContextPath() + "/admin/user-management/list");
            return;
        }
        if ("/admin/user-management/list".equals(servletPath)) {
            String keyword = request.getParameter("keyword");
            request.setAttribute("keyword", keyword);
            // Get student list
            List<User> students = userService.getUsers(keyword, "Student", 1);
            // Get teacher list
            List<User> teachers = userService.getUsers(keyword, "Teacher", 1);
            request.setAttribute("students", students);
            request.setAttribute("teachers", teachers);
            request.getRequestDispatcher("/WEB-INF/views/user_management_list.jsp").forward(request, response);
        } else {
            // Landing page
            request.getRequestDispatcher("/WEB-INF/views/admin_users.jsp").forward(request, response);
        }
    }
} 