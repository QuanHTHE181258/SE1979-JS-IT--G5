package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dto.CourseStatsDTO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Category;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAOImpl implements CourseDAO {
    DatabaseConnection dbConn = DatabaseConnection.getInstance();


    @Override
    public List<CourseStatsDTO> getAllCoursesWithStats() {
        List<CourseStatsDTO> courses = new ArrayList<>();

        String sql = """
        SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating, c.CreatedAt, c.ImageURL,
            cat.CategoryID, cat.Name as CategoryName,
            u.UserID as InstructorID, u.FirstName as InstructorFirstName, u.LastName as InstructorLastName,
            (SELECT COUNT(*) FROM feedback f WHERE f.CourseID = c.CourseID) AS FeedbackCount,
            (SELECT COUNT(*) FROM materials m
                JOIN lessons l ON m.LessonID = l.LessonID
                WHERE l.CourseID = c.CourseID) AS MaterialCount,
            (SELECT COUNT(*) FROM quizzes q
                JOIN lessons l ON q.LessonID = l.LessonID
                WHERE l.CourseID = c.CourseID) AS QuizCount,
            (SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.CourseID) AS EnrollmentCount
        FROM Courses c
        LEFT JOIN categories cat ON c.CategoryID = cat.CategoryID
        LEFT JOIN users u ON c.InstructorID = u.UserID
        ORDER BY c.CreatedAt DESC
    """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CourseStatsDTO course = new CourseStatsDTO(
                        rs.getLong("CourseID"),
                        rs.getString("Title"),
                        rs.getString("Description"),
                        rs.getBigDecimal("Price"),
                        rs.getDouble("Rating"),
                        rs.getTimestamp("CreatedAt").toInstant(),
                        rs.getString("ImageURL"),
                        rs.getLong("FeedbackCount"),
                        rs.getLong("MaterialCount"),
                        rs.getLong("QuizCount"),
                        rs.getLong("EnrollmentCount"),
                        rs.getLong("CategoryID"),
                        rs.getString("CategoryName"),
                        rs.getLong("InstructorID"),
                        rs.getString("InstructorFirstName"),
                        rs.getString("InstructorLastName")
                );
                courses.add(course);
            }

        } catch (SQLException e) {
            System.err.println("Error in getAllCoursesWithStats: " + e.getMessage());
            e.printStackTrace();
        }

        return courses;
    }

    @Override
    public List<CourseStatsDTO> getCoursesByCategory(Long categoryId) {
        List<CourseStatsDTO> courses = new ArrayList<>();

        String sql = """
        SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating, c.CreatedAt, c.ImageURL,
            cat.CategoryID, cat.Name as CategoryName,
            u.UserID as InstructorID, u.FirstName as InstructorFirstName, u.LastName as InstructorLastName,
            (SELECT COUNT(*) FROM feedback f WHERE f.CourseID = c.CourseID) AS FeedbackCount,
            (SELECT COUNT(*) FROM materials m
                JOIN lessons l ON m.LessonID = l.LessonID
                WHERE l.CourseID = c.CourseID) AS MaterialCount,
            (SELECT COUNT(*) FROM quizzes q
                JOIN lessons l ON q.LessonID = l.LessonID
                WHERE l.CourseID = c.CourseID) AS QuizCount,
            (SELECT COUNT(*) FROM enrollments e WHERE e.course_id = c.CourseID) AS EnrollmentCount
        FROM Courses c
        LEFT JOIN categories cat ON c.CategoryID = cat.CategoryID
        LEFT JOIN users u ON c.InstructorID = u.UserID
        WHERE c.CategoryID = ?
        ORDER BY c.CreatedAt DESC
        """;

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, categoryId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CourseStatsDTO course = new CourseStatsDTO(
                            rs.getLong("CourseID"),
                            rs.getString("Title"),
                            rs.getString("Description"),
                            rs.getBigDecimal("Price"),
                            rs.getDouble("Rating"),
                            rs.getTimestamp("CreatedAt").toInstant(),
                            rs.getString("ImageURL"),
                            rs.getLong("FeedbackCount"),
                            rs.getLong("MaterialCount"),
                            rs.getLong("QuizCount"),
                            rs.getLong("EnrollmentCount"),
                            rs.getLong("CategoryID"),
                            rs.getString("CategoryName"),
                            rs.getLong("InstructorID"),
                            rs.getString("InstructorFirstName"),
                            rs.getString("InstructorLastName")
                    );
                    courses.add(course);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error in getCoursesByCategory: " + e.getMessage());
            e.printStackTrace();
        }

        return courses;
    }

    @Override
    public boolean insertCourse(Cours course) {
        String sql = "INSERT INTO courses (Title, Description, Price, ImageURL, InstructorID, CategoryID, Status, CreatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, course.getTitle());
            stmt.setString(2, course.getDescription());
            stmt.setBigDecimal(3, course.getPrice());
            stmt.setString(4, course.getImageURL());
            stmt.setLong(5, course.getInstructorID() != null ? course.getInstructorID().getId() : null);
            stmt.setInt(6, course.getCategory() != null ? course.getCategory().getId() : null);
            stmt.setString(7, course.getStatus() == null ? "active" : course.getStatus());
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateCourse(Cours course) {
        String sql = "UPDATE courses SET Title=?, Description=?, Price=?, ImageURL=?, InstructorID=?, CategoryID=?, Status=? WHERE CourseID=?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, course.getTitle());
            stmt.setString(2, course.getDescription());
            stmt.setBigDecimal(3, course.getPrice());
            stmt.setString(4, course.getImageURL());
            stmt.setLong(5, course.getInstructorID() != null ? course.getInstructorID().getId() : null);
            stmt.setLong(6, course.getCategory() != null ? course.getCategory().getId() : null);
            stmt.setString(7, course.getStatus() == null ? "active" : course.getStatus());
            stmt.setInt(8, course.getId());
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Cours> getCoursesByInstructorId(Integer instructorId) {
        List<Cours> list = new ArrayList<>();
        String sql = "SELECT CourseID, Title, Description, Price, Rating, CreatedAt, ImageURL, InstructorID, CategoryID, Status FROM courses WHERE InstructorID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, instructorId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Cours c = new Cours();
                    c.setId(rs.getInt("CourseID"));
                    c.setTitle(rs.getString("Title"));
                    c.setDescription(rs.getString("Description"));
                    c.setPrice(rs.getBigDecimal("Price"));
                    c.setRating(rs.getDouble("Rating"));
                    c.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                    c.setImageURL(rs.getString("ImageURL"));
                    c.setStatus(rs.getString("Status"));
                    list.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


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
        SELECT TOP (?) c.CourseID, c.Title, c.InstructorID, u.Username AS teacher_username, c.CreatedAt
        FROM courses c
        JOIN users u ON c.InstructorID = u.UserID
        WHERE c.Status = 'active'
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
        SELECT c.CourseID as course_code, c.Title as title, c.Description as description, c.Description as short_description, 
               c.InstructorID as teacher_id, u.Username AS teacher_username,
               c.CategoryID as category_id, c.ImageURL as image_url, c.Price as price, 0 as duration_hours,
               'Beginner' as level, 1 as is_published, 1 as is_active, 100 as max_students,
               c.CreatedAt as enrollment_start_date, c.CreatedAt as enrollment_end_date,
               c.CreatedAt as start_date, c.CreatedAt as end_date
        FROM Courses c
        JOIN Users u ON c.InstructorID = u.UserID
        WHERE c.CourseID = ?
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
        SET Title = ?, Description = ?, Price = ?, ImageURL = ?, InstructorID = ?, CategoryID = ?
        WHERE CourseID = ?
    """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, course.getTitle());
            ps.setString(2, course.getDescription());
            ps.setBigDecimal(3, course.getPrice());
            ps.setString(4, course.getImageUrl());
            ps.setInt(5, course.getTeacherId());
            ps.setInt(6, course.getCategoryId());
            ps.setString(7, course.getCourseCode());
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

    public List<Cours> getEnrolledCoursesByStudentId(int studentId) {
        List<Cours> courses = new ArrayList<>();
        String sql = "SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating, c.CreatedAt, c.ImageURL, c.InstructorID, c.CategoryID, c.Status " +
                "FROM enrollments e " +
                "JOIN courses c ON e.CourseID = c.CourseID " +
                "WHERE e.Student_ID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Cours course = new Cours();
                    course.setId(rs.getInt("CourseID"));
                    course.setTitle(rs.getString("Title"));
                    course.setDescription(rs.getString("Description"));
                    course.setPrice(rs.getBigDecimal("Price"));
                    course.setRating(rs.getDouble("Rating"));
                    course.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                    course.setImageURL(rs.getString("ImageURL"));
                    // InstructorID, CategoryID cần xử lý nếu cần lấy entity đầy đủ
                    course.setStatus(rs.getString("Status"));
                    courses.add(course);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return courses;
    }
    }