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

@WebServlet(name = "UserListController", urlPatterns = {"/admin/user-management/list"})
@RequireRole({"ADMIN", "USER_MANAGER"})
public class UserListController extends HttpServlet {
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
        String roleId = SessionUtil.getUserRole(request);

        if ("4".equals(roleId) || "5".equals(roleId)) {
            // For User Manager and Admin roles
            request.setAttribute("keyword", keyword);
            // Get student list
            List<User> students = userService.getUsers(keyword, "Student", 1);
            // Get teacher list
            List<User> teachers = userService.getUsers(keyword, "Teacher", 1);
            request.setAttribute("students", students);
            request.setAttribute("teachers", teachers);
            request.getRequestDispatcher("/WEB-INF/views/user_list.jsp").forward(request, response);
        } else {
            // If not authorized, redirect to main user management page
            response.sendRedirect(request.getContextPath() + "/admin/user-management");
        }
    }
}