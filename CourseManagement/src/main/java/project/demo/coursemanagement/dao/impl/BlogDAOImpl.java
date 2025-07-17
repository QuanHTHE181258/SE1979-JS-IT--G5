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

    @Override
    public Blog getBlogById(int id) {
        String sql = "SELECT b.BlogID, b.Title, b.Content, b.ImageURL, b.AuthorID, b.CreatedAt, b.UpdatedAt, b.Status, u.Username " +
                     "FROM blogs b JOIN users u ON b.AuthorID = u.UserID WHERE b.BlogID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Blog blog = new Blog();
                    blog.setId(rs.getInt("BlogID"));
                    blog.setTitle(rs.getString("Title"));
                    blog.setContent(rs.getString("Content"));
                    blog.setImageURL(rs.getString("ImageURL"));
                    blog.setCreatedAt(rs.getTimestamp("CreatedAt") != null ? rs.getTimestamp("CreatedAt").toInstant() : null);
                    blog.setUpdatedAt(rs.getTimestamp("UpdatedAt") != null ? rs.getTimestamp("UpdatedAt").toInstant() : null);
                    blog.setStatus(rs.getString("Status"));

                    User author = new User();
                    author.setId(rs.getInt("AuthorID"));
                    author.setUsername(rs.getString("Username"));
                    blog.setAuthorID(author);

                    return blog;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean createBlog(Blog blog) {
        String sql = "INSERT INTO blogs (Title, Content, ImageURL, AuthorID, CreatedAt, Status) VALUES (?, ?, ?, ?, GETDATE(), ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getImageURL());
            ps.setInt(4, blog.getAuthorID().getId());
            ps.setString(5, blog.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateBlog(Blog blog) {
        String sql = "UPDATE blogs SET Title = ?, Content = ?, ImageURL = ?, Status = ?, UpdatedAt = GETDATE() WHERE BlogID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getImageURL());
            ps.setString(4, blog.getStatus());
            ps.setInt(5, blog.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Blog> getPublishedBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.BlogID, b.Title, b.Content, b.ImageURL, b.AuthorID, b.CreatedAt, b.UpdatedAt, b.Status, u.Username " +
                     "FROM blogs b JOIN users u ON b.AuthorID = u.UserID WHERE b.Status = 'published'";
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

    public List<Blog> getBlogsForUser(int userId) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT b.BlogID, b.Title, b.Content, b.ImageURL, b.AuthorID, b.CreatedAt, b.UpdatedAt, b.Status, u.Username " +
                     "FROM blogs b JOIN users u ON b.AuthorID = u.UserID " +
                     "WHERE b.Status = 'published' OR b.AuthorID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setId(rs.getInt("BlogID"));
                    blog.setTitle(rs.getString("Title"));
                    blog.setContent(rs.getString("Content"));
                    blog.setImageURL(rs.getString("ImageURL"));
                    blog.setCreatedAt(rs.getTimestamp("CreatedAt") != null ? rs.getTimestamp("CreatedAt").toInstant() : null);
                    blog.setUpdatedAt(rs.getTimestamp("UpdatedAt") != null ? rs.getTimestamp("UpdatedAt").toInstant() : null);
                    blog.setStatus(rs.getString("Status"));
                    User author = new User();
                    author.setId(rs.getInt("AuthorID"));
                    author.setUsername(rs.getString("Username"));
                    blog.setAuthorID(author);
                    blogs.add(blog);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }
} 