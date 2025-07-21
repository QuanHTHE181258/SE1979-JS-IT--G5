package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.entities.Feedback;
import project.demo.coursemanagement.utils.DatabaseConnection;
import java.sql.*;

public class FeedbackDAOImpl {

    public boolean addFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedback (CourseID, UserID, Rating, Comment, CreatedAt) VALUES (?, ?, ?, ?, GETDATE())";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, feedback.getCourseID().getId());
            ps.setInt(2, feedback.getUserID().getId());
            ps.setInt(3, feedback.getRating());
            ps.setString(4, feedback.getComment());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("Error in FeedbackDAO.addFeedback: " + e.getMessage());
            return false;
        }
    }
}
