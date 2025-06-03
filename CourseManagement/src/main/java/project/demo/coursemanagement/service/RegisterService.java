package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.RegisterDAO;
import project.demo.coursemanagement.dao.impl.RegisterDAOImpl;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.dto.RegistrationRequest;
import project.demo.coursemanagement.dto.ValidationResult;
import project.demo.coursemanagement.utils.PasswordUtil;
import project.demo.coursemanagement.utils.ValidationUtil;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for handling user registration business logic
 */
public class RegisterService {

    private RegisterDAO registerDAO;

    public RegisterService() {
        this.registerDAO = new RegisterDAOImpl();
    }

    /**
     * Constructor with dependency injection for testing
     */
    public RegisterService(RegisterDAO registerDAO) {
        this.registerDAO = registerDAO;
    }

    /**
     * Register a new user in the system
     */
    public boolean registerUser(User user) {
        System.out.println("RegisterService: Starting user registration for: " + user.getUsername());

        try {
            // Validate user object
            if (user == null) {
                System.err.println("RegisterService: User object is null");
                return false;
            }
            // Set creation timestamp
            if (user.getCreatedAt() == null) {
                user.setCreatedAt(Instant.now());
            }
            if (user.getUpdatedAt() == null) {
                user.setUpdatedAt(Instant.now());
            }

            // Log registration attempt
            System.out.println("RegisterService: Attempting to create user - " +
                    "Username: " + user.getUsername() +
                    ", Email: " + user.getEmail() +
                    ", Role: " + (user.getRole() != null ? user.getRole().getRoleName() : "null"));

            // Create user in database
            boolean success = registerDAO.createUser(user);

            if (success) {
                System.out.println("RegisterService: User registration successful for: " + user.getUsername());

                // Log registration event (could be stored in audit table)
                logRegistrationEvent(user, "SUCCESS", "User registered successfully");

            } else {
                System.err.println("RegisterService: User registration failed for: " + user.getUsername());
                logRegistrationEvent(user, "FAILURE", "Database operation failed");
            }

            return success;

        } catch (Exception e) {
            System.err.println("RegisterService: Error during registration: " + e.getMessage());
            e.printStackTrace();

            // Log error event
            logRegistrationEvent(user, "ERROR", "Exception: " + e.getMessage());

            return false;
        }
    }

    /**
     * Check for duplicate username or email
     */
    public ValidationResult checkDuplicates(RegistrationRequest request) {
        System.out.println("RegisterService: Checking duplicates for username: " + request.getUsername() +
                ", email: " + request.getEmail());

        List<String> errors = new ArrayList<>();

        try {
            // Check username uniqueness
            if (registerDAO.isUsernameExists(request.getUsername())) {
                String error = "Username '" + request.getUsername() + "' is already taken";
                errors.add(error);
                System.out.println("RegisterService: " + error);
            }

            // Check email uniqueness
            if (registerDAO.isEmailExists(request.getEmail())) {
                String error = "Email '" + request.getEmail() + "' is already registered";
                errors.add(error);
                System.out.println("RegisterService: " + error);
            }

            boolean isValid = errors.isEmpty();
            ValidationResult result = new ValidationResult(isValid, errors);

            System.out.println("RegisterService: Duplicate check completed - Valid: " + isValid);
            return result;

        } catch (Exception e) {
            System.err.println("RegisterService: Error checking duplicates: " + e.getMessage());
            e.printStackTrace();

            errors.add("Unable to verify username and email availability. Please try again.");
            return new ValidationResult(false, errors);
        }
    }

