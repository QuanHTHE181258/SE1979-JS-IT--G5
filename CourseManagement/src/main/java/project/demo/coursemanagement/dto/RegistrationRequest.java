package project.demo.coursemanagement.dto;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 * Data Transfer Object for user registration requests
 * Contains all form data from registration form
 */
public class RegistrationRequest {

    // Required fields
    private String username;
    private String email;
    private String password;
    private String confirmPassword;
    private String firstName;
    private String lastName;

    // Optional fields
    private String phoneNumber;
    private String dateOfBirth;
    private String role;

    // Checkbox fields
    private boolean agreeToTerms;
    private boolean subscribeNewsletter;

    // Additional metadata
    private String ipAddress;
    private String userAgent;
    private String referrer;


    public RegistrationRequest() {
        // Initialize with default values
        this.agreeToTerms = false;
        this.subscribeNewsletter = false;
        this.role = "USER"; // Default role
    }

    public RegistrationRequest(String username, String email, String password,
                               String confirmPassword, String firstName, String lastName) {
        this();
        this.username = username;
        this.email = email;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username != null ? username.trim() : null;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email != null ? email.trim().toLowerCase() : null;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName != null ? firstName.trim() : null;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName != null ? lastName.trim() : null;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        if (phoneNumber != null && !phoneNumber.trim().isEmpty()) {
            this.phoneNumber = phoneNumber.trim().replaceAll("\\s+", "");
        } else {
            this.phoneNumber = null;  // Set to null instead of empty string
        }
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth != null ? dateOfBirth.trim() : null;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role != null ? role.trim().toUpperCase() : "USER";
    }

    public boolean isAgreeToTerms() {
        return agreeToTerms;
    }

    public void setAgreeToTerms(boolean agreeToTerms) {
        this.agreeToTerms = agreeToTerms;
    }

    public boolean isSubscribeNewsletter() {
        return subscribeNewsletter;
    }

    public void setSubscribeNewsletter(boolean subscribeNewsletter) {
        this.subscribeNewsletter = subscribeNewsletter;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public String getReferrer() {
        return referrer;
    }

    public void setReferrer(String referrer) {
        this.referrer = referrer;
    }

    // Helper methods

    //Get the full name in "First Last" format
    public String getFullName() {
        if (firstName != null && lastName != null) {
            return firstName + " " + lastName;
        } else if (firstName != null) {
            return firstName;
        } else if (lastName != null) {
            return lastName;
        }
        return "";
    }

    // Parse date of birth from string to LocalDate
    public LocalDate getParsedDateOfBirth() {
        if (dateOfBirth == null || dateOfBirth.trim().isEmpty()) {
            return null;
        }

        try {
            return LocalDate.parse(dateOfBirth, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    // Check if all required fields are filled
    public boolean hasRequiredFields() {
        return username != null && !username.trim().isEmpty() &&
                email != null && !email.trim().isEmpty() &&
                password != null && !password.isEmpty() &&
                confirmPassword != null && !confirmPassword.isEmpty() &&
                firstName != null && !firstName.trim().isEmpty() &&
                lastName != null && !lastName.trim().isEmpty();
    }

    // Check if passwords match
    public boolean passwordsMatch() {
        return password != null && password.equals(confirmPassword);
    }

    // Clear sensitive password fields
    public void clearPasswords() {
        this.password = "";
        this.confirmPassword = "";
    }

    // Check if this is a teacher registration
    public boolean isTeacherRegistration() {
        return "TEACHER".equalsIgnoreCase(role);
    }

    // Check if this is a student registration
    public boolean isStudentRegistration() {
        return "USER".equalsIgnoreCase(role) || role == null;
    }

    // Validate the registration request
    public boolean isValid() {
        // Basic validation - more detailed validation should use ValidationUtil
        if (!hasRequiredFields()) {
            return false;
        }

        if (!passwordsMatch()) {
            return false;
        }

        if (username.length() < 3 || username.length() > 20) {
            return false;
        }

        if (email.length() > 100) {
            return false;
        }

        if (password.length() < 6) {
            return false;
        }

        return true;
    }

    //Create a user log (without sensitive data)
    public RegistrationRequest createSafeLogCopy() {
        RegistrationRequest safeCopy = new RegistrationRequest();
        safeCopy.setUsername(this.username);
        safeCopy.setEmail(this.email);
        safeCopy.setFirstName(this.firstName);
        safeCopy.setLastName(this.lastName);
        safeCopy.setPhoneNumber(this.phoneNumber);
        safeCopy.setDateOfBirth(this.dateOfBirth);
        safeCopy.setRole(this.role);
        safeCopy.setAgreeToTerms(this.agreeToTerms);
        safeCopy.setSubscribeNewsletter(this.subscribeNewsletter);
        safeCopy.setIpAddress(this.ipAddress);
        safeCopy.setUserAgent(this.userAgent);
        safeCopy.setReferrer(this.referrer);
        // Passwords are intentionally not copied
        return safeCopy;
    }

    // Builder pattern for creating RegistrationRequest

    public static class Builder {
        private RegistrationRequest request;

        public Builder() {
            request = new RegistrationRequest();
        }

        public Builder username(String username) {
            request.setUsername(username);
            return this;
        }

        public Builder email(String email) {
            request.setEmail(email);
            return this;
        }

        public Builder password(String password) {
            request.setPassword(password);
            return this;
        }

        public Builder confirmPassword(String confirmPassword) {
            request.setConfirmPassword(confirmPassword);
            return this;
        }

        public Builder firstName(String firstName) {
            request.setFirstName(firstName);
            return this;
        }

        public Builder lastName(String lastName) {
            request.setLastName(lastName);
            return this;
        }

        public Builder phoneNumber(String phoneNumber) {
            request.setPhoneNumber(phoneNumber);
            return this;
        }

        public Builder dateOfBirth(String dateOfBirth) {
            request.setDateOfBirth(dateOfBirth);
            return this;
        }

        public Builder role(String role) {
            request.setRole(role);
            return this;
        }

        public Builder agreeToTerms(boolean agreeToTerms) {
            request.setAgreeToTerms(agreeToTerms);
            return this;
        }

        public Builder subscribeNewsletter(boolean subscribeNewsletter) {
            request.setSubscribeNewsletter(subscribeNewsletter);
            return this;
        }

        public RegistrationRequest build() {
            return request;
        }
    }
}
