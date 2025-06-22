package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.impl.UserDAOImpl;
import project.demo.coursemanagement.dao.RegisterDAO;
import project.demo.coursemanagement.dao.impl.RegisterDAOImpl;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.UserService;
import project.demo.coursemanagement.entities.Role;

import java.io.IOException;
import java.util.Date;
import java.time.Instant;
import java.util.List;
import java.util.stream.Collectors;


@WebServlet(name = "AdminUserController", urlPatterns = {"/admin/users", "/admin/users/*"})
public class AdminUserController extends HttpServlet {
    private final UserDAO userDAO;
    private final RegisterDAO registerDAO;
    private UserService userService;

    public AdminUserController() {
        this.userDAO = new UserDAOImpl();
        this.registerDAO = new RegisterDAOImpl();
    }

    @Override
    public void init() throws ServletException {
        super.init();
        this.userService = new UserService();
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
            // Handle specific user actions like edit
            String[] pathParts = pathInfo.split("/");

            // The pathInfo for edit is expected to be in the format /edit/{userId}
            if (pathParts.length == 3 && "edit".equals(pathParts[1])) {
                String userIdString = pathParts[2]; // User ID is at index 2 for /edit/{userId}

                try {
                    int userId = Integer.parseInt(userIdString);

                    // Handle GET request for edit page
                    User user = userService.getUserByIdWithRole(userId);
                    if (user != null) {
                        List<Role> roles = userService.getAllRoles(); // Assuming this method exists in UserService
                        request.setAttribute("user", user);
                        request.setAttribute("roles", roles);
                        request.getRequestDispatcher("/WEB-INF/views/edit_user.jsp").forward(request, response);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/user-management?error=User not found"); // Redirect to user management list on error
                    }

                } catch (NumberFormatException e) {
                    // Handle invalid user ID format specifically for the edit action
                    response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Invalid user ID format"); // Redirect to user management list on error
                } catch (Exception e) { // Catch potential exceptions from service/DAO calls
                    response.sendRedirect(request.getContextPath() + "/admin/user-management?error=" + e.getMessage()); // Redirect to user management list on error
                }

            } else if (pathParts.length == 2 && "new".equals(pathParts[1])) {
                // Handle GET request for creating a new user
                String roleName = request.getParameter("role");
                // You might want to validate the roleName here if necessary

                List<Role> roles = userService.getAllRoles(); // Get all roles to populate dropdown
                request.setAttribute("roleName", roleName); // Set the default role
                request.setAttribute("roles", roles);
                request.getRequestDispatcher("/WEB-INF/views/edit_user.jsp").forward(request, response); // Forward to the create/edit user JSP

            } else if (pathParts.length >= 3) { // Handle other actions like /activate or /deactivate (though these should ideally be POST)
                String userIdString = pathParts[1]; // Assuming userId is at index 1 for these old GET patterns
                String action = pathParts[2];

                try {
                    int userId = Integer.parseInt(userIdString); // This might still fail if userIdString is not a number
                    // Redirect any old GET /admin/users/{userId}/action patterns to user management list
                    response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Invalid action or GET request not supported");

                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Invalid user ID format in action URL");
                } catch (Exception e) {
                    response.sendRedirect(request.getContextPath() + "/admin/user-management?error=" + e.getMessage());
                }

            } else { // Handle invalid /admin/users/* patterns with less than 2 parts after /admin/users
                response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Invalid request format");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/admin/user-management"); // Redirect to user management list
            return;
        }

        String[] pathParts = pathInfo.split("/");

