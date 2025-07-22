package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.UserService;
import project.demo.coursemanagement.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet for handling user login
 */

//Test account: admin / admin123
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
        System.out.println("LoginServlet initialized");
    }

    //Get request to display login page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("LoginServlet GET request received");

        // Check if user is already logged in
        if (SessionUtil.isUserLoggedIn(request)) {
            System.out.println("User already logged in, redirecting to dashboard");
            redirectToDashboard(request, response);
            return;
        }

        // Get any flash messages
        String flashMessage = SessionUtil.getAndClearFlashMessage(request);
        if (flashMessage != null) {
            String[] parts = flashMessage.split(":", 2);
            if (parts.length == 2) {
                request.setAttribute("messageType", parts[0]);
                request.setAttribute("message", parts[1]);
            }
        }

        // Forward to login page
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    //Post request to handle login form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("LoginServlet POST request received");

        String identifier = request.getParameter("identifier"); // username or email
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Basic validation
        if (identifier == null || identifier.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {

            handleLoginError(request, response, "Please enter both username/email and password");
            return;
        }

        identifier = identifier.trim();

        System.out.println("Login attempt for: " + identifier);

        try {
            // Authenticate user
            User user = userService.authenticate(identifier, password);

            if (user != null) {
                // Login successful
                System.out.println("Login successful for user: " + user.getUsername());
                // Create user session
                SessionUtil.setUserSession(request, user);
                // Handle "Remember Me" functionality (optional)
                if ("on".equals(rememberMe)) {
                    // Can implement remember me cookies here
                    System.out.println("Remember me requested for: " + user.getUsername());
                }
                // Set success message
                SessionUtil.setFlashMessage(request, "success", "Welcome back, " + user.getFirstName() + user.getLastName() + "!");
                // Redirect to dashboard
                redirectToDashboard(request, response);

            } else {
                // Login failed
                System.out.println("Login failed for: " + identifier);
                handleLoginError(request, response, "Invalid username/email or password");
            }

        } catch (Exception e) {
            // Handle unexpected errors
            System.err.println("Login error: " + e.getMessage());
            e.printStackTrace();
            handleLoginError(request, response, "An error occurred during login. Please try again.");
        }
    }

    // Handle login errors and forward back to login page
    private void handleLoginError(HttpServletRequest request, HttpServletResponse response,
                                  String errorMessage) throws ServletException, IOException {

        System.out.println("Login error: " + errorMessage);

        // Set error message
        request.setAttribute("messageType", "error");
        request.setAttribute("message", errorMessage);

        // Preserve the entered identifier
        String identifier = request.getParameter("identifier");
        if (identifier != null) {
            request.setAttribute("identifier", identifier.trim());
        }

        // Forward back to login page
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    // Redirect to the appropriate dashboard based on user role
    private void redirectToDashboard(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String contextPath = request.getContextPath();
        String userRole = SessionUtil.getUserRole(request);

        if (userRole != null) {
            try {
                // Try to parse as role ID
                int roleId = Integer.parseInt(userRole);
                switch (roleId) {
                    case 5: // Admin
                        response.sendRedirect(contextPath + "/admin/dashboard");
                        break;
                    case 2: // Teacher
                        response.sendRedirect(contextPath + "/teaching-courses");
                        break;
                    case 1: // Student
                        response.sendRedirect(contextPath + "/student-dashboard");
                        break;
                    case 3: // CourseManager
                        response.sendRedirect(contextPath + "/view-all");
                        break;
                    case 4: // UserManager
                        response.sendRedirect(contextPath + "/user-manager/dashboard");
                        break;
                    case 0: // Guest
                    default:
                        response.sendRedirect(contextPath + "/student-dashboard");
                        break;
                }
            } catch (NumberFormatException e) {
                // For backward compatibility, handle role names
                switch (userRole) {
                    case "ADMIN":
                        response.sendRedirect(contextPath + "/admin/dashboard");
                        break;
                    case "TEACHER":
                        response.sendRedirect(contextPath + "/teacher/dashboard");
                        break;
                    case "USER":
                    case "STUDENT":
                        response.sendRedirect(contextPath + "/student-dashboard");
                        break;
                    default:
                        response.sendRedirect(contextPath + "/student-dashboard");
                        break;
                }
            }
        } else {
            // Fallback to general dashboard
            response.sendRedirect(contextPath + "/student-dashboard");
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        System.out.println("LoginServlet destroyed");
    }
}
