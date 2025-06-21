package project.demo.coursemanagement.utils;

import project.demo.coursemanagement.dto.RegistrationRequest;
import project.demo.coursemanagement.dto.ValidationResult;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 * Utility class for form validation
 */
public class ValidationUtil {

    // Regex patterns for validation
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$"
    );

    private static final Pattern USERNAME_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9_]{3,20}$"
    );

    private static final Pattern PHONE_PATTERN = Pattern.compile(
            "^[+]?[0-9]{10,15}$"
    );

    private static final Pattern NAME_PATTERN = Pattern.compile(
            "^[a-zA-ZÀ-ỹ\\s]{2,50}$"
    );

    // Password requirements
    private static final int MIN_PASSWORD_LENGTH = 6;
    private static final int MAX_PASSWORD_LENGTH = 100;

    // Age requirements
    private static final int MIN_AGE = 13;
    private static final int MAX_AGE = 100;

    /**
     * Validate complete registration request
     */
    public static ValidationResult validateRegistration(RegistrationRequest request) {
        List<String> errors = new ArrayList<>();

        if (request == null) {
            errors.add("Registration data is required");
            return new ValidationResult(false, errors);
        }

        // Validate all fields
        validateUsername(request.getUsername(), errors);
        validateEmail(request.getEmail(), errors);
        validatePassword(request.getPassword(), request.getConfirmPassword(), errors);
        validateFirstName(request.getFirstName(), errors);
        validateLastName(request.getLastName(), errors);
        validatePhone(request.getPhoneNumber(), errors);
        validateDateOfBirth(request.getDateOfBirth(), errors);
        validateRole(request.getRole(), errors);
        validateTermsAcceptance(request.isAgreeToTerms(), errors);

        boolean isValid = errors.isEmpty();
        return new ValidationResult(isValid, errors);
    }

    /**
     * Validate username
     */
    public static void validateUsername(String username, List<String> errors) {
        if (username == null || username.trim().isEmpty()) {
            errors.add("Username is required");
            return;
        }

        username = username.trim();

        if (username.length() < 3) {
            errors.add("Username must be at least 3 characters long");
        }

        if (username.length() > 20) {
            errors.add("Username cannot be longer than 20 characters");
        }

        if (!USERNAME_PATTERN.matcher(username).matches()) {
            errors.add("Username can only contain letters, numbers, and underscores");
        }

        // Check for reserved usernames
        if (isReservedUsername(username)) {
            errors.add("This username is not available");
        }
    }

    /**
     * Validate email address
     */
    public static void validateEmail(String email, List<String> errors) {
        if (email == null || email.trim().isEmpty()) {
            errors.add("Email address is required");
            return;
        }

        email = email.trim().toLowerCase();

        if (email.length() > 100) {
            errors.add("Email address cannot be longer than 100 characters");
        }

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            errors.add("Please enter a valid email address");
        }

        // Check for disposable email domains (optional)
        if (isDisposableEmail(email)) {
            errors.add("Please use a permanent email address");
        }
    }

    /**
     * Validate password and confirm password
     */
    public static void validatePassword(String password, String confirmPassword, List<String> errors) {
        if (password == null || password.isEmpty()) {
            errors.add("Password is required");
            return;
        }

        if (confirmPassword == null || confirmPassword.isEmpty()) {
            errors.add("Please confirm your password");
            return;
        }

        if (password.length() < MIN_PASSWORD_LENGTH) {
            errors.add("Password must be at least " + MIN_PASSWORD_LENGTH + " characters long");
        }

        if (password.length() > MAX_PASSWORD_LENGTH) {
            errors.add("Password cannot be longer than " + MAX_PASSWORD_LENGTH + " characters");
        }

        if (!password.equals(confirmPassword)) {
            errors.add("Password and confirm password do not match");
        }

        // Password strength validation
        validatePasswordStrength(password, errors);
    }

    /**
     * Validate password strength
     */
    private static void validatePasswordStrength(String password, List<String> errors) {
        boolean hasUpper = password.chars().anyMatch(Character::isUpperCase);
        boolean hasLower = password.chars().anyMatch(Character::isLowerCase);
        boolean hasDigit = password.chars().anyMatch(Character::isDigit);
        boolean hasSpecial = password.chars().anyMatch(ch -> "!@#$%^&*()_+-=[]{}|;:,.<>?".indexOf(ch) >= 0);

        List<String> missingRequirements = new ArrayList<>();

        if (!hasUpper) {
            missingRequirements.add("uppercase letter");
        }
        if (!hasLower) {
            missingRequirements.add("lowercase letter");
        }
        if (!hasDigit) {
            missingRequirements.add("number");
        }
        if (!hasSpecial) {
            missingRequirements.add("special character (!@#$%^&*()_+-=[]{}|;:,.<>?)");
        }

        if (!missingRequirements.isEmpty()) {
            errors.add("Password must contain at least one: " + String.join(", ", missingRequirements));
        }

        // Check for common weak passwords
        if (isWeakPassword(password)) {
            errors.add("Password is too common. Please choose a stronger password");
        }
    }

    /**
     * Validate first name
     */
    public static void validateFirstName(String firstName, List<String> errors) {
        if (firstName == null || firstName.trim().isEmpty()) {
            errors.add("First name is required");
            return;
        }

        firstName = firstName.trim();

        if (firstName.length() < 2) {
            errors.add("First name must be at least 2 characters long");
        }

        if (firstName.length() > 50) {
            errors.add("First name cannot be longer than 50 characters");
        }

        if (!NAME_PATTERN.matcher(firstName).matches()) {
            errors.add("First name can only contain letters and spaces");
        }
    }

    /**
     * Validate last name
     */
    public static void validateLastName(String lastName, List<String> errors) {
        if (lastName == null || lastName.trim().isEmpty()) {
            errors.add("Last name is required");
            return;
        }

        lastName = lastName.trim();

        if (lastName.length() < 2) {
            errors.add("Last name must be at least 2 characters long");
        }

        if (lastName.length() > 50) {
            errors.add("Last name cannot be longer than 50 characters");
        }

        if (!NAME_PATTERN.matcher(lastName).matches()) {
            errors.add("Last name can only contain letters and spaces");
        }
    }

    /**
     * Validate phone number (optional field)
     */
    public static void validatePhone(String phone, List<String> errors) {
        if (phone == null || phone.trim().isEmpty()) {
            return; // Phone is optional
        }

        phone = phone.trim().replaceAll("\\s+", ""); // Remove spaces

        if (!PHONE_PATTERN.matcher(phone).matches()) {
            errors.add("Please enter a valid phone number (10-15 digits)");
        }
    }

    /**
     * Validate date of birth (optional field)
     */
    public static void validateDateOfBirth(String dateOfBirth, List<String> errors) {
        if (dateOfBirth == null || dateOfBirth.trim().isEmpty()) {
            return; // Date of birth is optional
        }

        try {
            LocalDate birthDate = LocalDate.parse(dateOfBirth, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            LocalDate today = LocalDate.now();

            if (birthDate.isAfter(today)) {
                errors.add("Date of birth cannot be in the future");
                return;
            }

            int age = today.getYear() - birthDate.getYear();
            if (birthDate.getDayOfYear() > today.getDayOfYear()) {
                age--;
            }

            if (age < MIN_AGE) {
                errors.add("You must be at least " + MIN_AGE + " years old to register");
            }

            if (age > MAX_AGE) {
                errors.add("Please enter a valid date of birth");
            }

        } catch (DateTimeParseException e) {
            errors.add("Please enter a valid date of birth (YYYY-MM-DD format)");
        }
    }

    /**
     * Validate role selection
     */
    public static void validateRole(String role, List<String> errors) {
        if (role == null || role.trim().isEmpty()) {
            return; // Role will default to 1 (Student) if not specified
        }

        role = role.trim();

        // Only allow 1 (Student) and 2 (Teacher) for self-registration
        if (!role.equals("1") && !role.equals("2") && 
            !role.equals("USER") && !role.equals("TEACHER") && 
            !role.equalsIgnoreCase("STUDENT")) {
            errors.add("Invalid role selection");
        }
    }

    /**
     * Validate terms acceptance
     */
    public static void validateTermsAcceptance(boolean agreeToTerms, List<String> errors) {
        if (!agreeToTerms) {
            errors.add("You must agree to the terms and conditions to register");
        }
    }

    /**
     * Check if username is reserved
     */
    private static boolean isReservedUsername(String username) {
        String[] reserved = {
                "admin", "administrator", "root", "system", "guest", "user",
                "test", "demo", "api", "www", "mail", "email", "support",
                "help", "info", "contact", "service", "staff", "team"
        };

        String lowerUsername = username.toLowerCase();
        for (String reservedName : reserved) {
            if (lowerUsername.equals(reservedName)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Check if email is from disposable email provider
     */
    private static boolean isDisposableEmail(String email) {
        String[] disposableDomains = {
                "10minutemail.com", "tempmail.org", "guerrillamail.com",
                "mailinator.com", "yopmail.com", "temp-mail.org"
        };

        String domain = email.substring(email.indexOf("@") + 1).toLowerCase();
        for (String disposableDomain : disposableDomains) {
            if (domain.equals(disposableDomain)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Check if password is commonly used weak password
     */
    private static boolean isWeakPassword(String password) {
        String[] weakPasswords = {
                "password", "123456", "password123", "admin", "qwerty",
                "letmein", "welcome", "monkey", "1234567890", "password1",
                "abc123", "Password1", "123456789", "welcome123"
        };

        String lowerPassword = password.toLowerCase();
        for (String weak : weakPasswords) {
            if (lowerPassword.equals(weak.toLowerCase())) {
                return true;
            }
        }
        return false;
    }

    /**
     * Standalone email validation
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    /**
     * Standalone username validation
     */
    public static boolean isValidUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }

        username = username.trim();
        return username.length() >= 3 &&
                username.length() <= 20 &&
                USERNAME_PATTERN.matcher(username).matches() &&
                !isReservedUsername(username);
    }

    /**
     * Standalone password validation
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.isEmpty()) {
            return false;
        }

        if (password.length() < MIN_PASSWORD_LENGTH || password.length() > MAX_PASSWORD_LENGTH) {
            return false;
        }

        boolean hasUpper = password.chars().anyMatch(Character::isUpperCase);
        boolean hasLower = password.chars().anyMatch(Character::isLowerCase);
        boolean hasDigit = password.chars().anyMatch(Character::isDigit);
        boolean hasSpecial = password.chars().anyMatch(ch -> "!@#$%^&*()_+-=[]{}|;:,.<>?".indexOf(ch) >= 0);

        return hasUpper && hasLower && hasDigit && hasSpecial && !isWeakPassword(password);
    }

    /**
     * Standalone phone validation
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return true; // Phone is optional
        }

        phone = phone.trim().replaceAll("\\s+", "");
        return PHONE_PATTERN.matcher(phone).matches();
    }

    /**
     * Validate file upload
     */
    public static boolean isValidFileType(String fileName, String[] allowedTypes) {
        if (fileName == null || fileName.trim().isEmpty()) {
            return false;
        }

        String extension = fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase();
        for (String allowedType : allowedTypes) {
            if (extension.equals(allowedType.toLowerCase())) {
                return true;
            }
        }
        return false;
    }

    /**
     * Validate file size
     */
    public static boolean isValidFileSize(long fileSize, long maxSizeBytes) {
        return fileSize > 0 && fileSize <= maxSizeBytes;
    }

    /**
     * Sanitize input to prevent XSS
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }

        return input.trim()
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll("\"", "&quot;")
                .replaceAll("'", "&#x27;")
                .replaceAll("/", "&#x2F;");
    }
}
