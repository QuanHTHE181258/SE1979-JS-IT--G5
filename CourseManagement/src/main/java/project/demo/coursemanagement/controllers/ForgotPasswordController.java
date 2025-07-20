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
 * Controller for handling forgot password functionality
 */
@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordController extends HttpServlet {

    private PasswordResetService passwordResetService;

    @Override
    public void init() throws ServletException {
        super.init();
        passwordResetService = new PasswordResetService();
        System.out.println("ForgotPasswordController initialized");
    }

    /**
     * GET request - Display forgot password page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ForgotPasswordController GET request received");

        // Check if user is already logged in - redirect to dashboard if so
        if (SessionUtil.isUserLoggedIn(request)) {
            System.out.println("User already logged in, redirecting to dashboard");
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/dashboard");
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

        // Forward to forgot password page
        request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
    }

    /**
     * POST request - Handle forgot password form submission
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("ForgotPasswordController POST request received");

        String email = request.getParameter("email");

        // Basic validation
        if (email == null || email.trim().isEmpty()) {
            handleError(request, response, "Please enter your email address");
            return;
        }

        email = email.trim();

        // Validate email format
        if (!isValidEmail(email)) {
            handleError(request, response, "Please enter a valid email address");
            return;
        }

        System.out.println("Password reset requested for email: " + email);

        try {
            // Get base URL for reset link
            String baseUrl = getBaseUrl(request);

            // Request password reset
            boolean success = passwordResetService.requestPasswordReset(email, baseUrl);

            if (success) {
                System.out.println("Password reset email sent successfully to: " + email);
                handleSuccess(request, response, "If this email address exists in our system, you will receive a password reset link shortly.");
            } else {
                System.out.println("Failed to send password reset email to: " + email);
                // Still show success message to prevent email enumeration
                handleSuccess(request, response, "If this email address exists in our system, you will receive a password reset link shortly.");
            }

        } catch (Exception e) {
            System.err.println("Error processing password reset request: " + e.getMessage());
            e.printStackTrace();
            handleError(request, response, "An error occurred while processing your request. Please try again later.");
        }
    }

    /**
     * Handle error cases
     */
    private void handleError(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws ServletException, IOException {

        System.out.println("Forgot password error: " + errorMessage);

        request.setAttribute("messageType", "danger");
        request.setAttribute("message", errorMessage);

        // Preserve the entered email
        String email = request.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            request.setAttribute("email", email.trim());
        }

        // Forward back to forgot password page
        request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
    }

    /**
     * Handle success cases
     */
    private void handleSuccess(HttpServletRequest request, HttpServletResponse response, String successMessage)
            throws ServletException, IOException {

        System.out.println("Forgot password success: " + successMessage);

        request.setAttribute("messageType", "success");
        request.setAttribute("message", successMessage);

        // Forward to forgot password page with success message
        request.getRequestDispatcher("/WEB-INF/views/forgot-password.jsp").forward(request, response);
    }

    /**
     * Get base URL for the application
     */
    private String getBaseUrl(HttpServletRequest request) {
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();
        String contextPath = request.getContextPath();

        StringBuilder baseUrl = new StringBuilder();
        baseUrl.append(scheme).append("://").append(serverName);

        // Only append port if it's not the default port for the scheme
        if ((scheme.equals("http") && serverPort != 80) ||
                (scheme.equals("https") && serverPort != 443)) {
            baseUrl.append(":").append(serverPort);
        }

        baseUrl.append(contextPath);

        System.out.println("Base URL: " + baseUrl.toString());
        return baseUrl.toString();
    }

    /**
     * Simple email validation
     */
    private boolean isValidEmail(String email) {
        return email != null &&
                email.contains("@") &&
                email.contains(".") &&
                email.length() > 5 &&
                email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    }

    @Override
    public void destroy() {
        super.destroy();
        System.out.println("ForgotPasswordController destroyed");
    }
}