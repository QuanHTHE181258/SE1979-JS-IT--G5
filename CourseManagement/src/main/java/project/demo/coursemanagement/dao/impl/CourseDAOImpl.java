package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAOImpl implements CourseDAO {
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public void deleteCourseByCode(String courseCode) {
        String sql = "DELETE FROM courses WHERE course_code = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, courseCode);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<CourseDTO> getCoursesForManager(String keyword, Integer categoryId, int page, int pageSize) {
        List<CourseDTO> courseList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
        SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating,
               c.InstructorID, u.Username AS teacher_username,
               c.CategoryID, c.ImageURL, c.CreatedAt
        FROM courses c
        JOIN users u ON c.InstructorID = u.UserID
        WHERE 1=1
    """);
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND c.Title LIKE ? ");
        }
        if (categoryId != null) {
            sql.append(" AND c.CategoryID = ? ");
        }
        sql.append(" ORDER BY c.CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
            }
            if (categoryId != null) {
                ps.setInt(paramIndex++, categoryId);
            }
            int offset = (page - 1) * pageSize;
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CourseDTO course = new CourseDTO();
                    course.setCourseCode(rs.getString("CourseID"));
                    course.setTitle(rs.getString("Title"));
                    course.setDescription(rs.getString("Description"));
                    course.setTeacherId(rs.getInt("InstructorID"));
                    course.setTeacherUsername(rs.getString("teacher_username"));
                    course.setCategoryId(rs.getInt("CategoryID"));
                    course.setImageUrl(rs.getString("ImageURL"));
                    course.setPrice(rs.getBigDecimal("Price"));
                    Timestamp createdAt = rs.getTimestamp("CreatedAt");
                    if (createdAt != null) {
                        course.setCreatedAt(createdAt.toInstant());
                        course.setCreatedAtDate(java.util.Date.from(createdAt.toInstant()));
                    }
                    courseList.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting paginated course list: " + e.getMessage());
        }
        return courseList;
    }

    @Override
    public int countCourses(String keyword, Integer categoryId) {
        int total = 0;
        StringBuilder sql = new StringBuilder("""
        SELECT COUNT(*) AS total
        FROM courses c
        WHERE 1=1
    """);
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND c.Title LIKE ? ");
        }
        if (categoryId != null) {
            sql.append(" AND c.CategoryID = ? ");
        }
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
            }
            if (categoryId != null) {
                ps.setInt(paramIndex++, categoryId);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error counting courses: " + e.getMessage());
        }
        return total;
    }

    @Override
    public List<CourseDTO> getRecentCourses(int limit) {
        List<CourseDTO> recentCourses = new ArrayList<>();
        String sql = """
        SELECT TOP (?) c.CourseID, c.Title, c.InstructorID, u.Username AS teacher_username, c.CreatedAt, c.Status
        FROM courses c
        JOIN users u ON c.InstructorID = u.UserID
        WHERE c.Status IN ('active', 'draft', 'inactive', 'published')
        ORDER BY c.CreatedAt DESC
        """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CourseDTO course = new CourseDTO();
                    course.setCourseCode(rs.getString("CourseID"));
                    course.setTitle(rs.getString("Title"));
                    course.setTeacherId(rs.getInt("InstructorID"));
                    course.setTeacherUsername(rs.getString("teacher_username"));
                    course.setStatus(rs.getString("Status"));
                    Timestamp createdAt = rs.getTimestamp("CreatedAt");
                    if (createdAt != null) {
                        course.setCreatedAt(createdAt.toInstant());
                        course.setCreatedAtDate(java.util.Date.from(createdAt.toInstant()));
                    }
                    recentCourses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting recent courses: " + e.getMessage());
        }
        return recentCourses;
    }

    @Override
    public CourseDTO getCourseByCode(String courseCode) {
        String sql = """
        SELECT c.course_code, c.title, c.description, c.short_description, 
               c.teacher_id, u.username AS teacher_username,
               c.category_id, c.image_url, c.price, c.duration_hours,
               c.level, c.is_published, c.is_active, c.max_students,
               c.enrollment_start_date, c.enrollment_end_date,
               c.start_date, c.end_date
        FROM Courses c
        JOIN Users u ON c.teacher_id = u.user_id
        WHERE c.course_code = ?
    """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, courseCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CourseDTO course = new CourseDTO();
                    course.setCourseCode(rs.getString("course_code"));
                    course.setTitle(rs.getString("title"));
                    course.setDescription(rs.getString("description"));
                    course.setShortDescription(rs.getString("short_description"));
                    course.setTeacherId(rs.getInt("teacher_id"));
                    course.setTeacherUsername(rs.getString("teacher_username"));
                    course.setCategoryId(rs.getInt("category_id"));
                    course.setImageUrl(rs.getString("image_url"));
                    course.setPrice(rs.getBigDecimal("price"));
                    course.setDurationHours(rs.getInt("duration_hours"));
                    course.setLevel(rs.getString("level"));
                    course.setPublished(rs.getBoolean("is_published"));
                    course.setActive(rs.getBoolean("is_active"));
                    course.setMaxStudents(rs.getInt("max_students"));
                    Timestamp enrollmentStart = rs.getTimestamp("enrollment_start_date");
                    if (enrollmentStart != null) {
                        course.setEnrollmentStartDate(enrollmentStart.toInstant());
                    }
                    Timestamp enrollmentEnd = rs.getTimestamp("enrollment_end_date");
                    if (enrollmentEnd != null) {
                        course.setEnrollmentEndDate(enrollmentEnd.toInstant());
                    }
                    Timestamp startDate = rs.getTimestamp("start_date");
                    if (startDate != null) {
                        course.setStartDate(startDate.toInstant());
                    }
                    Timestamp endDate = rs.getTimestamp("end_date");
                    if (endDate != null) {
                        course.setEndDate(endDate.toInstant());
                    }
                    return course;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting course by code: " + e.getMessage());
        }
        return null;
    }

    @Override
    public boolean updateCourse(CourseDTO course) {
        String sql = """
        UPDATE Courses
        SET title = ?, description = ?, short_description = ?, teacher_id = ?, category_id = ?,
            image_url = ?, price = ?, duration_hours = ?, level = ?, is_published = ?, is_active = ?,
            max_students = ?, enrollment_start_date = ?, enrollment_end_date = ?,
            start_date = ?, end_date = ?, updated_at = GETDATE()
        WHERE course_code = ?
    """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setString(3, course.getShortDescription());
            ps.setInt(4, course.getTeacherId());
            ps.setInt(5, course.getCategoryId());
            ps.setString(6, course.getImageUrl());
            ps.setBigDecimal(7, course.getPrice());
            ps.setInt(8, course.getDurationHours());
            ps.setString(9, course.getLevel());
            ps.setBoolean(10, course.isPublished());
            ps.setBoolean(11, course.isActive());
            ps.setInt(12, course.getMaxStudents());
            if (course.getEnrollmentStartDate() != null) {
                ps.setTimestamp(13, Timestamp.from(course.getEnrollmentStartDate()));
            } else {
                ps.setNull(13, Types.TIMESTAMP);
            }
            if (course.getEnrollmentEndDate() != null) {
                ps.setTimestamp(14, Timestamp.from(course.getEnrollmentEndDate()));
            } else {
                ps.setNull(14, Types.TIMESTAMP);
            }
            if (course.getStartDate() != null) {
                ps.setTimestamp(15, Timestamp.from(course.getStartDate()));
            } else {
                ps.setNull(15, Types.TIMESTAMP);
            }
            if (course.getEndDate() != null) {
                ps.setTimestamp(16, Timestamp.from(course.getEndDate()));
            } else {
                ps.setNull(16, Types.TIMESTAMP);
            }
            ps.setString(17, course.getCourseCode());
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error updating course: " + e.getMessage());
            return false;
        }
    }

    @Override
    public List<CourseDTO> searchRecentCourses(String keyword, int limit) {
        List<CourseDTO> recentCourses = new ArrayList<>();
        String sql = """
        SELECT TOP (?) c.CourseID, c.Title, c.InstructorID, u.Username AS teacher_username, c.CreatedAt
        FROM courses c
        JOIN users u ON c.InstructorID = u.UserID
        WHERE c.Status = 'active' AND c.Title LIKE ?
        ORDER BY c.CreatedAt DESC
        """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setString(2, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CourseDTO course = new CourseDTO();
                    course.setCourseCode(rs.getString("CourseID"));
                    course.setTitle(rs.getString("Title"));
                    course.setTeacherId(rs.getInt("InstructorID"));
                    course.setTeacherUsername(rs.getString("teacher_username"));
                    Timestamp createdAt = rs.getTimestamp("CreatedAt");
                    if (createdAt != null) {
                        course.setCreatedAt(createdAt.toInstant());
                        course.setCreatedAtDate(java.util.Date.from(createdAt.toInstant()));
                    }
                    recentCourses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error searching recent courses: " + e.getMessage());
        }
        return recentCourses;
    }

    @Override
    public List<CourseDTO> getTopCourses(int limit) {
        List<CourseDTO> topCourses = new ArrayList<>();
        String sql = """
        SELECT TOP (?) c.CourseID, c.Title, c.InstructorID, u.Username AS teacher_username, 
               c.CategoryID, cat.Name AS category_name,
               COUNT(od.CourseID) AS enrollment_count
        FROM courses c
        JOIN users u ON c.InstructorID = u.UserID
        LEFT JOIN categories cat ON c.CategoryID = cat.CategoryID
        LEFT JOIN orderdetails od ON c.CourseID = od.CourseID
        GROUP BY c.CourseID, c.Title, c.InstructorID, u.Username, c.CategoryID, cat.Name
        ORDER BY enrollment_count DESC
    """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CourseDTO course = new CourseDTO();
                    course.setCourseCode(rs.getString("CourseID"));
                    course.setTitle(rs.getString("Title"));
                    course.setTeacherId(rs.getInt("InstructorID"));
                    course.setTeacherUsername(rs.getString("teacher_username"));
                    course.setCategoryId(rs.getInt("CategoryID"));
                    course.setEnrollmentCount(rs.getInt("enrollment_count"));
                    topCourses.add(course);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("Error getting top courses: " + e.getMessage());
        }
        return topCourses;
    }
} 