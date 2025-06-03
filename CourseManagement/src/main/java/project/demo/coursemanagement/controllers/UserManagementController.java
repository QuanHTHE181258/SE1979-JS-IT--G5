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

        // Get list of students (using role 'USER') and teachers
        List<User> students = userService.getUsers(keyword, "USER", 1);
        List<User> teachers = userService.getUsers(keyword, "TEACHER", 1);

        // Set lists as request attributes
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
        String[] pathParts = pathInfo.split("/");
        if (pathParts.length >= 3) {
            String userIdString = pathParts[1];
            String action = pathParts[2];
            
            try {
                int userId = Integer.parseInt(userIdString);
                User user = userDAO.findUserByIdIncludeInactive(userId);
                
                if (user != null) {
                    switch (action) {
                        case "deactivate":
                            userService.toggleUserStatus(userId);
                            response.sendRedirect(request.getContextPath() + "/admin/user-management?message=User status toggled successfully");
                            break;
                        case "activate":
                            userService.toggleUserStatus(userId);
                            response.sendRedirect(request.getContextPath() + "/admin/user-management?message=User status toggled successfully");
                            break;
                        default:
                            response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Invalid action");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/user-management?error=User not found");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Invalid user ID format");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/user-management?error=" + e.getMessage());
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Invalid request");
        }
    }
} 