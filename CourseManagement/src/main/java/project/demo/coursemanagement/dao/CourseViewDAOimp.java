package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Category;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementation of the CourseViewDAO interface
 */
public class CourseViewDAOimp implements CourseViewDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public Cours getCourseById(int id) {
        Cours course = null;

        try {
            conn = dbConn.getConnection();
            String sql = """
                SELECT c.*, u.user_id, u.username, cat.category_id, cat.category_name, cat.description as cat_description
                FROM Courses c
                JOIN Users u ON c.teacher_id = u.user_id
                JOIN Categories cat ON c.category_id = cat.category_id
                WHERE c.course_id = ?
            """;
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                course = new Cours();
                course.setId(rs.getInt("course_id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setTitle(rs.getString("title"));
                course.setDescription(rs.getString("description"));
                course.setShortDescription(rs.getString("short_description"));
                course.setImageUrl(rs.getString("image_url"));
                course.setPrice(rs.getBigDecimal("price"));
                course.setDurationHours(rs.getInt("duration_hours"));
                course.setLevel(rs.getString("level"));
                course.setIsPublished(rs.getBoolean("is_published"));
                course.setIsActive(rs.getBoolean("is_active"));
                course.setMaxStudents(rs.getInt("max_students"));

                Timestamp startDate = rs.getTimestamp("start_date");
                if (startDate != null) {
                    course.setStartDate(startDate.toInstant());
                }

                Timestamp endDate = rs.getTimestamp("end_date");
                if (endDate != null) {
                    course.setEndDate(endDate.toInstant());
                }

                Timestamp enrollmentStartDate = rs.getTimestamp("enrollment_start_date");
                if (enrollmentStartDate != null) {
                    course.setEnrollmentStartDate(enrollmentStartDate.toInstant());
                }

                Timestamp enrollmentEndDate = rs.getTimestamp("enrollment_end_date");
                if (enrollmentEndDate != null) {
                    course.setEnrollmentEndDate(enrollmentEndDate.toInstant());
                }

                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    course.setCreatedAt(createdAt.toInstant());
                }

                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) {
                    course.setUpdatedAt(updatedAt.toInstant());
                }

                // Set teacher
                User teacher = new User();
                teacher.setId(rs.getInt("user_id"));
                teacher.setUsername(rs.getString("username"));
                course.setTeacher(teacher);

                // Set category
                Category category = new Category();
                category.setId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("cat_description"));
                course.setCategory(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) dbConn.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return course;
    }
    @Override
    public List<CourseDTO> getAllCourses() {
        List<CourseDTO> courses = new ArrayList<>();

        try {
            conn = dbConn.getConnection();
            String sql = """
            SELECT  c.course_id, c.course_code, c.title, c.short_description, u.username, c.price,
                    c.duration_hours, c.max_students, c.start_date, c.end_date
            FROM Courses c
            JOIN Users u ON c.teacher_id = u.user_id 
            """;
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO course = extractCourseFromResultSet(rs);
                courses.add(course);
            }
            System.out.println("Number of courses retrieved: " + courses.size());
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error retrieving courses: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) dbConn.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return courses;
    }

    public List<CourseDTO> getCoursesByPage(int page, int size) {
        List<CourseDTO> courses = new ArrayList<>();
        try {
            conn = dbConn.getConnection();
            String sql = """
            SELECT DISTINCT c.course_id, c.course_code, c.title, c.short_description, u.username, c.price,
                    c.duration_hours, c.max_students, c.start_date, c.end_date
            FROM Courses c
            JOIN Users u ON c.teacher_id = u.user_id 
            ORDER BY c.course_code
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;
            ps = conn.prepareStatement(sql);
            ps.setInt(1, (page - 1) * size);
            ps.setInt(2, size);
            rs = ps.executeQuery();

            while (rs.next()) {
                CourseDTO course = extractCourseFromResultSet(rs);
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) dbConn.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return courses;
    }

    public int getTotalCourseCount() {
        int count = 0;
        try {
            conn = dbConn.getConnection();
            String sql = "SELECT COUNT(*) FROM Courses";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) dbConn.closeConnection(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return count;
    }

    private CourseDTO extractCourseFromResultSet(ResultSet rs) throws SQLException {
        try {
            CourseDTO course = new CourseDTO();
            course.setId(rs.getInt("course_id"));
            course.setCourseCode(rs.getString("course_code"));
            course.setTitle(rs.getString("title"));
            course.setShortDescription(rs.getString("short_description"));
            course.setTeacherUsername(rs.getString("username"));
            course.setPrice(rs.getBigDecimal("price"));
            course.setDurationHours(rs.getInt("duration_hours"));
            course.setMaxStudents(rs.getInt("max_students"));
            Timestamp startDate = rs.getTimestamp("start_date");
            course.setStartDate(startDate != null ? startDate.toInstant() : null);
            Timestamp endDate = rs.getTimestamp("end_date");
            course.setEndDate(endDate != null ? endDate.toInstant() : null);
            return course;
        }catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error extracting course from result set: " + e.getMessage());
            throw e;
        }
    }

    public static void main(String[] args) {
        DatabaseConnection dbConn = DatabaseConnection.getInstance();
        boolean isConnected = dbConn.testConnection();
        System.out.println("Database connection successful: " + isConnected);
    }
}
