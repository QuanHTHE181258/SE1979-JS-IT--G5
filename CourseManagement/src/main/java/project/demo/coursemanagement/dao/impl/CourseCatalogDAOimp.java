package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CourseCatalogDAO;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CourseCatalogDAOimp implements CourseCatalogDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public List<CourseDTO> filterCourses(String category, String priceRange, String ratingRange, String status, int page, int size) {
        List<CourseDTO> courses = new ArrayList<>();
        StringBuilder sql = new StringBuilder("""
            SELECT c.CourseID, c.Title, c.Description, c.Price, c.Rating,
                   c.Status, u.FirstName + ' ' + u.LastName AS TeacherName, cat.Name AS CategoryName
            FROM courses c
            JOIN users u ON c.InstructorID = u.UserID
            JOIN categories cat ON c.CategoryID = cat.CategoryID
            WHERE 1=1
        """);

        List<Object> params = new ArrayList<>();

        if (category != null && !category.isEmpty()) {
            sql.append(" AND cat.Name COLLATE Latin1_General_CI_AI LIKE ?");
            params.add(category);
        }

        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "Free" -> sql.append(" AND c.Price = 0");
                case "Under100000" -> sql.append(" AND c.Price < 100000");
                case "100000to500000" -> sql.append(" AND c.Price BETWEEN 100000 AND 500000");
                case "Above500000" -> sql.append(" AND c.Price > 500000");
            }
        }

        if (ratingRange != null && !ratingRange.isEmpty()) {
            switch (ratingRange) {
                case "Under2" -> sql.append(" AND c.Rating < 2");
                case "2to4" -> sql.append(" AND c.Rating BETWEEN 2 AND 4");
                case "Above4" -> sql.append(" AND c.Rating > 4");
            }
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND c.Status COLLATE Latin1_General_CI_AI LIKE ?");
            params.add(status);
        }

        sql.append(" ORDER BY c.CourseID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ps.setInt(params.size() + 1, (page - 1) * size);
            ps.setInt(params.size() + 2, size);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CourseDTO course = new CourseDTO();
                    course.setCourseID(rs.getInt("CourseID"));
                    course.setCourseTitle(rs.getString("Title"));
                    course.setCourseDescription(rs.getString("Description"));
                    course.setPrice(rs.getBigDecimal("Price"));
                    course.setRating(rs.getDouble("Rating"));
                    course.setCourseStatus(rs.getString("Status"));
                    course.setTeacherName(rs.getString("TeacherName"));
                    course.setCategories(rs.getString("CategoryName"));
                    courses.add(course);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return courses;
    }

    @Override
    public int countFilteredCourses(String category, String priceRange, String ratingRange, String status) {
        int count = 0;
        StringBuilder sql = new StringBuilder("""
            SELECT COUNT(*) FROM courses c
            JOIN users u ON c.InstructorID = u.UserID
            JOIN categories cat ON c.CategoryID = cat.CategoryID
            WHERE 1=1
        """);

        List<Object> params = new ArrayList<>();

        if (category != null && !category.isEmpty()) {
            sql.append(" AND cat.Name = ?");
            params.add(category);
        }

        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "Free" -> sql.append(" AND c.Price = 0");
                case "Under100000" -> sql.append(" AND c.Price < 100000");
                case "100000to500000" -> sql.append(" AND c.Price BETWEEN 100000 AND 500000");
                case "Above500000" -> sql.append(" AND c.Price > 500000");
            }
        }

        if (ratingRange != null && !ratingRange.isEmpty()) {
            switch (ratingRange) {
                case "Under2" -> sql.append(" AND c.Rating < 2");
                case "2to4" -> sql.append(" AND c.Rating BETWEEN 2 AND 4");
                case "Above4" -> sql.append(" AND c.Rating > 4");
            }
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND c.Status = ?");
            params.add(status);
        }

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }
}
