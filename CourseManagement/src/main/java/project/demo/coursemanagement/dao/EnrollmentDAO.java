package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EnrollmentDAO {

    public static int getCurrentProgress(int studentId, int courseId) throws Exception {
        String sql = "SELECT progress_percentage FROM enrollments WHERE student_id = ? AND course_id = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("progress_percentage");
            }
        }
        return 0;
    }

    public static void updateProgressPercentage(int userId, int courseId, int newProgress) throws Exception {
        String sql = "UPDATE enrollments SET progress_percentage = ?, status = ? WHERE student_id = ? AND course_id = ?";

        String newStatus = newProgress >= 90 ? "completed" : "in_progress";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newProgress);
            ps.setString(2, newStatus);
            ps.setInt(3, userId);
            ps.setInt(4, courseId);

            ps.executeUpdate();
        }
    }

}
