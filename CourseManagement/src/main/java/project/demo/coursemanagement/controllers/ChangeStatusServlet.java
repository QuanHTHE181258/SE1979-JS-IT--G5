package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.service.CourseService;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet for changing course status via AJAX
 */
@WebServlet(name = "ChangeStatusServlet", urlPatterns = {"/change-status"})
public class ChangeStatusServlet extends HttpServlet {

    private CourseService courseService;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            this.courseService = new CourseService();
            System.out.println("ChangeStatusServlet initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing ChangeStatusServlet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Failed to initialize servlet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            // Check if user is logged in
            User user = (User) request.getSession().getAttribute("loggedInUser");
            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.write("{\"success\": false, \"message\": \"Unauthorized access\"}");
                return;
            }

            // Get parameters
            String courseIdStr = request.getParameter("courseId");
            String newStatus = request.getParameter("status");

            // Validate parameters
            if (courseIdStr == null || courseIdStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"success\": false, \"message\": \"Course ID is required\"}");
                return;
            }

            if (newStatus == null || newStatus.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"success\": false, \"message\": \"Status is required\"}");
                return;
            }

            // Validate status values
            if (!newStatus.equals("active") && !newStatus.equals("draft")) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"success\": false, \"message\": \"Invalid status. Must be 'active' or 'draft'\"}");
                return;
            }

            Long courseId;
            try {
                courseId = Long.parseLong(courseIdStr);
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"success\": false, \"message\": \"Invalid course ID format\"}");
                return;
            }

            // Update course status
            boolean success = courseService.updateCourseStatus(courseId, newStatus);

            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                out.write("{\"success\": true, \"message\": \"Course status updated successfully\", \"newStatus\": \"" + newStatus + "\"}");
                response.sendRedirect(request.getContextPath() + "/view-all");
                System.out.println("Successfully updated course " + courseId + " status to " + newStatus);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.write("{\"success\": false, \"message\": \"Failed to update course status\"}");
                System.err.println("Failed to update course " + courseId + " status to " + newStatus);
            }

        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
            System.err.println("Invalid argument: " + e.getMessage());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"success\": false, \"message\": \"Internal server error: " + e.getMessage() + "\"}");
            System.err.println("Error in ChangeStatusServlet: " + e.getMessage());
            e.printStackTrace();
        } finally {
            out.flush();
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        response.getWriter().write("{\"success\": false, \"message\": \"GET method not allowed\"}");
    }

    @Override
    public void destroy() {
        super.destroy();
        System.out.println("ChangeStatusServlet destroyed");
    }
}