        // Check if the request is for /admin/users/update
        if (pathParts.length == 2 && "update".equals(pathParts[1])) {
            try {
                // Extract user data from request parameters
                int userId = Integer.parseInt(request.getParameter("userId"));
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String phone = request.getParameter("phone");
                String roleName = request.getParameter("roleName");
                // Note: isActive is not used since User entity doesn't have this field

                // Call UserService to update the user
                userService.updateUser(userId, username, email, phone, roleName);

                // Redirect back to user management page with success message
                response.sendRedirect(request.getContextPath() + "/admin/user-management?message=User updated successfully");

            } catch (NumberFormatException e) {
                // If userId is not a valid integer
                response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Invalid user ID format for update"); // Redirect to user management list on error
            } catch (Exception e) {
                // Catch exceptions from userService.updateUser (e.g., validation errors, DB errors)
                // Set error message and redirect back to edit page, or user list
                response.sendRedirect(request.getContextPath() + "/admin/user-management?error=" + e.getMessage()); // Redirect to user management list on error
            }

        } else if (pathParts.length == 2 && "create".equals(pathParts[1])) {
            try {
                // Extract user data from request parameters for creation
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password"); // Need a password field in the form for new users
                String firstName = request.getParameter("firstName"); // Assuming these are also needed for creation
                String lastName = request.getParameter("lastName");
                String phone = request.getParameter("phone");
                String roleName = request.getParameter("roleName");
                // isActive is defaulted to true in createUser

                // Call UserService to create the user
                userService.createUser(username, email, password, firstName, lastName, phone, roleName);

                // Redirect back to user management page with success message
                response.sendRedirect(request.getContextPath() + "/admin/user-management?message=User created successfully");

            } catch (IllegalArgumentException e) {
                // Handle validation errors (e.g., missing fields)
                // Forward back to the form with error message and pre-filled values
                request.setAttribute("errorMessage", e.getMessage());
                request.setAttribute("username", request.getParameter("username"));
                request.setAttribute("email", request.getParameter("email"));
                request.setAttribute("firstName", request.getParameter("firstName"));
                request.setAttribute("lastName", request.getParameter("lastName"));
                request.setAttribute("phone", request.getParameter("phone"));
                request.setAttribute("roleName", request.getParameter("roleName"));
                request.setAttribute("roles", userService.getAllRoles()); // Need roles for the dropdown
                request.getRequestDispatcher("/WEB-INF/views/edit_user.jsp").forward(request, response);

            } catch (Exception e) {
                // Catch other exceptions (e.g., duplicate user)
                request.setAttribute("errorMessage", e.getMessage());
                request.setAttribute("username", request.getParameter("username"));
                request.setAttribute("email", request.getParameter("email"));
                request.setAttribute("firstName", request.getParameter("firstName"));
                request.setAttribute("lastName", request.getParameter("lastName"));
                request.setAttribute("phone", request.getParameter("phone"));
                request.setAttribute("roleName", request.getParameter("roleName"));
                request.setAttribute("roles", userService.getAllRoles()); // Need roles for the dropdown
                request.getRequestDispatcher("/WEB-INF/views/edit_user.jsp").forward(request, response);
            }

        } else if (pathParts.length >= 3) { // Handle activate/deactivate which should ideally be POST
            String userIdString = pathParts[1];
            String action = pathParts[2];

            try {
                int userId = Integer.parseInt(userIdString);
                // Reuse the logic from the previous doGet, but it's now in doPost
                if (userDAO.findUserByIdIncludeInactive(userId) != null) { // Check if user exists (active or inactive)
                    switch (action) {
                        case "deactivate":
                            if (registerDAO.updateUserActiveStatus(userId, false)) {
                                // Redirect back to user management page
                                response.sendRedirect(request.getContextPath() + "/admin/user-management?message=User deactivated successfully");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Failed to deactivate user");
                            }
                            break;
                        case "activate":
                            if (registerDAO.updateUserActiveStatus(userId, true)) {
                                // Redirect back to user management page
                                response.sendRedirect(request.getContextPath() + "/admin/user-management?message=User activated successfully");
                            } else {
                                // Added error handling for activation failure
                                response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Failed to activate user");
                            }
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
                response.sendRedirect(request.getContextPath() + "/admin/user-management?error=" + e.getMessage());
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/admin/user-management?error=Invalid POST request");
        }
    }
}