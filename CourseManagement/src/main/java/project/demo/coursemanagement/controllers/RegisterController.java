package project.demo.coursemanagement.controllers
        ;

import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.RegisterService;
import project.demo.coursemanagement.utils.SessionUtil;
import project.demo.coursemanagement.utils.ValidationUtil;
import project.demo.coursemanagement.dto.RegistrationRequest;
import project.demo.coursemanagement.dto.ValidationResult;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 * Servlet for handling user registration
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    private RegisterService registerService;

    @Override
    public void init() throws ServletException {
        super.init();
        registerService = new RegisterService();
        System.out.println("RegisterServlet initialized");
    }

    /**
     * Handle GET requests - Show registration form
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("RegisterServlet GET request received");

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

        // Set default role options for form
        setRoleOptions(request);

        // Forward to registration page
        request.getRequestDispatcher("/WEB-INF/views/login_register/register.jsp").forward(request, response);
    }

    /**
     * Handle POST requests - Process registration
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("RegisterServlet POST request received");

        // Check if user is already logged in
        if (SessionUtil.isUserLoggedIn(request)) {
            redirectToDashboard(request, response);
            return;
        }

        try {
            // Create registration request from form data
            RegistrationRequest registrationRequest = createRegistrationRequest(request);

            // Log registration attempt
            System.out.println("Registration attempt for username: " + registrationRequest.getUsername() +
                    ", email: " + registrationRequest.getEmail());

            // Validate registration data
            ValidationResult validationResult = ValidationUtil.validateRegistration(registrationRequest);

            if (!validationResult.isValid()) {
                // Validation failed
                System.out.println("Registration validation failed: " + validationResult.getErrors());
                handleRegistrationError(request, response, validationResult.getErrors(), registrationRequest);
                return;
            }

            // Check for existing username/email
            ValidationResult duplicateCheck = registerService.checkDuplicates(registrationRequest);
            if (!duplicateCheck.isValid()) {
                System.out.println("Duplicate check failed: " + duplicateCheck.getErrors());
                handleRegistrationError(request, response, duplicateCheck.getErrors(), registrationRequest);
                return;
            }

            // Create user entity
            User user = createUserFromRequest(registrationRequest);

            // Get selected role
            Integer roleId = 1; // Default to Student role (ID 1)
            try {
                if (registrationRequest.getRole() != null && !registrationRequest.getRole().isEmpty()) {
                    roleId = Integer.parseInt(registrationRequest.getRole());
                    System.out.println("Selected role ID: " + roleId);
                }
            } catch (NumberFormatException e) {
                // Handle legacy role names
                String roleName = registrationRequest.getRole();
                if ("TEACHER".equalsIgnoreCase(roleName)) {
                    roleId = 2; // Teacher role ID
                }
                System.out.println("Converted role name '" + roleName + "' to role ID: " + roleId);
            }

            // Register user with the selected role
            boolean registrationSuccess = registerService.registerUser(user, roleId);

            if (registrationSuccess) {
                // Registration successful
                System.out.println("Registration successful for user: " + user.getUsername());

                // Send welcome email (optional)
                try {
                    registerService.sendWelcomeEmail(user, roleId);
                } catch (Exception e) {
                    System.err.println("Failed to send welcome email: " + e.getMessage());
                    // Don't fail registration if email fails
                }

                // Set success message
                SessionUtil.setFlashMessage(request, "success",
                        "Registration successful! Please log in with your credentials.");

                // Redirect to login page
                response.sendRedirect(request.getContextPath() + "/login");

            } else {
                // Registration failed
                System.out.println("Registration failed for user: " + registrationRequest.getUsername());
                handleRegistrationError(request, response,
                        java.util.Arrays.asList("Registration failed. Please try again."),
                        registrationRequest);
            }

        } catch (Exception e) {
            // Handle unexpected errors
            System.err.println("Error during registration: " + e.getMessage());
            e.printStackTrace();

            handleRegistrationError(request, response,
                    java.util.Arrays.asList("An unexpected error occurred. Please try again."),
                    null);
        }
    }

    /**
     * Create registration request from form parameters
     */
    private RegistrationRequest createRegistrationRequest(HttpServletRequest request) {
        RegistrationRequest registrationRequest = new RegistrationRequest();

        // Required fields
        registrationRequest.setUsername(getParameter(request, "username"));
        registrationRequest.setEmail(getParameter(request, "email"));
        registrationRequest.setPassword(getParameter(request, "password"));
        registrationRequest.setConfirmPassword(getParameter(request, "confirmPassword"));
        registrationRequest.setFirstName(getParameter(request, "firstName"));
        registrationRequest.setLastName(getParameter(request, "lastName"));

        // Optional fields
        registrationRequest.setPhoneNumber(getParameter(request, "phoneNumber"));
        registrationRequest.setDateOfBirth(getParameter(request, "dateOfBirth"));
        registrationRequest.setRole(getParameter(request, "role"));

        // Checkbox fields
        registrationRequest.setAgreeToTerms("on".equals(request.getParameter("agreeToTerms")));
        registrationRequest.setSubscribeNewsletter("on".equals(request.getParameter("subscribeNewsletter")));

        return registrationRequest;
    }

    /**
     * Create User entity from registration request
     */
    private User createUserFromRequest(RegistrationRequest registrationRequest) {
        User user = new User();

        // Set basic information
        user.setUsername(registrationRequest.getUsername());
        user.setEmail(registrationRequest.getEmail());
        user.setPasswordHash(registerService.hashPassword(registrationRequest.getPassword()));
        user.setFirstName(registrationRequest.getFirstName());
        user.setLastName(registrationRequest.getLastName());
        user.setPhoneNumber(registrationRequest.getPhoneNumber());

        // Parse date of birth
        if (registrationRequest.getDateOfBirth() != null && !registrationRequest.getDateOfBirth().trim().isEmpty()) {
            try {
                LocalDate dateOfBirth = LocalDate.parse(registrationRequest.getDateOfBirth(),
                        DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                user.setDateOfBirth(dateOfBirth);
            } catch (DateTimeParseException e) {
                System.err.println("Invalid date format: " + registrationRequest.getDateOfBirth());
                // Leave dateOfBirth as null if parsing fails
            }
        }

        // Note: Role is now assigned after user creation via UserRoleDAO

        return user;
    }

    /**
     * Handle registration errors
     */
    private void handleRegistrationError(HttpServletRequest request, HttpServletResponse response,
                                         java.util.List<String> errors,
                                         RegistrationRequest registrationRequest)
            throws ServletException, IOException {

        // Set error messages
        request.setAttribute("messageType", "danger");
        request.setAttribute("errors", errors);

        // Preserve form data (except passwords)
        if (registrationRequest != null) {
            request.setAttribute("formData", registrationRequest);
            // Clear passwords for security
            registrationRequest.setPassword("");
            registrationRequest.setConfirmPassword("");
        }

        // Set role options
        setRoleOptions(request);

        // Forward back to registration page
        request.getRequestDispatcher("/WEB-INF/views/login_register/register.jsp").forward(request, response);
    }

    /**
     * Set role options for the form
     */
    private void setRoleOptions(HttpServletRequest request) {
        // Only allow Student (1) and Teacher (2) for self-registration
        java.util.Map<String, String> roleOptions = new java.util.LinkedHashMap<>();
        roleOptions.put("1", "Student");
        roleOptions.put("2", "Teacher");
        request.setAttribute("roleOptions", roleOptions);
    }

    /**
     * Redirect to appropriate dashboard based on user role
     */
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
                        response.sendRedirect(contextPath + "/teacher/dashboard");
                        break;
                    case 1: // Student
                        response.sendRedirect(contextPath + "/student-dashboard");
                        break;
                    case 3: // CourseManager
                        response.sendRedirect(contextPath + "/course-manager/dashboard");
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
            response.sendRedirect(contextPath + "/student-dashboard");
        }
    }

    /**
     * Get parameter and trim whitespace
     */
    private String getParameter(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        return (value != null) ? value.trim() : null;
    }

    /**
     * Validate required parameters
     */
    private boolean hasRequiredParameters(RegistrationRequest request) {
        return request.getUsername() != null && !request.getUsername().isEmpty() &&
                request.getEmail() != null && !request.getEmail().isEmpty() &&
                request.getPassword() != null && !request.getPassword().isEmpty() &&
                request.getConfirmPassword() != null && !request.getConfirmPassword().isEmpty() &&
                request.getFirstName() != null && !request.getFirstName().isEmpty() &&
                request.getLastName() != null && !request.getLastName().isEmpty();
    }

    @Override
    public void destroy() {
        super.destroy();
        System.out.println("RegisterServlet destroyed");
    }
}
