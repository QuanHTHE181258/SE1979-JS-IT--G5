package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.ProfileService;
import project.demo.coursemanagement.service.OrderService;
import project.demo.coursemanagement.utils.SessionUtil;
import project.demo.coursemanagement.dto.ProfileUpdateRequest;
import project.demo.coursemanagement.dto.ValidationResult;
import project.demo.coursemanagement.utils.ValidationUtil;
import project.demo.coursemanagement.dto.OrderDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

/**
 * Servlet for handling user profile management
 */
@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile", "/profile/*"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1 MB
        maxFileSize = 1024 * 1024 * 5,      // 5 MB
        maxRequestSize = 1024 * 1024 * 10   // 10 MB
)
public class ProfileController extends HttpServlet {

    private ProfileService profileService;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        super.init();

        // Get the real webapp path
        String webappPath = getServletContext().getRealPath("/");
        System.out.println("ProfileServlet: Webapp path: " + webappPath);

        // Pass the webapp path
        profileService = new ProfileService(webappPath);

        // Initialize OrderService
        orderService = new OrderService();

        System.out.println("ProfileServlet initialized with webapp path");
    }

    /**
     * Handle GET requests - Display profile page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ProfileServlet GET request received");

        // Check if user is logged in
        if (!SessionUtil.isUserLoggedIn(request)) {
            System.out.println("User not logged in, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Show current user's profile
            showCurrentUserProfile(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Show profile edit form
            showProfileEditForm(request, response);
        } else if (pathInfo.equals("/password")) {
            // Show password change form
            showPasswordChangeForm(request, response);
        } else if (pathInfo.equals("/avatar")) {
            // Show avatar upload form
            showAvatarUploadForm(request, response);
        } else if (pathInfo.equals("/orders")) {
            // Show user's order history
            showOrderHistory(request, response);
        } else if (pathInfo.startsWith("/view/")) {
            // View another user's profile (if allowed)
            viewUserProfile(request, response, pathInfo);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * Handle POST requests - Process profile updates
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ProfileServlet POST request received");

        // Check if user is logged in
        if (!SessionUtil.isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        } else if (pathInfo.equals("/edit")) {
            // Process profile update
            processProfileUpdate(request, response);
        } else if (pathInfo.equals("/password")) {
            // Process password change
            processPasswordChange(request, response);
        } else if (pathInfo.equals("/avatar")) {
            // Process avatar upload
            processAvatarUpload(request, response);
        } else if (pathInfo.equals("/delete-avatar")) {
            // Process avatar deletion
            processAvatarDeletion(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    /**
     * Show current user's profile
     */
    private void showCurrentUserProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = SessionUtil.getUserId(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get user data from database
            User user = profileService.getUserById(userId);

//            if (user == null) {
//                SessionUtil.setFlashMessage(request, "error", "Unable to load profile. Please try again.");
//                response.sendRedirect(request.getContextPath() + "/profile");
//                return;
//            }

            // Get profile statistics
            ProfileService.ProfileStatistics stats = profileService.getProfileStatistics(userId);

            // Get any flash messages
            String flashMessage = SessionUtil.getAndClearFlashMessage(request);
            if (flashMessage != null) {
                String[] parts = flashMessage.split(":", 2);
                if (parts.length == 2) {
                    request.setAttribute("messageType", parts[0]);
                    request.setAttribute("message", parts[1]);
                }
            }

            // Set attributes for JSP
            request.setAttribute("user", user);
            request.setAttribute("profileStats", stats);

            // Forward to profile view
            request.getRequestDispatcher("/WEB-INF/views/profile/profile.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error loading profile: " + e.getMessage());
            e.printStackTrace();
            SessionUtil.setFlashMessage(request, "error", "An error occurred while loading your profile.");
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }

    /**
     * Show profile edit form
     */
    private void showProfileEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = SessionUtil.getUserId(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            User user = profileService.getUserById(userId);

            if (user == null) {
                SessionUtil.setFlashMessage(request, "error", "Unable to load profile for editing.");
                response.sendRedirect(request.getContextPath() + "/profile");
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

            // Add form validation constraints for the JSP
            Map<String, Object> formConstraints = new HashMap<>();
            formConstraints.put("maxUsernameLength", 20);
            formConstraints.put("maxEmailLength", 100);
            formConstraints.put("maxNameLength", 50);
            formConstraints.put("minAge", 13);
            request.setAttribute("formConstraints", formConstraints);

            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile/edit_profile.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error loading profile edit form: " + e.getMessage());
            SessionUtil.setFlashMessage(request, "error", "An error occurred. Please try again.");
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }

    /**
     * Process profile update
     */
    private void processProfileUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = SessionUtil.getUserId(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Create profile update request from form data
            ProfileUpdateRequest updateRequest = createProfileUpdateRequest(request);
            updateRequest.setUserId(userId);

            System.out.println("Processing profile update for user ID: " + userId);

            // Validate update data
            ValidationResult validationResult = profileService.validateProfileUpdateSimple(updateRequest);

            if (!validationResult.isValid()) {
                // Validation failed
                System.out.println("Profile update validation failed: " + validationResult.getErrors());
                handleProfileUpdateError(request, response, validationResult.getErrors(), updateRequest);
                return;
            }

            // Update profile
            boolean updateSuccess = profileService.updateProfile(updateRequest);

            if (updateSuccess) {
                System.out.println("Profile updated successfully for user ID: " + userId);

                // Update session if username changed
                if (updateRequest.getUsername() != null) {
                    User updatedUser = profileService.getUserById(userId);
                    if (updatedUser != null) {
                        SessionUtil.setUserSession(request, updatedUser);
                    }
                }

                SessionUtil.setFlashMessage(request, "success", "Your profile has been updated successfully!");
                response.sendRedirect(request.getContextPath() + "/profile");

            } else {
                System.out.println("Profile update failed for user ID: " + userId);
                handleProfileUpdateError(request, response,
                        java.util.Arrays.asList("Failed to update profile. Please try again."),
                        updateRequest);
            }

        } catch (Exception e) {
            System.err.println("Error updating profile: " + e.getMessage());
            e.printStackTrace();
            SessionUtil.setFlashMessage(request, "error", "An unexpected error occurred. Please try again.");
            response.sendRedirect(request.getContextPath() + "/profile/edit");
        }
    }

    /**
     * Show password change form
     */
    private void showPasswordChangeForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get any flash messages
        String flashMessage = SessionUtil.getAndClearFlashMessage(request);
        if (flashMessage != null) {
            String[] parts = flashMessage.split(":", 2);
            if (parts.length == 2) {
                request.setAttribute("messageType", parts[0]);
                request.setAttribute("message", parts[1]);
            }
        }

        request.getRequestDispatcher("/WEB-INF/views/profile/password.jsp").forward(request, response);
    }

    /**
     * Process password change
     */
    private void processPasswordChange(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = SessionUtil.getUserId(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic validation
        if (currentPassword == null || currentPassword.isEmpty() ||
                newPassword == null || newPassword.isEmpty() ||
                confirmPassword == null || confirmPassword.isEmpty()) {

            SessionUtil.setFlashMessage(request, "error", "All password fields are required.");
            response.sendRedirect(request.getContextPath() + "/profile/password");
            return;
        }

        // Check if new passwords match
        if (!newPassword.equals(confirmPassword)) {
            SessionUtil.setFlashMessage(request, "error", "New password and confirm password do not match.");
            response.sendRedirect(request.getContextPath() + "/profile/password");
            return;
        }

        try {
            // Validate new password strength
            java.util.List<String> errors = new java.util.ArrayList<>();
            ValidationUtil.validatePassword(newPassword, confirmPassword, errors);

            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/WEB-INF/views/profile/password.jsp").forward(request, response);
                return;
            }

            // Change password
            boolean success = profileService.validateAndChangePassword(userId, currentPassword, newPassword);

            if (success) {
                System.out.println("Password changed successfully for user ID: " + userId);
                SessionUtil.setFlashMessage(request, "success",
                        "Your password has been changed successfully! Please use your new password on next login.");
                response.sendRedirect(request.getContextPath() + "/profile");
            } else {
                SessionUtil.setFlashMessage(request, "error",
                        "Current password is incorrect. Please try again.");
                response.sendRedirect(request.getContextPath() + "/profile/password");
            }

        } catch (Exception e) {
            System.err.println("Error changing password: " + e.getMessage());
            SessionUtil.setFlashMessage(request, "error",
                    "An error occurred while changing your password. Please try again.");
            response.sendRedirect(request.getContextPath() + "/profile/password");
        }
    }

    /**
     * Show avatar upload form
     */
    private void showAvatarUploadForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = SessionUtil.getUserId(request);
        User user = profileService.getUserById(userId);

        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/profile/avatar.jsp").forward(request, response);
    }

    /**
     * Process avatar upload
     */
    private void processAvatarUpload(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = SessionUtil.getUserId(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Part filePart = request.getPart("avatar");

            if (filePart == null || filePart.getSize() == 0) {
                SessionUtil.setFlashMessage(request, "error", "Please select an image file to upload.");
                response.sendRedirect(request.getContextPath() + "/profile/avatar");
                return;
            }

            // Validate file type
            String fileName = getFileName(filePart);
            String[] allowedTypes = {"jpg", "jpeg", "png", "gif"};

            if (!ValidationUtil.isValidFileType(fileName, allowedTypes)) {
                SessionUtil.setFlashMessage(request, "error",
                        "Invalid file type. Please upload a JPG, PNG, or GIF image.");
                response.sendRedirect(request.getContextPath() + "/profile/avatar");
                return;
            }

            // Validate file size (max 5MB)
            long maxSize = 5 * 1024 * 1024; // 5MB
            if (!ValidationUtil.isValidFileSize(filePart.getSize(), maxSize)) {
                SessionUtil.setFlashMessage(request, "error",
                        "File size too large. Maximum allowed size is 5MB.");
                response.sendRedirect(request.getContextPath() + "/profile/avatar");
                return;
            }

            // Upload avatar
            String avatarUrl = profileService.validateAndUploadAvatar(userId, filePart, fileName);

            if (avatarUrl != null) {
                System.out.println("Avatar uploaded successfully for user ID: " + userId);

                // Update user session with new avatar URL
                User updatedUser = profileService.getUserById(userId);
                if (updatedUser != null) {
                    SessionUtil.setUserSession(request, updatedUser);
                }

                SessionUtil.setFlashMessage(request, "success", "Avatar uploaded successfully!");
                response.sendRedirect(request.getContextPath() + "/profile");
            } else {
                SessionUtil.setFlashMessage(request, "error", "Failed to upload avatar. Please try again.");
                response.sendRedirect(request.getContextPath() + "/profile/avatar");
            }

        } catch (Exception e) {
            System.err.println("Error uploading avatar: " + e.getMessage());
            e.printStackTrace();
            SessionUtil.setFlashMessage(request, "error", "An error occurred while uploading avatar.");
            response.sendRedirect(request.getContextPath() + "/profile/avatar");
        }
    }

    /**
     * Process avatar deletion
     */
    private void processAvatarDeletion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = SessionUtil.getUserId(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get current avatar info
            User user = profileService.getUserById(userId);
            if (user == null || user.getAvatarUrl() == null) {
                SessionUtil.setFlashMessage(request, "success", "No avatar to remove!");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }

            boolean success = profileService.deleteAvatar(userId);

            if (success) {
                // Update user session
                User updatedUser = profileService.getUserById(userId);
                if (updatedUser != null) {
                    SessionUtil.setUserSession(request, updatedUser);
                }

                SessionUtil.setFlashMessage(request, "success", "Avatar removed successfully!");
            } else {
                SessionUtil.setFlashMessage(request, "error", "Failed to remove avatar.");
            }

        } catch (Exception e) {
            System.err.println("Error deleting avatar: " + e.getMessage());
            SessionUtil.setFlashMessage(request, "error", "An error occurred while removing avatar.");
        }

        response.sendRedirect(request.getContextPath() + "/profile");
    }

    /**
     * View another user's profile (if allowed)
     */
    private void viewUserProfile(HttpServletRequest request, HttpServletResponse response, String pathInfo)
            throws ServletException, IOException {

        try {
            // Extract user ID from path
            String userIdStr = pathInfo.substring("/view/".length());
            Integer targetUserId = Integer.parseInt(userIdStr);

            // Check if user can view this profile
            Integer currentUserId = SessionUtil.getUserId(request);
            String currentUserRole = SessionUtil.getUserRole(request);

            // Only allow viewing own profile or if user is admin
            if (!targetUserId.equals(currentUserId) && !"ADMIN".equals(currentUserRole)) {
                SessionUtil.setFlashMessage(request, "error", "You don't have permission to view this profile.");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }

            User targetUser = profileService.getUserById(targetUserId);

            if (targetUser == null) {
                SessionUtil.setFlashMessage(request, "error", "User profile not found.");
                response.sendRedirect(request.getContextPath() + "/enrollments");
                return;
            }

            ProfileService.ProfileStatistics stats = profileService.getProfileStatistics(targetUserId);

            request.setAttribute("user", targetUser);
            request.setAttribute("profileStats", stats);
            request.setAttribute("isOwnProfile", targetUserId.equals(currentUserId));

            request.getRequestDispatcher("/WEB-INF/views/profile/profile.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID");
        } catch (Exception e) {
            System.err.println("Error viewing user profile: " + e.getMessage());
            SessionUtil.setFlashMessage(request, "error", "An error occurred while loading the profile.");
            response.sendRedirect(request.getContextPath() + "/enrollments");
        }
    }

    /**
     * Show user's order history
     */
    private void showOrderHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer userId = SessionUtil.getUserId(request);
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get user data from database
            User user = profileService.getUserById(userId);

            if (user == null) {
                SessionUtil.setFlashMessage(request, "error", "Unable to load profile. Please try again.");
                response.sendRedirect(request.getContextPath() + "/enrollments");
                return;
            }

            // Get user's orders
            List<OrderDTO> orders = orderService.getOrdersByUserId(userId);

            // Get any flash messages
            String flashMessage = SessionUtil.getAndClearFlashMessage(request);
            if (flashMessage != null) {
                String[] parts = flashMessage.split(":", 2);
                if (parts.length == 2) {
                    request.setAttribute("messageType", parts[0]);
                    request.setAttribute("message", parts[1]);
                }
            }

            // Set attributes for JSP
            request.setAttribute("user", user);
            request.setAttribute("orders", orders);

            // Forward to order history page
            request.getRequestDispatcher("/WEB-INF/views/profile/order_history.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error showing order history: " + e.getMessage());
            e.printStackTrace();
            SessionUtil.setFlashMessage(request, "error", "An error occurred while loading your order history.");
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }

    /**
     * Create profile update request from form parameters
     */
    private ProfileUpdateRequest createProfileUpdateRequest(HttpServletRequest request) {
        ProfileUpdateRequest updateRequest = new ProfileUpdateRequest();

        updateRequest.setUsername(getParameter(request, "username"));
        updateRequest.setEmail(getParameter(request, "email"));
        updateRequest.setFirstName(getParameter(request, "firstName"));
        updateRequest.setLastName(getParameter(request, "lastName"));
        updateRequest.setPhone(getParameter(request, "phone"));
        updateRequest.setDateOfBirth(getParameter(request, "dateOfBirth"));

        return updateRequest;
    }

    /**
     * Handle profile update errors
     */
    private void handleProfileUpdateError(HttpServletRequest request, HttpServletResponse response,
                                          java.util.List<String> errors,
                                          ProfileUpdateRequest updateRequest)
            throws ServletException, IOException {

        request.setAttribute("messageType", "danger");
        request.setAttribute("errors", errors);

        // Get current user data
        Integer userId = SessionUtil.getUserId(request);
        User user = profileService.getUserById(userId);

        // Merge form data with current user data for redisplay
        if (updateRequest != null && user != null) {
            if (updateRequest.getUsername() != null && !updateRequest.getUsername().trim().isEmpty()) {
                user.setUsername(updateRequest.getUsername());
            }
            if (updateRequest.getEmail() != null && !updateRequest.getEmail().trim().isEmpty()) {
                user.setEmail(updateRequest.getEmail());
            }
            if (updateRequest.getFirstName() != null) {
                user.setFirstName(updateRequest.getFirstName().trim().isEmpty() ? null : updateRequest.getFirstName());
            }
            if (updateRequest.getLastName() != null) {
                user.setLastName(updateRequest.getLastName().trim().isEmpty() ? null : updateRequest.getLastName());
            }
            if (updateRequest.getPhone() != null) {
                user.setPhoneNumber(updateRequest.getPhone().trim().isEmpty() ? null : updateRequest.getPhone());
            }
            if (updateRequest.getDateOfBirth() != null && !updateRequest.getDateOfBirth().trim().isEmpty()) {
                try {
                    LocalDate dob = LocalDate.parse(updateRequest.getDateOfBirth(),
                            DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    user.setDateOfBirth(dob);
                } catch (DateTimeParseException e) {
                    // Keep original date if parsing fails
                    System.err.println("Error parsing date of birth: " + e.getMessage());
                }
            }
        }

        // Add form constraints for redisplay
        Map<String, Object> formConstraints = new HashMap<>();
        formConstraints.put("maxUsernameLength", 20);
        formConstraints.put("maxEmailLength", 100);
        formConstraints.put("maxNameLength", 50);
        formConstraints.put("minAge", 13);
        request.setAttribute("formConstraints", formConstraints);

        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/profile/edit_profile.jsp").forward(request, response);
    }

    /**
     * Get parameter and trim whitespace
     */
    private String getParameter(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        return (value != null) ? value.trim() : null;
    }

    /**
     * Extract filename from Part
     */
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");

        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return null;
    }

    @Override
    public void destroy() {
        super.destroy();
        System.out.println("ProfileServlet destroyed");
    }
}