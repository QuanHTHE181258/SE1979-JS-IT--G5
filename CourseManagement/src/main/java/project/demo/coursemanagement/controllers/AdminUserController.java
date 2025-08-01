package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.UserService;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.utils.SessionUtil;

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

        System.out.println("[CONTROLLER] GET request: pathInfo=" + pathInfo + ", searchTerm=" + searchTerm);

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                List<User> students = userService.getUsers(null, "STUDENT", 1);
                List<User> teachers = userService.getUsers(null, "TEACHER", 1);
                List<User> courseManagers = userService.getUsers(null, "Course Manager", 1);
                List<User> userManagers = userService.getUsers(null, "UserManager", 1);

                long blockedStudents = students.stream().filter(User::isBlocked).count();
                long blockedTeachers = teachers.stream().filter(User::isBlocked).count();
                long blockedManagers = courseManagers.stream().filter(User::isBlocked).count();
                long blockedUserManagers = userManagers.stream().filter(User::isBlocked).count();

                System.out.println("[CONTROLLER] Students: total=" + students.size() + ", blocked=" + blockedStudents);
                students.forEach(u -> System.out.println("[CONTROLLER] Student: ID=" + u.getId() + ", Username=" + u.getUsername() + ", Blocked=" + u.isBlocked()));
                System.out.println("[CONTROLLER] Teachers: total=" + teachers.size() + ", blocked=" + blockedTeachers);
                teachers.forEach(u -> System.out.println("[CONTROLLER] Teacher: ID=" + u.getId() + ", Username=" + u.getUsername() + ", Blocked=" + u.isBlocked()));
                System.out.println("[CONTROLLER] CourseManagers: total=" + courseManagers.size() + ", blocked=" + blockedManagers);
                courseManagers.forEach(u -> System.out.println("[CONTROLLER] Manager: ID=" + u.getId() + ", Username=" + u.getUsername() + ", Blocked=" + u.isBlocked()));
                System.out.println("[CONTROLLER] UserManagers: total=" + userManagers.size() + ", blocked=" + blockedUserManagers);
                userManagers.forEach(u -> System.out.println("[CONTROLLER] UserManager: ID=" + u.getId() + ", Username=" + u.getUsername() + ", Blocked=" + u.isBlocked()));

                request.setAttribute("students", students);
                request.setAttribute("teachers", teachers);
                request.setAttribute("courseManagers", courseManagers);
                request.setAttribute("userManagers", userManagers);

                // Get current user's role for UI control
                String userRole = SessionUtil.getUserRole(request);
                request.setAttribute("isAdmin", "5".equals(userRole)); // Role 5 is Admin

                request.getRequestDispatcher("/WEB-INF/views/user_list.jsp").forward(request, response);
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

        } else if (pathParts.length == 2 && "block".equals(pathParts[1])) {
            System.out.println("[BLOCK USER] POST /admin/users/block");
            try {
                String idParam = request.getParameter("id");
                System.out.println("Block request for userId param: " + idParam);
                int userId = Integer.parseInt(idParam);
                boolean success = userService.blockUser(userId);
                System.out.println("Block result: " + success);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?message=User blocked successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/users?error=Block user failed");
                }
            } catch (Exception e) {
                System.out.println("Exception in block: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/users?error=Block user error");
            }
        } else if (pathParts.length == 2 && "unblock".equals(pathParts[1])) {
            System.out.println("[UNBLOCK USER] POST /admin/users/unblock");
            try {
                String idParam = request.getParameter("id");
                System.out.println("Unblock request for userId param: " + idParam);
                int userId = Integer.parseInt(idParam);
                boolean success = userService.unblockUser(userId);
                System.out.println("Unblock result: " + success);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?message=User unblocked successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/users?error=Unblock user failed");
                }
            } catch (Exception e) {
                System.out.println("Exception in unblock: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/users?error=Unblock user error");
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
