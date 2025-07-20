package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet for handling user logout
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        System.out.println("LogoutServlet initialized");
    }

    /**
     * Handle GET requests - Process logout
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("LogoutServlet GET request received");
        processLogout(request, response);
    }

    /**
     * Handle POST requests - Process logout
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("LogoutServlet POST request received");
        processLogout(request, response);
    }

    /**
     * Process logout functionality
     */
    private void processLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get current user info before clearing session
            String currentUser = SessionUtil.getUsername(request);
            String userRole = SessionUtil.getUserRole(request);

            if (currentUser != null) {
                System.out.println("Processing logout for user: " + currentUser + " (Role: " + userRole + ")");

                // Clear user session
                SessionUtil.clearUserSession(request);

                // Set logout success message
                SessionUtil.setFlashMessage(request, "success", "You have been successfully logged out. See you again!");

                System.out.println("Logout successful for user: " + currentUser);

            } else {
                System.out.println("Logout request from user with no active session");

                // Set info message for users without active session
                SessionUtil.setFlashMessage(request, "info", "You were not logged in.");
            }

            // Redirect to login page
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/login");

        } catch (Exception e) {
            // Handle unexpected errors during logout
            System.err.println("Error during logout: " + e.getMessage());
            e.printStackTrace();

            // Try to clear session anyway
            try {
                SessionUtil.clearUserSession(request);
            } catch (Exception clearError) {
                System.err.println("Error clearing session: " + clearError.getMessage());
            }

            // Set error message
            SessionUtil.setFlashMessage(request, "error", "An error occurred during logout, but you have been logged out.");

            // Redirect to login page
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/login");
        }
    }

    @Override
    public void destroy() {
        super.destroy();
        System.out.println("LogoutServlet destroyed");
    }
}