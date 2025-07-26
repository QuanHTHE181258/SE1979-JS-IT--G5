package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
    private UserService userService;

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

        System.out.println("=== AdminUserController GET request ===");
        System.out.println("Path info: " + pathInfo);
        System.out.println("Search term: " + searchTerm);

        try {
            // Handle root path /admin/users
            if (pathInfo == null || pathInfo.equals("/")) {
                System.out.println("Handling root path");
                List<User> userList;
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    System.out.println("Searching users with term: " + searchTerm);
                    userList = userService.getUsers(searchTerm, null, 1);
                } else {
                    System.out.println("Getting all users");
                    userList = userService.getAllUsers();
                }

                System.out.println("Found " + userList.size() + " users");
                request.setAttribute("userList", userList);
                request.setAttribute("searchTerm", searchTerm);
                request.getRequestDispatcher("/WEB-INF/views/admin_users.jsp").forward(request, response);
                return;
            }

            // Handle /admin/users/new for user creation form
            if (pathInfo.equals("/new")) {
                String role = request.getParameter("role");
                System.out.println("Showing creation form for role: " + role);

                if ("USER_MANAGER".equals(role)) {
                    request.getRequestDispatcher("/WEB-INF/views/create_user_manager.jsp").forward(request, response);
                } else {
                    List<Role> roles = userService.getAllRoles();
                    request.setAttribute("roles", roles);
                    request.getRequestDispatcher("/WEB-INF/views/create_user.jsp").forward(request, response);
                }
                return;
            }

            // Handle /admin/users/edit/{id} for edit form
            if (pathInfo.startsWith("/edit/")) {
                String idStr = pathInfo.substring("/edit/".length());
                System.out.println("Editing user with ID: " + idStr);

                try {
                    int userId = Integer.parseInt(idStr);
                    User user = userService.findUserById(userId);
                    if (user != null) {
                        request.setAttribute("user", user);
                        request.getRequestDispatcher("/WEB-INF/views/edit_user.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Invalid user ID format: " + e.getMessage());
                }
            }

            // If no valid pattern is matched
            System.err.println("Invalid request pattern: " + pathInfo);
            response.sendRedirect(request.getContextPath() + "/admin/users?error=Invalid request format");

        } catch (Exception e) {
            System.err.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/users?error=Internal server error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/admin/users"); // Redirect to user management list
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
                boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

                // Call UserService to update the user
                userService.updateUser(userId, username, email, phone, roleName);

                // Redirect back to user management page with success message
                response.sendRedirect(request.getContextPath() + "/admin/users?message=User updated successfully");

            } catch (NumberFormatException e) {
                // Nếu userId không hợp lệ, forward lại form chỉnh sửa với thông báo lỗi
                request.setAttribute("errorMessage", "User ID không hợp lệ.");
                int userId = -1;
                try { userId = Integer.parseInt(request.getParameter("userId")); } catch (Exception ex) {}
                User user = userService.getUserById(userId);
                List<Role> roles = userService.getAllRoles();
                request.setAttribute("user", user);
                request.setAttribute("roles", roles);
                request.getRequestDispatcher("/WEB-INF/views/edit_user.jsp").forward(request, response);
            } catch (Exception e) {
                // Nếu lỗi khi update, forward lại form chỉnh sửa với thông báo lỗi
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật user.");
                int userId = -1;
                try { userId = Integer.parseInt(request.getParameter("userId")); } catch (Exception ex) {}
                User user = userService.getUserById(userId);
                List<Role> roles = userService.getAllRoles();
                request.setAttribute("user", user);
                request.setAttribute("roles", roles);
                request.getRequestDispatcher("/WEB-INF/views/edit_user.jsp").forward(request, response);
            }

        } else if (pathParts.length == 2 && "create".equals(pathParts[1])) {
            try {
                System.out.println("=== Starting user creation process ===");

                // Extract user data from request parameters for creation
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String phone = request.getParameter("phone");
                String roleName = request.getParameter("roleName");

                System.out.println("Received parameters:");
                System.out.println("- Username: " + username);
                System.out.println("- Email: " + email);
                System.out.println("- FirstName: " + firstName);
                System.out.println("- LastName: " + lastName);
                System.out.println("- Phone: " + phone);
                System.out.println("- Role: " + roleName);

                // Call UserService to create the user
                System.out.println("Calling UserService.createUser...");
                userService.createUser(username, email, password, firstName, lastName, phone, roleName);
                System.out.println("User created successfully!");

                // Redirect back to user management page with success message
                String redirectUrl = request.getContextPath() + "/admin/users?message=User created successfully";
                System.out.println("Redirecting to: " + redirectUrl);
                response.sendRedirect(redirectUrl);
                System.out.println("=== User creation process completed ===");

            } catch (IllegalArgumentException e) {
                System.err.println("Validation error during user creation: " + e.getMessage());
                e.printStackTrace();
                // Handle validation errors (e.g., missing fields)
                // Forward back to the form with error message and pre-filled values
                request.setAttribute("errorMessage", e.getMessage());
                request.setAttribute("username", request.getParameter("username"));
                request.setAttribute("email", request.getParameter("email"));
                request.setAttribute("firstName", request.getParameter("firstName"));
                request.setAttribute("lastName", request.getParameter("lastName"));
                request.setAttribute("phone", request.getParameter("phone"));
                request.setAttribute("roleName", request.getParameter("roleName"));

                if ("USER_MANAGER".equals(request.getParameter("roleName"))) {
                    request.getRequestDispatcher("/WEB-INF/views/create_user_manager.jsp").forward(request, response);
                } else {
                    request.setAttribute("roles", userService.getAllRoles()); // Need roles for the dropdown
                    request.getRequestDispatcher("/WEB-INF/views/edit_user.jsp").forward(request, response);
                }

            } catch (Exception e) {
                System.err.println("Error during user creation: " + e.getMessage());
                e.printStackTrace();
                // Catch other exceptions (e.g., duplicate user)
                request.setAttribute("errorMessage", e.getMessage());
                request.setAttribute("username", request.getParameter("username"));
                request.setAttribute("email", request.getParameter("email"));
                request.setAttribute("firstName", request.getParameter("firstName"));
                request.setAttribute("lastName", request.getParameter("lastName"));
                request.setAttribute("phone", request.getParameter("phone"));
                request.setAttribute("roleName", request.getParameter("roleName"));

                if ("USER_MANAGER".equals(request.getParameter("roleName"))) {
                    request.getRequestDispatcher("/WEB-INF/views/create_user_manager.jsp").forward(request, response);
                } else {
                    request.setAttribute("roles", userService.getAllRoles()); // Need roles for the dropdown
                    request.getRequestDispatcher("/WEB-INF/views/edit_user.jsp").forward(request, response);
                }
            }

        } else if (pathParts.length >= 3) { // Handle activate/deactivate which should ideally be POST
            String userIdString = pathParts[1];
            String action = pathParts[2];

            try {
                int userId = Integer.parseInt(userIdString);
                // Reuse the logic from the previous doGet, but it's now in doPost
                if (userService.findUserByIdIncludeInactive(userId) != null) { // Check if user exists (active or inactive)
                    switch (action) {
                        case "deactivate":
                            if (userService.updateUserActiveStatus(userId, false)) {
                                // Redirect back to user management page
                                response.sendRedirect(request.getContextPath() + "/admin/users?message=User deactivated successfully");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/admin/users?error=Failed to deactivate user");
                            }
                            break;
                        case "activate":
                            if (userService.updateUserActiveStatus(userId, true)) {
                                // Redirect back to user management page
                                response.sendRedirect(request.getContextPath() + "/admin/users?message=User activated successfully");
                            } else {
                                // Added error handling for activation failure
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
                response.sendRedirect(request.getContextPath() + "/admin/users?error=Invalid user ID format");
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=edit_fail");
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users?error=Invalid POST request");
        }
    }
}
