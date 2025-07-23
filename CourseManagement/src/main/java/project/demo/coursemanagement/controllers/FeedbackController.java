package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.demo.coursemanagement.dao.impl.CourseDAOImpl;
import project.demo.coursemanagement.dao.impl.FeedbackDAOImpl;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.Feedback;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;

@WebServlet(name = "FeedbackController", urlPatterns = {"/feedback"})
public class FeedbackController extends HttpServlet {

    private CourseDAOImpl courseDAO;
    private FeedbackDAOImpl feedbackDAO;

    @Override
    public void init() throws ServletException {
        courseDAO = new CourseDAOImpl();
        feedbackDAO = new FeedbackDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");
            String courseId = request.getParameter("courseId");
            CourseDTO course = courseDAO.getCourseByCode(courseId);
            Feedback feedback = null;
            if (user != null && courseId != null) {
                try {
                    int courseIdInt = Integer.parseInt(courseId);
                    feedback = feedbackDAO.getFeedbackByUserAndCourse(user.getId(), courseIdInt);
                } catch (Exception ex) {
                    // ignore parse error
                }
            }
            if (course != null) {
                request.setAttribute("course", course);
                request.setAttribute("feedback", feedback);
                request.getRequestDispatcher("/WEB-INF/views/feedback.jsp").forward(request, response);
            } else {
                response.sendRedirect("enrollments");
            }
        } catch (Exception e) {
            System.out.println("Error in FeedbackController: " + e.getMessage());
            response.sendRedirect("enrollments");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loggedInUser");
            String courseId = request.getParameter("courseId");
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            Feedback feedback = null;
            if (user != null && courseId != null) {
                int courseIdInt = Integer.parseInt(courseId);
                feedback = feedbackDAO.getFeedbackByUserAndCourse(user.getId(), courseIdInt);
            }
            Cours course = new Cours();
            course.setId(Integer.parseInt(courseId));
            if (feedback == null) {
                // Add new feedback
                feedback = new Feedback();
                feedback.setCourseID(course);
                feedback.setUserID(user);
                feedback.setRating(rating);
                feedback.setComment(comment);
                boolean success = feedbackDAO.addFeedback(feedback);
                if (success) {
                    response.sendRedirect("enrollments?message=feedback_success");
                } else {
                    response.sendRedirect("enrollments?error=feedback_failed");
                }
            } else {
                // Update feedback
                feedback.setRating(rating);
                feedback.setComment(comment);
                boolean success = feedbackDAO.updateFeedback(feedback);
                if (success) {
                    response.sendRedirect("enrollments?message=feedback_updated");
                } else {
                    response.sendRedirect("enrollments?error=feedback_update_failed");
                }
            }
        } catch (Exception e) {
            System.out.println("Error in FeedbackController.doPost: " + e.getMessage());
            response.sendRedirect("enrollments?error=system_error");
        }
    }
}
