//package project.demo.coursemanagement.controllers;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import project.demo.coursemanagement.annotations.RequireRole;
//import project.demo.coursemanagement.entities.User;
//import project.demo.coursemanagement.service.UserService;
//import project.demo.coursemanagement.utils.SessionUtil;
//
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet(name = "UserManagementController", urlPatterns = {"/admin/user-management"})
//@RequireRole({"ADMIN", "USER_MANAGER"})
//public class UserManagementController extends HttpServlet {
//    private UserService userService;
//
//    @Override
//    public void init() throws ServletException {
//        super.init();
//        this.userService = new UserService();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String search = request.getParameter("search");
//        String roleFilter = request.getParameter("role");
//        String pageStr = request.getParameter("page");
//        int page = 1;
//
//        try {
//            if (pageStr != null) {
//                page = Integer.parseInt(pageStr);
//            }
//        } catch (NumberFormatException e) {
//            // Keep default page = 1 if invalid
//        }
//
//        // Get users with pagination
//        List<User> users = userService.getUsers(search, roleFilter, page);
//        int totalUsers = userService.getTotalUsers(search, roleFilter);
//        int totalPages = (int) Math.ceil(totalUsers / 10.0); // Assuming 10 users per page
//
//        request.setAttribute("users", users);
//        request.setAttribute("currentPage", page);
//        request.setAttribute("totalPages", totalPages);
//
//        request.getRequestDispatcher("/WEB-INF/views/user_management_list.jsp").forward(request, response);
//    }
//}
