package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.Enrollment;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAOImpl {
    public List<Enrollment> getEnrollmentsByStudentId(int studentId) {
        List<Enrollment> enrollments = new ArrayList<>();
        String sql = "SELECT e.*, c.Title, c.Description, c.Price, c.Rating, c.CreatedAt, c.ImageURL, c.InstructorID, c.CategoryID, c.Status as courseStatus " +
                "FROM enrollments e " +
                "JOIN courses c ON e.course_id = c.CourseID " +
                "WHERE e.student_id = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Enrollment enrollment = new Enrollment();
                    enrollment.setId(rs.getInt("enrollment_id"));
                    // Set User (student)
                    User student = new User();
                    student.setId(rs.getInt("student_id"));
                    enrollment.setStudent(student);
                    // Set Course
                    Cours course = new Cours();
                    course.setId(rs.getInt("course_id"));
                    course.setTitle(rs.getString("Title"));
                    course.setDescription(rs.getString("Description"));
                    course.setPrice(rs.getBigDecimal("Price"));
                    course.setRating(rs.getDouble("Rating"));
                    course.setCreatedAt(rs.getTimestamp("CreatedAt") != null ? rs.getTimestamp("CreatedAt").toInstant() : null);
                    course.setImageURL(rs.getString("ImageURL"));
                    course.setStatus(rs.getString("courseStatus"));
                    enrollment.setCourse(course);
                    // Enrollment fields
                    enrollment.setEnrollmentDate(rs.getTimestamp("enrollment_date") != null ? rs.getTimestamp("enrollment_date").toInstant() : null);
                    enrollment.setCompletionDate(rs.getTimestamp("completion_date") != null ? rs.getTimestamp("completion_date").toInstant() : null);
                    enrollment.setProgressPercentage(rs.getBigDecimal("progress_percentage"));
                    enrollment.setStatus(rs.getString("status"));
                    enrollment.setGrade(rs.getBigDecimal("grade"));
                    enrollment.setCertificateIssued(rs.getBoolean("certificate_issued"));
                    enrollments.add(enrollment);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return enrollments;
    }
}