    /**
     * Hash password using secure algorithm
     */
    public String hashPassword(String plainPassword) {
        System.out.println("RegisterService: Hashing password");

        if (plainPassword == null || plainPassword.isEmpty()) {
            System.err.println("RegisterService: Plain password is null or empty");
            return null;
        }

        try {
            String hashedPassword = PasswordUtil.hashPassword(plainPassword);
            System.out.println("RegisterService: Password hashed successfully");
            return hashedPassword;

        } catch (Exception e) {
            System.err.println("RegisterService: Error hashing password: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Validate registration request with business rules
     */
    public ValidationResult validateRegistrationRequest(RegistrationRequest request) {
        System.out.println("RegisterService: Validating registration request for: " + request.getUsername());

        // First, run standard validation
        ValidationResult standardValidation = ValidationUtil.validateRegistration(request);

        // Then, run business-specific validation
        ValidationResult businessValidation = validateBusinessRules(request);

        // Combine results
        ValidationResult combinedResult = ValidationResult.combine(standardValidation, businessValidation);

        System.out.println("RegisterService: Validation completed - Valid: " + combinedResult.isValid() +
                ", Errors: " + combinedResult.getErrorCount());

        return combinedResult;
    }

    /**
     * Apply business-specific validation rules
     */
    private ValidationResult validateBusinessRules(RegistrationRequest request) {
        List<String> errors = new ArrayList<>();
        List<String> warnings = new ArrayList<>();

        // Business rule: Check if registration is allowed for this role
        if (!isRoleRegistrationAllowed(request.getRole())) {
            errors.add("Registration is not currently available for " + request.getRole() + " role");
        }

        // Business rule: Check domain restrictions for teacher registration
        if ("TEACHER".equalsIgnoreCase(request.getRole())) {
            if (!isValidTeacherEmail(request.getEmail())) {
                warnings.add("Teacher registrations with personal email addresses require approval");
            }
        }

        // Business rule: Rate limiting check (simulation)
        if (isRateLimited(request)) {
            errors.add("Too many registration attempts. Please try again later");
        }

        ValidationResult result = new ValidationResult(errors.isEmpty(), errors);
        result.addWarnings(warnings);

        return result;
    }

    /**
     * Check if role registration is currently allowed
     */
    private boolean isRoleRegistrationAllowed(String role) {
        // Business logic: Only allow USER and TEACHER self-registration
        // ADMIN and GUEST roles should not be available for self-registration

        if (role == null) {
            return true; // Default to USER role
        }

        switch (role.toUpperCase()) {
            case "USER":
            case "TEACHER":
                return true;
            case "ADMIN":
            case "GUEST":
                return false; // These roles require admin approval
            default:
                return false; // Unknown roles not allowed
        }
    }

    /**
     * Validate teacher email domain
     */
    private boolean isValidTeacherEmail(String email) {
        if (email == null) {
            return false;
        }

        // Business rule: Prefer institutional email domains for teachers
        String[] institutionalDomains = {
                "edu", "edu.vn", "university.edu", "college.edu", "school.edu"
        };

        String emailLower = email.toLowerCase();
        for (String domain : institutionalDomains) {
            if (emailLower.endsWith("." + domain)) {
                return true;
            }
        }

        // Personal email domains are allowed but generate warnings
        return true;
    }

    /**
     * Check for suspicious registration patterns
     */


    /**
     * Check if registration is rate limited
     */
    private boolean isRateLimited(RegistrationRequest request) {
        // Business rule: Simulate rate limiting
        // In real implementation, this would check against a cache/database
        // to track registration attempts per IP/email

        // For demo purposes, always return false (no rate limiting)
        return false;
    }

    /**
     * Send welcome email to newly registered user
     */
    public void sendWelcomeEmail(User user) {
        System.out.println("RegisterService: Sending welcome email to: " + user.getEmail());

        try {
            // In a real implementation, this would use an email service
            // For now, we'll just log the action

            String emailContent = generateWelcomeEmailContent(user);
            System.out.println("RegisterService: Welcome email content generated for: " + user.getUsername());

            // Simulate email sending
            boolean emailSent = simulateEmailSending(user.getEmail(), "Welcome to Course Management System", emailContent);

            if (emailSent) {
                System.out.println("RegisterService: Welcome email sent successfully to: " + user.getEmail());
            } else {
                System.err.println("RegisterService: Failed to send welcome email to: " + user.getEmail());
            }

        } catch (Exception e) {
            System.err.println("RegisterService: Error sending welcome email: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Generate welcome email content based on user role
    private String generateWelcomeEmailContent(User user) {
        StringBuilder content = new StringBuilder();

        content.append("Dear ").append(user.getFirstName()).append(" ").append(user.getLastName()).append(",\n\n");
        content.append("Welcome to Course Management System!\n\n");
        content.append("Your account has been successfully created with the following details:\n");
        content.append("Username: ").append(user.getUsername()).append("\n");
        content.append("Email: ").append(user.getEmail()).append("\n");
        content.append("Role: ").append(user.getRole().getRoleName()).append("\n\n");

        if ("TEACHER".equals(user.getRole().getRoleName())) {
            content.append("As a teacher, you can now:\n");
            content.append("- Create and manage courses\n");
            content.append("- Upload course materials\n");
            content.append("- Track student progress\n");
            content.append("- Manage assignments and grades\n\n");
        } else {
            content.append("As a student, you can now:\n");
            content.append("- Browse and enroll in courses\n");
            content.append("- Access course materials\n");
            content.append("- Submit assignments\n");
            content.append("- Track your learning progress\n\n");
        }

        content.append("To get started, please log in to your account and explore the available features.\n\n");
        content.append("If you have any questions, please don't hesitate to contact our support team.\n\n");
        content.append("Best regards,\n");
        content.append("Course Management System Team");

        return content.toString();
    }

    // Simulate email sending (for demo purposes)
    private boolean simulateEmailSending(String to, String subject, String content) {


        System.out.println("=== EMAIL SIMULATION ===");
        System.out.println("To: " + to);
        System.out.println("Subject: " + subject);
        System.out.println("Content Length: " + content.length() + " characters");
        System.out.println("Status: SENT");
        System.out.println("========================");

        return true;
    }


    private void logRegistrationEvent(User user, String status, String message) {
        try {
            // In real implementation, this would write to an audit log table
            System.out.println("AUDIT LOG: Registration Event");
            System.out.println("  Timestamp: " + Instant.now());
            System.out.println("  Username: " + (user != null ? user.getUsername() : "null"));
            System.out.println("  Email: " + (user != null ? user.getEmail() : "null"));
            System.out.println("  Status: " + status);
            System.out.println("  Message: " + message);

        } catch (Exception e) {
            System.err.println("RegisterService: Error logging registration event: " + e.getMessage());
        }
    }

    /**
     * Get registration statistics (for admin dashboard)
     */
    public RegistrationStatistics getRegistrationStatistics() {
        try {
            // In real implementation, this would query the database for statistics
            return new RegistrationStatistics();

        } catch (Exception e) {
            System.err.println("RegisterService: Error getting registration statistics: " + e.getMessage());
            return new RegistrationStatistics();
        }
    }

    /**
     * Check if a username is available
     */
    public boolean isUsernameAvailable(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }

        try {
            // First check format validity
            if (!ValidationUtil.isValidUsername(username)) {
                return false;
            }

            // Then check database uniqueness
            return !registerDAO.isUsernameExists(username.trim());

        } catch (Exception e) {
            System.err.println("RegisterService: Error checking username availability: " + e.getMessage());
            return false;
        }
    }

    /**
     * Check if an email is available
     */
    public boolean isEmailAvailable(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        try {
            // First check format validity
            if (!ValidationUtil.isValidEmail(email)) {
                return false;
            }

            // Then check database uniqueness
            return !registerDAO.isEmailExists(email.trim().toLowerCase());

        } catch (Exception e) {
            System.err.println("RegisterService: Error checking email availability: " + e.getMessage());
            return false;
        }
    }

    /**
     * Inner class for registration statistics
     */
    public static class RegistrationStatistics {
        private int totalRegistrations;
        private int todayRegistrations;
        private int weeklyRegistrations;
        private int studentRegistrations;
        private int teacherRegistrations;

        public RegistrationStatistics() {
            // Mock data - replace with real database queries
            this.totalRegistrations = 1250;
            this.todayRegistrations = 15;
            this.weeklyRegistrations = 87;
            this.studentRegistrations = 1100;
            this.teacherRegistrations = 45;
        }

        // Getters and setters
        public int getTotalRegistrations() { return totalRegistrations; }
        public void setTotalRegistrations(int totalRegistrations) { this.totalRegistrations = totalRegistrations; }

        public int getTodayRegistrations() { return todayRegistrations; }
        public void setTodayRegistrations(int todayRegistrations) { this.todayRegistrations = todayRegistrations; }

        public int getWeeklyRegistrations() { return weeklyRegistrations; }
        public void setWeeklyRegistrations(int weeklyRegistrations) { this.weeklyRegistrations = weeklyRegistrations; }

        public int getStudentRegistrations() { return studentRegistrations; }
        public void setStudentRegistrations(int studentRegistrations) { this.studentRegistrations = studentRegistrations; }

        public int getTeacherRegistrations() { return teacherRegistrations; }
        public void setTeacherRegistrations(int teacherRegistrations) { this.teacherRegistrations = teacherRegistrations; }
    }
}
