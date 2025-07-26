package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.impl.RoleDAOImpl;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.service.UserService;
import project.demo.coursemanagement.dao.RoleDAO;

import java.io.IOException;

@WebServlet("/admin/users/edit")
public class EditUserController extends HttpServlet {
    private final UserService userService;
    private final RoleDAO roleDAO;

    public EditUserController() {
        this.userService = new UserService();
        this.roleDAO = new RoleDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            System.out.println("Getting user with ID: " + userId);

            User user = userService.findUserById(userId);
            System.out.println("Found user: " + (user != null ? user.getUsername() : "null"));

            Role userRole = userService.getPrimaryRoleByUserId(userId);
            System.out.println("User role: " + (userRole != null ? userRole.getRoleName() : "null"));

            if (user != null) {
                request.setAttribute("user", user);
                request.setAttribute("userRole", userRole != null ? userRole.getRoleName() : "");
                request.getRequestDispatcher("/WEB-INF/views/admin/user/edit.jsp").forward(request, response);
            } else {
                System.out.println("User not found with ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/admin/users?error=usernotfound");
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid user ID format: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/users?error=invalidid");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            System.out.println("Updating user with ID: " + userId);

            User user = userService.findUserById(userId);
            System.out.println("Found user for update: " + (user != null ? user.getUsername() : "null"));

            if (user != null) {
                // Update user fields
                String oldUsername = user.getUsername();
                String oldEmail = user.getEmail();

                user.setUsername(request.getParameter("username"));
                user.setEmail(request.getParameter("email"));
                user.setFirstName(request.getParameter("firstName"));
                user.setLastName(request.getParameter("lastName"));
                user.setPhoneNumber(request.getParameter("phoneNumber"));

                System.out.println("Updating user details:");
                System.out.println("Username: " + oldUsername + " -> " + user.getUsername());
                System.out.println("Email: " + oldEmail + " -> " + user.getEmail());
                System.out.println("First Name: " + user.getFirstName());
                System.out.println("Last Name: " + user.getLastName());
                System.out.println("Phone: " + user.getPhoneNumber());

                try {
                    boolean updated = userService.updateUser(user);
                    System.out.println("Update result: " + (updated ? "success" : "failed"));

                    if (updated) {
                        response.sendRedirect(request.getContextPath() + "/admin/users?success=updated");
                    } else {
                        request.setAttribute("error", "Failed to update user");
                        request.setAttribute("user", user);
                        request.getRequestDispatcher("/WEB-INF/views/admin/user/edit.jsp").forward(request, response);
                    }
                } catch (Exception e) {
                    System.err.println("Error updating user: " + e.getMessage());
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to update user: " + e.getMessage());
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/WEB-INF/views/admin/user/edit.jsp").forward(request, response);
                }
            } else {
                System.err.println("User not found for update with ID: " + userId);
                response.sendRedirect(request.getContextPath() + "/admin/users?error=usernotfound");
            }
        } catch (Exception e) {
            System.err.println("Error in doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users?error=updatefailed");
        }
    }
}
