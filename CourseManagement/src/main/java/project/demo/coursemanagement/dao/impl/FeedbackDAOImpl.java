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

    public Feedback getFeedbackByUserAndCourse(int userId, int courseId) {
        String sql = "SELECT * FROM feedback WHERE UserID = ? AND CourseID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("FeedbackID"));
                // You may need to set Course and User objects here if needed
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                return feedback;
            }
        } catch (SQLException e) {
            System.out.println("Error in FeedbackDAO.getFeedbackByUserAndCourse: " + e.getMessage());
        }
        return null;
    }

    public boolean updateFeedback(Feedback feedback) {
        String sql = "UPDATE feedback SET Rating = ?, Comment = ?, CreatedAt = GETDATE() WHERE FeedbackID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, feedback.getRating());
            ps.setString(2, feedback.getComment());
            ps.setInt(3, feedback.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error in FeedbackDAO.updateFeedback: " + e.getMessage());
            return false;
        }
    }
}
