package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.UserDAOImpl;
import project.demo.coursemanagement.dao.RegisterDAO;
import project.demo.coursemanagement.dao.RegisterDAOImpl;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;
import java.util.Date;
import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "AdminUserController", urlPatterns = {"/admin/users", "/admin/users/*"})
public class AdminUserController extends HttpServlet {
    private final UserDAO userDAO;
    private final RegisterDAO registerDAO;

    public AdminUserController() {
        this.userDAO = new UserDAOImpl();
        this.registerDAO = new RegisterDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String searchTerm = request.getParameter("searchTerm");
        request.setAttribute("searchTerm", searchTerm);

        if (pathInfo == null || pathInfo.equals("/")) {
            // List all users or search
            List<User> userList;
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                userList = userDAO.searchUsersByName(searchTerm);
            } else {
                userList = userDAO.getAllUsers();
            }
            // Convert Instant to Date for JSP formatting
            userList.forEach(user -> {
                if (user.getLastLogin() != null) {
                    user.setLastLoginDate(Date.from(user.getLastLogin()));
                }
                if (user.getCreatedAt() != null) {
                     user.setCreatedAtDate(Date.from(user.getCreatedAt()));
                }
            });
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("/WEB-INF/views/admin_users.jsp").forward(request, response);
        } else {
            // Handle specific user actions
            String[] pathParts = pathInfo.split("/");
            if (pathParts.length >= 3) {
                String userId = pathParts[1];
                String action = pathParts[2];
                
                try {
                    int id = Integer.parseInt(userId);
                    User user = userDAO.findUserByIdIncludeInactive(id);
                    
                    if (user != null) {
                        switch (action) {
                            case "deactivate":
                                if (registerDAO.updateUserActiveStatus(id, false)) {
                                    response.sendRedirect(request.getContextPath() + "/admin/users?message=User deactivated successfully");
                                } else {
                                    response.sendRedirect(request.getContextPath() + "/admin/users?error=Failed to deactivate user");
                                }
                                break;
                            case "activate":
                                if (registerDAO.updateUserActiveStatus(id, true)) {
                                    response.sendRedirect(request.getContextPath() + "/admin/users?message=User activated successfully");
                                } else {
                                    response.sendRedirect(request.getContextPath() + "/admin/users?error=Failed to activate user");
                                }
                                break;
                            default:
                                response.sendRedirect(request.getContextPath() + "/admin/users?error=Invalid action");
                        }
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/users?error=User not found");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?error=Invalid user ID");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=Invalid request");
            }
        }
    }
}