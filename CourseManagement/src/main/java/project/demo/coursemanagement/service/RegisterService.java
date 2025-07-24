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
        return registerUser(user, 1); // Default to Student role (ID 1)
    }

    /**
     * Register a new user in the system with a specific role
     */
    public boolean registerUser(User user, Integer roleId) {
        System.out.println("[DEBUG_LOG] RegisterService.registerUser: Starting user registration transaction");
        System.out.println("[DEBUG_LOG] RegisterService.registerUser: User details - Username: " + (user != null ? user.getUsername() : "null") + 
                          ", Email: " + (user != null ? user.getEmail() : "null") +
                          ", Role ID: " + roleId);

        try {
            // Validate user object
            if (user == null) {
                System.err.println("[DEBUG_LOG] RegisterService.registerUser: Transaction failed - User object is null");
                return false;
            }
            // Set creation timestamp
            if (user.getCreatedAt() == null) {
                user.setCreatedAt(Instant.now());
                System.out.println("[DEBUG_LOG] RegisterService.registerUser: Transaction detail - Setting creation timestamp: " + user.getCreatedAt());
            }

            // Log registration attempt
            System.out.println("[DEBUG_LOG] RegisterService.registerUser: Transaction in progress - Creating user in database");
            System.out.println("[DEBUG_LOG] RegisterService.registerUser: Transaction data - " +
                    "Username: " + user.getUsername() +
                    ", Email: " + user.getEmail() +
                    ", Role ID: " + roleId);

            // Create user in database
            boolean success = registerDAO.createUser(user);

            // Assign the specified role to the user
            boolean rolesAssigned = false;
            if (success) {
                rolesAssigned = registerDAO.assignRole(user, roleId);
                System.out.println("[DEBUG_LOG] RegisterService.registerUser: Role assignment - " +
                        "User ID: " + user.getId() +
                        ", Role ID: " + roleId +
                        ", Success: " + rolesAssigned);
            }

            if (success) {
                System.out.println("[DEBUG_LOG] RegisterService.registerUser: Transaction successful - User created with ID: " + user.getId());

                // Log registration event (could be stored in audit table)
                logRegistrationEvent(user, "SUCCESS", "User registered successfully with role ID: " + roleId);

            } else {
                System.err.println("[DEBUG_LOG] RegisterService.registerUser: Transaction failed - Database operation returned false");
                logRegistrationEvent(user, "FAILURE", "Database operation failed");
            }

            return success;

        } catch (Exception e) {
            System.err.println("[DEBUG_LOG] RegisterService.registerUser: Transaction error - " + e.getMessage());
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
        System.out.println("[DEBUG_LOG] RegisterService.checkDuplicates: Starting duplicate check transaction");
        System.out.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction data - Username: " + 
                (request != null ? request.getUsername() : "null") + 
                ", Email: " + (request != null ? request.getEmail() : "null"));

        List<String> errors = new ArrayList<>();

        try {
            if (request == null) {
                System.err.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction failed - Request object is null");
                errors.add("Invalid registration request");
                return new ValidationResult(false, errors);
            }

            // Check username uniqueness
            System.out.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction in progress - Checking username uniqueness");
            if (registerDAO.isUsernameExists(request.getUsername())) {
                String error = "Username '" + request.getUsername() + "' is already taken";
                errors.add(error);
                System.out.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction detail - " + error);
            } else {
                System.out.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction detail - Username is available");
            }

            // Check email uniqueness
            System.out.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction in progress - Checking email uniqueness");
            if (registerDAO.isEmailExists(request.getEmail())) {
                String error = "Email '" + request.getEmail() + "' is already registered";
                errors.add(error);
                System.out.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction detail - " + error);
            } else {
                System.out.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction detail - Email is available");
            }

            boolean isValid = errors.isEmpty();
            ValidationResult result = new ValidationResult(isValid, errors);

            System.out.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction completed - Valid: " + isValid + 
                              ", Error count: " + errors.size());
            return result;

        } catch (Exception e) {
            System.err.println("[DEBUG_LOG] RegisterService.checkDuplicates: Transaction error - " + e.getMessage());
            e.printStackTrace();

            errors.add("Unable to verify username and email availability. Please try again.");
            return new ValidationResult(false, errors);
        }
    }

    /**
     * Hash password using secure algorithm
     */
    public String hashPassword(String plainPassword) {
        System.out.println("[DEBUG_LOG] RegisterService.hashPassword: Starting password hashing transaction");

        if (plainPassword == null || plainPassword.isEmpty()) {
            System.err.println("[DEBUG_LOG] RegisterService.hashPassword: Transaction failed - Plain password is null or empty");
            return null;
        }

        System.out.println("[DEBUG_LOG] RegisterService.hashPassword: Transaction in progress - Password length: " + plainPassword.length());

        try {
            String hashedPassword = PasswordUtil.hashPassword(plainPassword);
            System.out.println("[DEBUG_LOG] RegisterService.hashPassword: Transaction successful - Password hashed, hash length: " + 
                              (hashedPassword != null ? hashedPassword.length() : 0));
            return hashedPassword;

        } catch (Exception e) {
            System.err.println("[DEBUG_LOG] RegisterService.hashPassword: Transaction error - " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }







    /**
     * Send welcome email to newly registered user with specified role
     */
    public void sendWelcomeEmail(User user, Integer roleId) {
        System.out.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Starting email transaction");
        System.out.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Transaction data - Recipient: " + 
                          (user != null ? user.getEmail() : "null") +
                          ", Role ID: " + roleId);

        try {
            if (user == null) {
                System.err.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Transaction failed - User object is null");
                return;
            }

            if (user.getEmail() == null || user.getEmail().isEmpty()) {
                System.err.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Transaction failed - Email address is null or empty");
                return;
            }

            // In a real implementation, this would use an email service
            // For now, we'll just log the action
            System.out.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Transaction in progress - Generating email content");
            String emailContent = generateWelcomeEmailContent(user, roleId);
            System.out.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Transaction detail - Email content generated, length: " + 
                              emailContent.length());

            // Simulate email sending
            System.out.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Transaction in progress - Sending email");
            boolean emailSent = simulateEmailSending(user.getEmail(), "Welcome to Course Management System", emailContent);

            if (emailSent) {
                System.out.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Transaction successful - Email sent to: " + user.getEmail());
            } else {
                System.err.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Transaction failed - Email delivery failed for: " + user.getEmail());
            }

        } catch (Exception e) {
            System.err.println("[DEBUG_LOG] RegisterService.sendWelcomeEmail: Transaction error - " + e.getMessage());
            e.printStackTrace();
        }
    }


    // Generate welcome email content based on user role with specified role ID
    private String generateWelcomeEmailContent(User user, Integer roleId) {
        StringBuilder content = new StringBuilder();

        content.append("Dear ").append(user.getFirstName()).append(" ").append(user.getLastName()).append(",\n\n");
        content.append("Welcome to Course Management System!\n\n");
        content.append("Your account has been successfully created with the following details:\n");
        content.append("Username: ").append(user.getUsername()).append("\n");
        content.append("Email: ").append(user.getEmail()).append("\n");

        // Add role-specific content based on the role ID
        if (roleId == 2) { // Teacher role
            content.append("Role: Teacher\n\n");
            content.append("As a teacher, you can now:\n");
            content.append("- Create and manage courses\n");
            content.append("- Upload course materials\n");
            content.append("- Create assignments and quizzes\n");
            content.append("- Grade student submissions\n");
            content.append("- Communicate with students\n\n");
        } else { // Default to Student role
            content.append("Role: Student\n\n");
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
        System.out.println("[DEBUG_LOG] RegisterService.simulateEmailSending: Starting email simulation transaction");
        System.out.println("[DEBUG_LOG] RegisterService.simulateEmailSending: Transaction data - " +
                          "Recipient: " + to + ", " +
                          "Subject: " + subject + ", " +
                          "Content length: " + (content != null ? content.length() : 0) + " characters");

        // For backward compatibility, also log in the original format
        System.out.println("=== EMAIL SIMULATION ===");
        System.out.println("To: " + to);
        System.out.println("Subject: " + subject);
        System.out.println("Content Length: " + (content != null ? content.length() : 0) + " characters");
        System.out.println("Status: SENT");
        System.out.println("========================");

        System.out.println("[DEBUG_LOG] RegisterService.simulateEmailSending: Transaction completed successfully");
        return true;
    }


    private void logRegistrationEvent(User user, String status, String message) {
        System.out.println("[DEBUG_LOG] RegisterService.logRegistrationEvent: Starting audit log transaction");

        try {
            // In real implementation, this would write to an audit log table
            Instant timestamp = Instant.now();
            System.out.println("[DEBUG_LOG] RegisterService.logRegistrationEvent: Transaction data - " +
                              "Timestamp: " + timestamp + ", " +
                              "Username: " + (user != null ? user.getUsername() : "null") + ", " +
                              "Email: " + (user != null ? user.getEmail() : "null") + ", " +
                              "Status: " + status);

            System.out.println("[DEBUG_LOG] RegisterService.logRegistrationEvent: Transaction detail - Message: " + message);

            // For backward compatibility, also log in the original format
            System.out.println("AUDIT LOG: Registration Event");
            System.out.println("  Timestamp: " + timestamp);
            System.out.println("  Username: " + (user != null ? user.getUsername() : "null"));
            System.out.println("  Email: " + (user != null ? user.getEmail() : "null"));
            System.out.println("  Status: " + status);
            System.out.println("  Message: " + message);

            System.out.println("[DEBUG_LOG] RegisterService.logRegistrationEvent: Transaction completed successfully");

        } catch (Exception e) {
            System.err.println("[DEBUG_LOG] RegisterService.logRegistrationEvent: Transaction error - " + e.getMessage());
        }
    }

    /**
     * Get registration statistics (for admin dashboard)
     */
    public RegistrationStatistics getRegistrationStatistics() {
        System.out.println("[DEBUG_LOG] RegisterService.getRegistrationStatistics: Starting statistics transaction");

        try {
            // In real implementation, this would query the database for statistics
            System.out.println("[DEBUG_LOG] RegisterService.getRegistrationStatistics: Transaction in progress - Retrieving statistics from database");

            RegistrationStatistics stats = new RegistrationStatistics();

            System.out.println("[DEBUG_LOG] RegisterService.getRegistrationStatistics: Transaction completed - " +
                              "Total: " + stats.getTotalRegistrations() + ", " +
                              "Today: " + stats.getTodayRegistrations() + ", " +
                              "Weekly: " + stats.getWeeklyRegistrations());

            return stats;

        } catch (Exception e) {
            System.err.println("[DEBUG_LOG] RegisterService.getRegistrationStatistics: Transaction error - " + e.getMessage());
            return new RegistrationStatistics();
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
