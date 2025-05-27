package project.demo.coursemanagement.test;

import project.demo.coursemanagement.dto.RegistrationRequest;
import project.demo.coursemanagement.dto.ValidationResult;
import project.demo.coursemanagement.service.RegisterService;
import project.demo.coursemanagement.utils.ValidationUtil;

public class DebugRegistration {

    public static void main(String[] args) {
        System.out.println("=== DEBUGGING REGISTRATION ISSUE ===\n");

        // Create the same request that failed
        String timestamp = String.valueOf(System.currentTimeMillis()).substring(8);
        String testUsername = "test" + timestamp;
        String testEmail = "test" + timestamp + "@test.com";

        RegistrationRequest request = createValidRequest(testUsername, testEmail);

        System.out.println("Testing request:");
        System.out.println("   Username: " + request.getUsername() + " (length: " + request.getUsername().length() + ")");
        System.out.println("   Email: " + request.getEmail());
        System.out.println("   First Name: " + request.getFirstName());
        System.out.println("   Last Name: " + request.getLastName());
        System.out.println("   Role: " + request.getRole());
        System.out.println();

        // Test ValidationUtil first
        System.out.println("--- Step 1: ValidationUtil Check ---");
        ValidationResult validationUtilResult = ValidationUtil.validateRegistration(request);
        System.out.println("ValidationUtil result: " + validationUtilResult.isValid());
        if (!validationUtilResult.isValid()) {
            System.out.println("ValidationUtil errors:");
            for (String error : validationUtilResult.getErrors()) {
                System.out.println("   - " + error);
            }
        }
        System.out.println();

        // Test RegisterService validation
        System.out.println("--- Step 2: RegisterService Check ---");
        RegisterService registerService = new RegisterService();
        ValidationResult serviceResult = registerService.validateRegistrationRequest(request);
        System.out.println("RegisterService result: " + serviceResult.isValid());
        if (!serviceResult.isValid()) {
            System.out.println("RegisterService errors:");
            for (String error : serviceResult.getErrors()) {
                System.out.println("   - " + error);
            }
        }
        System.out.println();

        // Debug individual business rules
        System.out.println("--- Step 3: Individual Business Rule Debug ---");
        debugBusinessRules(request);

        System.out.println("\n=== DEBUG COMPLETED ===");
    }

    private static void debugBusinessRules(RegistrationRequest request) {
        System.out.println("Checking individual business rules:");

        // Check 1: Role registration allowed
        boolean roleAllowed = isRoleRegistrationAllowed(request.getRole());
        System.out.println("   Role '" + request.getRole() + "' allowed: " + roleAllowed);

        // Check 2: Teacher email validation
        if ("TEACHER".equalsIgnoreCase(request.getRole())) {
            boolean validTeacherEmail = isValidTeacherEmail(request.getEmail());
            System.out.println("   Teacher email valid: " + validTeacherEmail);
        }

        // Check 3: Rate limiting
        boolean rateLimited = isRateLimited(request);
        System.out.println("   Rate limited: " + rateLimited);
    }


    // Copy business rule methods from RegisterService
    private static boolean isRoleRegistrationAllowed(String role) {
        if (role == null) {
            return true;
        }

        switch (role.toUpperCase()) {
            case "USER":
            case "TEACHER":
                return true;
            case "ADMIN":
            case "GUEST":
                return false;
            default:
                return false;
        }
    }

    private static boolean isValidTeacherEmail(String email) {
        if (email == null) {
            return false;
        }

        String[] institutionalDomains = {
                "edu", "edu.vn", "university.edu", "college.edu", "school.edu"
        };

        String emailLower = email.toLowerCase();
        for (String domain : institutionalDomains) {
            if (emailLower.endsWith("." + domain)) {
                return true;
            }
        }

        return true; // Personal emails allowed but generate warnings
    }

    private static boolean isRateLimited(RegistrationRequest request) {
        return false; // Always return false in simulation
    }

    private static RegistrationRequest createValidRequest(String username, String email) {
        RegistrationRequest request = new RegistrationRequest();
        request.setUsername(username);
        request.setEmail(email);
        request.setPassword("ValidPass123!");
        request.setConfirmPassword("ValidPass123!");
        request.setFirstName("John");
        request.setLastName("Doe");
        request.setPhone("+84123456789");
        request.setDateOfBirth("1990-01-01");
        request.setRole("USER");
        request.setAgreeToTerms(true);
        request.setSubscribeNewsletter(false);
        return request;
    }
}