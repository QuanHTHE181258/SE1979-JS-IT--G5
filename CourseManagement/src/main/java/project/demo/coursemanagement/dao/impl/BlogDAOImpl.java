package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.BlogDAO;
import project.demo.coursemanagement.entities.Blog;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAOImpl implements BlogDAO {
    @Override
    public List<Blog> getAllBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.BlogID, b.Title, b.Content, b.ImageURL, b.AuthorID, b.CreatedAt, b.UpdatedAt, b.Status, u.Username " +
                     "FROM blogs b JOIN users u ON b.AuthorID = u.UserID";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setId(rs.getInt("BlogID"));
                blog.setTitle(rs.getString("Title"));
                blog.setContent(rs.getString("Content"));
                blog.setImageURL(rs.getString("ImageURL"));
                blog.setCreatedAt(rs.getTimestamp("CreatedAt") != null ? rs.getTimestamp("CreatedAt").toInstant() : null);
                blog.setUpdatedAt(rs.getTimestamp("UpdatedAt") != null ? rs.getTimestamp("UpdatedAt").toInstant() : null);
                blog.setStatus(rs.getString("Status"));

                // Set author
                User author = new User();
                author.setId(rs.getInt("AuthorID"));
                author.setUsername(rs.getString("Username"));
                blog.setAuthorID(author);

                blogs.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }
} 