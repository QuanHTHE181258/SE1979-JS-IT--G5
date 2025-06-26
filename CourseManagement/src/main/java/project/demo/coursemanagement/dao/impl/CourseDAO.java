/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package project.demo.coursemanagement.dao.impl;


import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CourseDAO {
//
    private static final int PAGE_SIZE = 6; // Số lượng khóa học trên mỗi trang
//
//    /**
//     * Lấy tổng số lượng khóa học
//     *
//     * @return Tổng số lượng khóa học
//     */
//    public int getTotalCourses() {
//        String query = "SELECT COUNT(*) FROM [Onlinelearning].[dbo].[courses] WHERE [status] = 'active'";
//        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
//
//            if (rs.next()) {
//                return rs.getInt(1);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return 0;
//    }
//
//    /**
//     * Lấy danh sách các khóa học theo trang
//     *
//     * @param page Trang hiện tại
//     * @return Danh sách các khóa học
//     */
    public List<Cours> getAllCourses(int page) {
        List<Cours> list = new ArrayList<>();
        String query = "SELECT [id], [teacher_id], [title], [thumbnail_url], "
                + "[description], [category_id], [status], [created_at], [price] "
                + "FROM [Onlinelearning].[dbo].[courses] "
                + "WHERE [status] = 'active' "
                + "ORDER BY [id] "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, (page - 1) * PAGE_SIZE);
            ps.setInt(2, PAGE_SIZE);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
//                    Cours course = new Cours(
//                            rs.getInt("id"),
//                            rs.getInt("teacher_id"),
//                            rs.getString("title"),
//                            rs.getString("thumbnail_url"),
//                            rs.getString("description"),
//                            rs.getInt("category_id"),
//                            rs.getString("status"),
//                            rs.getTimestamp("created_at"),
//                            rs.getInt("price")
//                    );
//                    list.add(course);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public List<Cours> getCourseByTeacherId(int id) {
        String query = "SELECT [CourseID], [Title], [Description], [Price], [Rating], "
                + "[CreatedAt], [ImageURL], [InstructorID], [CategoryID], [Status] "
                + "FROM [courses] "
                + "WHERE [InstructorID] = ?";
        List<Cours> list = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
//                    Course course = new Course(
//                            rs.getInt("id"),
//                            rs.getInt("teacher_id"),
//                            rs.getString("title"),
//                            rs.getString("thumbnail_url"),
//                            rs.getString("description"),
//                            rs.getInt("category_id"),
//                            rs.getString("status"),
//                            rs.getTimestamp("created_at"),
//                            rs.getInt("price")
//                    );
//                    list.add(course);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
//
//    /**
//     * Lấy tổng số lượng khóa học theo danh mục
//     *
//     * @param categoryId ID của danh mục
//     * @return Tổng số lượng khóa học theo danh mục
//     */
//    public int getTotalCoursesByCategory(int categoryId) {
//        String query = "SELECT COUNT(*) FROM [Onlinelearning].[dbo].[courses] "
//                + "WHERE [category_id] = ? AND [status] = 'active'";
//
//        try (PreparedStatement ps = connection.prepareStatement(query)) {
//            ps.setInt(1, categoryId);
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    return rs.getInt(1);
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return 0;
//    }
//
//    /**
//     * Lấy danh sách các khóa học theo danh mục và trang
//     *
//     * @param categoryId ID của danh mục
//     * @param page Trang hiện tại
//     * @return Danh sách các khóa học thuộc danh mục
//     */
//    public List<Course> getCoursesByCategory(int categoryId, int page) {
//        List<Course> list = new ArrayList<>();
//        String query = "SELECT [id], [teacher_id], [title], [thumbnail_url], "
//                + "[description], [category_id], [status], [created_at], [price] "
//                + "FROM [Onlinelearning].[dbo].[courses] "
//                + "WHERE [category_id] = ? AND [status] = 'active' "
//                + "ORDER BY [id] "
//                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
//
//        try (PreparedStatement ps = connection.prepareStatement(query)) {
//            ps.setInt(1, categoryId);
//            ps.setInt(2, (page - 1) * PAGE_SIZE);
//            ps.setInt(3, PAGE_SIZE);
//
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    Course course = new Course(
//                            rs.getInt("id"),
//                            rs.getInt("teacher_id"),
//                            rs.getString("title"),
//                            rs.getString("thumbnail_url"),
//                            rs.getString("description"),
//                            rs.getInt("category_id"),
//                            rs.getString("status"),
//                            rs.getTimestamp("created_at"),
//                            rs.getInt("price")
//                    );
//                    list.add(course);
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return list;
//    }
//
//    /**
//     * Lấy tất cả các danh mục
//     *
//     * @return Danh sách các danh mục
//     */
//    public List<Category> getAllCategories() {
//        List<Category> list = new ArrayList<>();
//        String query = "SELECT [id], [semester] "
//                + "FROM [Onlinelearning].[dbo].[category]";
//
//        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
//
//            while (rs.next()) {
//                Category category = new Category(
//                        rs.getInt("id"),
//                        rs.getString("semester")
//                );
//                list.add(category);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return list;
//    }
//
//    public Course getCourseById(int id) {
//        String query = "SELECT [id], [teacher_id], [title], [thumbnail_url], [description], "
//                + "[category_id], [status], [created_at], [price] "
//                + "FROM [Onlinelearning].[dbo].[courses] "
//                + "WHERE [id] = ?";
//
//        try (PreparedStatement ps = connection.prepareStatement(query)) {
//            ps.setInt(1, id);
//
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    return new Course(
//                            rs.getInt("id"),
//                            rs.getInt("teacher_id"),
//                            rs.getString("title"),
//                            rs.getString("thumbnail_url"),
//                            rs.getString("description"),
//                            rs.getInt("category_id"),
//                            rs.getString("status"),
//                            rs.getTimestamp("created_at"),
//                            rs.getInt("price")
//                    );
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return null;
//    }
//
//    public List<Course> getLatestCourses() {
//        List<Course> courses = new ArrayList<>();
//        String sql = "SELECT TOP 10 c.*, "
//                + "(SELECT COUNT(*) FROM course_enrollments ce WHERE ce.course_id = c.id) as enrollment_count, "
//                + "(SELECT COUNT(*) FROM Lesson l WHERE l.CourseID = c.id) as lesson_count "
//                + "FROM courses c "
//                + "WHERE c.status = 'active' "
//                + "ORDER BY c.created_at DESC";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Course course = new Course();
//                course.setId(rs.getInt("id"));
//                course.setTitle(rs.getString("title"));
//                course.setThumbnailUrl(rs.getString("thumbnail_url"));
//                course.setDescription(rs.getString("description"));
//                course.setPrice(rs.getInt("price"));
//                course.setCreatedAt(rs.getDate("created_at"));
//                course.setEnrollmentCount(rs.getInt("enrollment_count"));
//                course.setLessonCount(rs.getInt("lesson_count"));
//                courses.add(course);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return courses;
//    }
//
//    public List<Course> getHotCourses() {
//        List<Course> courses = new ArrayList<>();
//        String sql = "SELECT TOP 10 c.id, c.teacher_id, c.title, c.thumbnail_url, "
//                + "c.category_id, c.status, c.created_at, c.price, "
//                + "COUNT(ce.id) as enrollment_count, "
//                + "(SELECT COUNT(*) FROM Lesson l WHERE l.CourseID = c.id) as lesson_count "
//                + "FROM courses c "
//                + "LEFT JOIN course_enrollments ce ON c.id = ce.course_id "
//                + "WHERE c.status = 'active' "
//                + "GROUP BY c.id, c.teacher_id, c.title, c.thumbnail_url, "
//                + " c.category_id, c.status, c.created_at, c.price "
//                + "ORDER BY COUNT(ce.id) DESC";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Course course = new Course();
//                course.setId(rs.getInt("id"));
//                course.setTitle(rs.getString("title"));
//                course.setThumbnailUrl(rs.getString("thumbnail_url"));
//                course.setPrice(rs.getInt("price"));
//                course.setCreatedAt(rs.getDate("created_at"));
//                course.setEnrollmentCount(rs.getInt("enrollment_count"));
//                course.setLessonCount(rs.getInt("lesson_count"));
//                courses.add(course);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return courses;
//    }
//
//    public List<Blog> getLatestBlogs() {
//        List<Blog> blogs = new ArrayList<>();
//        String sql = "SELECT TOP 10 b.* FROM blogs b ORDER BY b.created_at DESC";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Blog blog = new Blog();
//                blog.setId(rs.getInt("id"));
//                blog.setTitle(rs.getString("title"));
//                blog.setContent(rs.getString("content"));
//                blog.setAuthorId(rs.getInt("author_id"));
//                blog.setCreatedAt(rs.getDate("created_at"));
//                blogs.add(blog);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return blogs;
//    }
//
//    // Lấy danh sách khóa học theo teacher_id với tìm kiếm và phân trang
//    public List<Course> getCoursesByTeacher(int teacherId, String search, int offset, int recordsPerPage) throws SQLException {
//        List<Course> courses = new ArrayList<>();
//        String sql = "SELECT id, title, description, created_at, status FROM courses "
//                + "WHERE teacher_id = ? AND title LIKE ? "
//                + "ORDER BY id "
//                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, teacherId);
//            stmt.setString(2, "%" + (search != null ? search : "") + "%");
//            stmt.setInt(3, offset);
//            stmt.setInt(4, recordsPerPage);
//            try (ResultSet rs = stmt.executeQuery()) {
//                while (rs.next()) {
//                    Course course = new Course();
//                    course.setId(rs.getInt("id"));
//                    course.setTitle(rs.getString("title"));
//                    course.setDescription(rs.getString("description"));
//                    course.setCreatedAt(rs.getDate("created_at"));
//                    course.setStatus(rs.getString("status"));
//                    courses.add(course);
//                }
//            }
//        }
//        return courses;
//    }
//
//    // Đếm tổng số khóa học theo teacher_id và tìm kiếm
//    public int getCourseCountByTeacher(int teacherId, String search) throws SQLException {
//        String sql = "SELECT COUNT(*) FROM courses WHERE teacher_id = ? AND title LIKE ?";
//        try (
//                PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, teacherId);
//            stmt.setString(2, "%" + (search != null ? search : "") + "%");
//            try (ResultSet rs = stmt.executeQuery()) {
//                if (rs.next()) {
//                    return rs.getInt(1);
//                }
//            }
//        }
//        return 0;
//    }
//
//    // Thêm phương thức thay đổi trạng thái khóa học
//    public boolean changeCourseStatus(int courseId, String status) {
//        String sql = "UPDATE courses SET status = ? WHERE id = ?";
//        try (
//                PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setString(1, status);
//            stmt.setInt(2, courseId);
//            int rowsAffected = stmt.executeUpdate();
//            return rowsAffected > 0;
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
//            return false;
//        }
//    }
//
//    /**
//     * Lấy danh sách các khóa học theo trang
//     *
//     * @param page Trang hiện tại
//     * @return Danh sách các khóa học
//     */
//    public List<Course> getAllCoursesActive(int page) {
//        List<Course> list = new ArrayList<>();
//        String query = "SELECT [id], [teacher_id], [title], [thumbnail_url], "
//                + "[description], [category_id], [status], [created_at], [price] "
//                + "FROM [Onlinelearning].[dbo].[courses] "
//                + "WHERE [status] = 'active' "
//                + "ORDER BY [id] "
//                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
//
//        try (PreparedStatement ps = connection.prepareStatement(query)) {
//            ps.setInt(1, (page - 1) * PAGE_SIZE);
//            ps.setInt(2, PAGE_SIZE);
//
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    Course course = new Course(
//                            rs.getInt("id"),
//                            rs.getInt("teacher_id"),
//                            rs.getString("title"),
//                            rs.getString("thumbnail_url"),
//                            rs.getString("description"),
//                            rs.getInt("category_id"),
//                            rs.getString("status"),
//                            rs.getTimestamp("created_at"),
//                            rs.getInt("price")
//                    );
//                    list.add(course);
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//
//        return list;
//    }
//
    public List<Cours> getAllCourses() {
        List<Cours> list = new ArrayList<>();
        String query = "SELECT [CourseID]\n"
                + "      ,[Title]\n"
                + "      ,[Description]\n"
                + "      ,[Price]\n"
                + "      ,[Rating]\n"
                + "      ,[CreatedAt]\n"
                + "      ,[ImageURL]\n"
                + "      ,[InstructorID]\n"
                + "      ,[CategoryID]\n"
                + "      ,[Status]\n"
                + "  FROM [dbo].[courses]";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(Cours.builder()
                                    .id(rs.getInt("CourseID"))
                            .title(rs.getString("Title"))
                            .description(rs.getString("Description"))
                                    .price(rs.getBigDecimal("Price"))
                                    .rating(rs.getDouble("Rating"))
                                    .createdAt(rs.getTimestamp("CreatedAt").toInstant())
                                    .imageURL(rs.getString("ImageURL"))
                                    .instructorID(User.builder().id(rs.getInt("InstructorID")).build())
                                    .categoryID(rs.getInt("CategoryID"))
                                    .status(rs.getString("Status"))
                            .build());
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

//    public void updateEnrollmentStatusForStudent(int studentId) {
//        String sql
//                = "UPDATE course_enrollments \n"
//                + "SET status = 'completed'\n"
//                + "WHERE course_enrollments.student_id = ?\n"
//                + "  AND NOT EXISTS (\n"
//                + "    SELECT 1\n"
//                + "    FROM Lesson l\n"
//                + "    LEFT JOIN Quiz q ON l.LessonID = q.LessonID\n"
//                + "    LEFT JOIN (\n"
//                + "        SELECT QuizID\n"
//                + "        FROM Question\n"
//                + "        GROUP BY QuizID\n"
//                + "    ) qu ON q.QuizID = qu.QuizID\n"
//                + "    WHERE l.CourseID = course_enrollments.course_id\n"
//                + "      AND (\n"
//                + "        -- Lesson chưa được hoàn thành\n"
//                + "        NOT EXISTS (\n"
//                + "            SELECT 1\n"
//                + "            FROM Lesson_Completion lc\n"
//                + "            WHERE lc.UserID = course_enrollments.student_id AND lc.LessonID = l.LessonID\n"
//                + "        )\n"
//                + "        -- AND nếu quiz có ít nhất 1 câu hỏi\n"
//                + "        AND qu.QuizID IS NOT NULL\n"
//                + "      )\n"
//                + ");";
//
//        try (Connection conn = DatabaseConnection.getInstance().getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//
//            ps.setInt(1, studentId);
//            int updated = ps.executeUpdate();
//            System.out.println("Updated " + updated + " enrollment(s) to 'completed' for student ID: " + studentId);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    //my course ( lấy course theo userID)
//    public List<Course> listCoursesByUserId(int userId) {
//        List<Course> listCourses = new ArrayList<>();
//        String sql = "SELECT c.*, ce.status AS enrollment_status FROM courses c "
//                + "INNER JOIN course_enrollments ce ON c.id = ce.course_id "
//                + "WHERE ce.student_id = ?";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//
//            ps.setInt(1, userId);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                Course course = new Course();
//                course.setId(rs.getInt("id"));
//                course.setTitle(rs.getString("title"));
//                course.setDescription(rs.getString("description"));
//                course.setStatus(rs.getString("enrollment_status")); // Get status from enrollment
//                listCourses.add(course);
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            // Xử lý exception hoặc ghi log ở đây
//        }
//        return listCourses;
//    }
//
//    //lấy tổng số lượng course mà giáo viên đang quản lý
//    public int getTotalCoursesByTeacherId(int userId) {
//        String sql = "SELECT COUNT(c.id) AS total_courses "
//                + "FROM users u "
//                + "LEFT JOIN courses c ON u.id = c.teacher_id "
//                + "WHERE u.id = ? "
//                + "GROUP BY u.id, u.first_name, u.middle_name, u.last_name, u.email";
//
//        int totalCourses = 0;
//
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, userId);
//
//            try (ResultSet rs = stmt.executeQuery()) {
//                if (rs.next()) {
//                    totalCourses = rs.getInt("total_courses");
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//
//        return totalCourses;
//    }
//
//    //lấy ra tổng số lượng user theo role
//    public int getTotalUsersByRole(int roleId) {
//        String sql = "SELECT COUNT(*) AS total_users FROM users WHERE role_id = ?";
//
//        int totalUsers = 0;
//
//        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
//            stmt.setInt(1, roleId);
//
//            try (ResultSet rs = stmt.executeQuery()) {
//                if (rs.next()) {
//                    totalUsers = rs.getInt("total_users");
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return totalUsers;
//    }
//
//    //show ra list danh sách học sinh đã join các course học
//    public List<StudentEnrollment> getTodayEnrollments() throws SQLException {
//        List<StudentEnrollment> enrollments = new ArrayList<>();
//        String sql = "SELECT "
//                + "u.first_name, u.middle_name, u.last_name, u.email, "
//                + "g.name AS gender_name, "
//                + "c.title AS course_title, "
//                + "ce.status AS enrollment_status "
//                + "FROM course_enrollments ce "
//                + "INNER JOIN users u ON ce.student_id = u.id "
//                + "INNER JOIN genders g ON u.gender_id = g.id "
//                + "INNER JOIN courses c ON ce.course_id = c.id "
//                + "WHERE CAST(ce.enrolled_at AS DATE) = CAST(GETDATE() AS DATE)";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
//
//            while (rs.next()) {
//                StudentEnrollment enrollment = new StudentEnrollment();
//                enrollment.setFirstName(rs.getString("first_name"));
//                enrollment.setMiddleName(rs.getString("middle_name"));
//                enrollment.setLastName(rs.getString("last_name"));
//                enrollment.setEmail(rs.getString("email"));
//                enrollment.setGenderName(rs.getString("gender_name"));
//                enrollment.setCourseTitle(rs.getString("course_title"));
//                enrollment.setEnrollmentStatus(rs.getString("enrollment_status"));
//                enrollments.add(enrollment);
//            }
//        }
//        return enrollments;
//    }
//
//    //add Course
//    public int addCourse(Course course, int teacherId) {
//        String sql = "INSERT INTO [dbo].[courses] "
//                + "([teacher_id], [title], [thumbnail_url], [description], [category_id], [status], [created_at], [price]) "
//                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
//        try (PreparedStatement statement = connection.prepareStatement(sql)) {
//            statement.setInt(1, teacherId);
//            statement.setString(2, course.getTitle());
//            statement.setString(3, course.getThumbnailUrl());
//            statement.setString(4, course.getDescription());
//            statement.setInt(5, course.getCategoryId());
//            statement.setString(6, course.getStatus());
//            statement.setDate(7, new java.sql.Date(new Date().getTime()));
//            statement.setDouble(8, course.getPrice());
//
//            int rowsAffected = statement.executeUpdate();
//
//            if (rowsAffected == 0) {
//                throw new SQLException("Creating course failed, no rows affected.");
//            } else {
//                return 1;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return -1;
//        }
//    }
//
//    //kiem tra xem title course co ton tai khong. true neu ko ton tai
//    public boolean isCourseTitleAvailable(String title) {
//        String sql = "SELECT COUNT(*) FROM [dbo].[courses] WHERE LTRIM(RTRIM(LOWER(title))) = LTRIM(RTRIM(LOWER(?)))";
//        try (PreparedStatement statement = connection.prepareStatement(sql)) {
//            statement.setString(1, title);
//
//            try (ResultSet rs = statement.executeQuery()) {
//                if (rs.next()) {
//                    return rs.getInt(1) == 0; // true nếu KHÔNG có bản ghi nào trùng
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false; // Giả định là không hợp lệ nếu có lỗi
//    }
//
//    //Lấy CourseID cuối để insert dl
//    public int getLastInsertedCourseId() throws SQLException {
//        String sql = "SELECT TOP 1 id FROM courses ORDER BY id DESC";
//        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
//            if (rs.next()) {
//                return rs.getInt("id");
//            }
//        }
//        return -1;
//    }
//
//    public void updateCourse(int id, String title, String thumbnailUrl, String description,
//            int categoryId, String status, double price) {
//        String sql = "UPDATE courses SET title=?, thumbnail_url=?, description=?, category_id=?, status=?, price=? WHERE id=?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, title);
//            ps.setString(2, thumbnailUrl);
//            ps.setString(3, description);
//            ps.setInt(4, categoryId);
//            ps.setString(5, status);
//            ps.setDouble(6, price);
//            ps.setInt(7, id);
//            ps.executeUpdate();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

}
