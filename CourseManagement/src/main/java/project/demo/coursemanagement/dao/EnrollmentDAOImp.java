package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.EnrolledCourse;
import project.demo.coursemanagement.entities.Category;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.Enrollment;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentDAOImp implements EnrollmentDAO {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private final DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public Enrollment getEnrollment(int enrollmentId) {
        Enrollment enrollment = null;

        try {
            conn = dbConn.getConnection();
            String sql = """
                SELECT e.*, u.username, c.course_code, c.title
                FROM Enrollments e
                JOIN Users u ON e.student_id = u.user_id
                JOIN Courses c ON e.course_id = c.course_id
                WHERE e.enrollment_id = ?
            """;
            ps = conn.prepareStatement(sql);
            ps.setInt(1, enrollmentId);
            rs = ps.executeQuery();

            if (rs.next()) {
                enrollment = new Enrollment();
                enrollment.setId(rs.getInt("enrollment_id"));

                // Set student
                User student = new User();
                student.setId(rs.getInt("student_id"));
                student.setUsername(rs.getString("username"));
                enrollment.setStudent(student);

                // Set course
                Cours course = new Cours();
                course.setId(rs.getInt("course_id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setTitle(rs.getString("title"));
                enrollment.setCourse(course);

                // Set enrollment details
                Timestamp enrollmentDate = rs.getTimestamp("enrollment_date");
                if (enrollmentDate != null) {
                    enrollment.setEnrollmentDate(enrollmentDate.toInstant());
                }

                Timestamp completionDate = rs.getTimestamp("completion_date");
                if (completionDate != null) {
                    enrollment.setCompletionDate(completionDate.toInstant());
                }

                enrollment.setProgressPercentage(rs.getBigDecimal("progress_percentage"));
                enrollment.setStatus(rs.getString("status"));
                enrollment.setGrade(rs.getBigDecimal("grade"));
                enrollment.setCertificateIssued(rs.getBoolean("certificate_issued"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return enrollment;
    }

    @Override
    public List<Enrollment> getEnrollmentsByUser(int userId) {
        List<Enrollment> enrollments = new ArrayList<>();

        try {
            conn = dbConn.getConnection();
            String sql = """
                SELECT e.*, c.course_code, c.title, u.username
                FROM Enrollments e
                JOIN Courses c ON e.course_id = c.course_id
                JOIN Users u ON e.student_id = u.user_id
                WHERE e.student_id = ?
            """;
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Enrollment enrollment = new Enrollment();
                enrollment.setId(rs.getInt("enrollment_id"));

                // Set student
                User student = new User();
                student.setId(userId);
                student.setUsername(rs.getString("username"));
                enrollment.setStudent(student);

                // Set course
                Cours course = new Cours();
                course.setId(rs.getInt("course_id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setTitle(rs.getString("title"));
                enrollment.setCourse(course);

                // Set enrollment details
                Timestamp enrollmentDate = rs.getTimestamp("enrollment_date");
                if (enrollmentDate != null) {
                    enrollment.setEnrollmentDate(enrollmentDate.toInstant());
                }

                Timestamp completionDate = rs.getTimestamp("completion_date");
                if (completionDate != null) {
                    enrollment.setCompletionDate(completionDate.toInstant());
                }

                enrollment.setProgressPercentage(rs.getBigDecimal("progress_percentage"));
                enrollment.setStatus(rs.getString("status"));
                enrollment.setGrade(rs.getBigDecimal("grade"));
                enrollment.setCertificateIssued(rs.getBoolean("certificate_issued"));

                enrollments.add(enrollment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return enrollments;
    }

    @Override
    public boolean isUserEnrolledInCourse(int userId, int courseId) {
        boolean isEnrolled = false;

        try {
            conn = dbConn.getConnection();
            String sql = "SELECT COUNT(*) FROM Enrollments WHERE student_id = ? AND course_id = ? AND status != 'DROPPED'";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            rs = ps.executeQuery();

            if (rs.next()) {
                isEnrolled = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return isEnrolled;
    }

    @Override
    public boolean enrollUserInCourse(int userId, int courseId) {
        try {
            conn = dbConn.getConnection();

            // Check if enrollment already exists
            String checkSql = "SELECT COUNT(*) FROM Enrollments WHERE student_id = ? AND course_id = ?";
            ps = conn.prepareStatement(checkSql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                return false; // Already enrolled
            }

            // Create new enrollment
            String insertSql = "INSERT INTO Enrollments (student_id, course_id, grade, progress_percentage, enrollment_date, status) VALUES (?, ?, ?, ?, GETDATE(), ?)";
            ps = conn.prepareStatement(insertSql);
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            ps.setBigDecimal(3, new BigDecimal(0));
            ps.setBigDecimal(4, new BigDecimal(0));
            ps.setString(5, "ACTIVE");

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources();
        }
    }

    @Override
    public List<EnrolledCourse> getEnrolledCoursesByUser(int userId) {
        List<EnrolledCourse> enrolledCourses = new ArrayList<>();

        try {
            conn = dbConn.getConnection();
            String sql = """
                SELECT e.enrollment_id, e.course_id, e.enrollment_date, e.progress_percentage, e.status, e.grade,
                       c.course_code, c.title, c.image_url, c.duration_hours,
                       cat.category_id, cat.category_name, cat.description as cat_description
                FROM Enrollments e
                JOIN Courses c ON e.course_id = c.course_id
                LEFT JOIN Categories cat ON c.category_id = cat.category_id
                WHERE e.student_id = ?
            """;
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                EnrolledCourse enrolledCourse = new EnrolledCourse();

                // Set course information
                enrolledCourse.setId(rs.getInt("course_id"));
                enrolledCourse.setCourseCode(rs.getString("course_code"));
                enrolledCourse.setTitle(rs.getString("title"));
                enrolledCourse.setImageUrl(rs.getString("image_url"));
                enrolledCourse.setDurationHours(rs.getInt("duration_hours"));

                // Set category if available
                int categoryId = rs.getInt("category_id");
                if (!rs.wasNull()) {
                    Category category = new Category();
                    category.setId(categoryId);
                    category.setCategoryName(rs.getString("category_name"));
                    category.setDescription(rs.getString("cat_description"));
                    enrolledCourse.setCategory(category);
                }

                // Set enrollment specific information
                Timestamp enrollmentDate = rs.getTimestamp("enrollment_date");
                if (enrollmentDate != null) {
                    enrolledCourse.setEnrollmentStartDate(
                        LocalDateTime.ofInstant(enrollmentDate.toInstant(), java.time.ZoneId.systemDefault())
                    );
                }

                enrolledCourse.setProgressPercentage(rs.getBigDecimal("progress_percentage"));
                enrolledCourse.setGrade(rs.getBigDecimal("grade"));
                enrolledCourse.setStatus(rs.getString("status"));

                enrolledCourses.add(enrolledCourse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return enrolledCourses;
    }

    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) dbConn.closeConnection(conn);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}