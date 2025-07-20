package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dto.PasswordResetRequest;
import project.demo.coursemanagement.service.PasswordResetService;
import project.demo.coursemanagement.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Controller for handling password reset functionality
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {

    private PasswordResetService passwordResetService;

    @Override
    public void init() throws ServletException {
        super.init();
        passwordResetService = new PasswordResetService();
        System.out.println("ResetPasswordController initialized");
    }

    /**
     * GET request - Display reset password page with token validation
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ResetPasswordController GET request received");

        // Check if user is already logged in - redirect to dashboard if so
        if (SessionUtil.isUserLoggedIn(request)) {
            System.out.println("User already logged in, redirecting to dashboard");
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/dashboard");
            return;
        }

        String token = request.getParameter("token");

        // Validate token parameter
        if (token == null || token.trim().isEmpty()) {
            System.out.println("No token provided for password reset");
            redirectToForgotPassword(request, response, "Invalid reset link. Please request a new password reset.");
            return;
        }

        token = token.trim();
        System.out.println("Password reset page requested with token: " + token);

        try {
            // Validate the token
            boolean isValidToken = passwordResetService.validateToken(token);

            if (isValidToken) {
                System.out.println("Valid token provided for password reset");

                // Get any flash messages
                String flashMessage = SessionUtil.getAndClearFlashMessage(request);
                if (flashMessage != null) {
                    String[] parts = flashMessage.split(":", 2);
                    if (parts.length == 2) {
                        request.setAttribute("messageType", parts[0]);
                        request.setAttribute("message", parts[1]);
                    }
                }

                // Set token for the form
                request.setAttribute("token", token);

                // Forward to reset password page
                request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
            } else {
                System.out.println("Invalid or expired token: " + token);
                redirectToForgotPassword(request, response, "This reset link is invalid or has expired. Please request a new password reset.");
            }

        } catch (Exception e) {
            System.err.println("Error validating reset token: " + e.getMessage());
            e.printStackTrace();
            redirectToForgotPassword(request, response, "An error occurred. Please try requesting a new password reset.");
        }
    }

    /**
     * POST request - Handle password reset form submission
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ResetPasswordController POST request received");

        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic validation
        if (token == null || token.trim().isEmpty()) {
            handleError(request, response, "Invalid reset token", token);
            return;
        }

        if (newPassword == null || newPassword.trim().isEmpty()) {
            handleError(request, response, "Please enter a new password", token);
            return;
        }

        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            handleError(request, response, "Please confirm your password", token);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            handleError(request, response, "Passwords do not match", token);
            return;
        }

        // Password strength validation
        if (newPassword.length() < 8) {
            handleError(request, response, "Password must be at least 8 characters long", token);
            return;
        }

        token = token.trim();
        System.out.println("Password reset attempt with token: " + token);

        try {
            // Create password reset request
            PasswordResetRequest resetRequest = new PasswordResetRequest(token, newPassword, confirmPassword);

            // Reset the password
            boolean success = passwordResetService.resetPassword(resetRequest);

            if (success) {
                System.out.println("Password reset successful for token: " + token);

                // Set success flash message and redirect to login
                SessionUtil.setFlashMessage(request, "success", "Your password has been reset successfully. Please log in with your new password.");

                String contextPath = request.getContextPath();
                response.sendRedirect(contextPath + "/login");
            } else {
                System.out.println("Password reset failed for token: " + token);
                handleError(request, response, "Failed to reset password. The reset link may have expired.", token);
            }

        } catch (Exception e) {
            System.err.println("Error resetting password: " + e.getMessage());
            e.printStackTrace();
            handleError(request, response, "An error occurred while resetting your password. Please try again.", token);
        }
    }

    /**
     * Handle error cases
     */
    private void handleError(HttpServletRequest request, HttpServletResponse response, String errorMessage, String token)
            throws ServletException, IOException {

        System.out.println("Reset password error: " + errorMessage);

        request.setAttribute("messageType", "danger");
        request.setAttribute("message", errorMessage);
        request.setAttribute("token", token);

        // Forward back to reset password page
        request.getRequestDispatcher("/WEB-INF/views/reset-password.jsp").forward(request, response);
    }

    /**
     * Redirect to forgot password page with error message
     */
    private void redirectToForgotPassword(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws IOException {

        System.out.println("Redirecting to forgot password with error: " + errorMessage);

        SessionUtil.setFlashMessage(request, "danger", errorMessage);

        String contextPath = request.getContextPath();
        response.sendRedirect(contextPath + "/forgot-password");
    }

    @Override
    public void destroy() {
        super.destroy();
        System.out.println("ResetPasswordController destroyed");
    }
}