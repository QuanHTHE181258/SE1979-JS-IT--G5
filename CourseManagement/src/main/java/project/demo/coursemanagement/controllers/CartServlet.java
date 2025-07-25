package project.demo.coursemanagement.controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import project.demo.coursemanagement.entities.Cartitem;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private final DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Cartitem> cartItems = new ArrayList<>();
        BigDecimal totalPrice = BigDecimal.ZERO;

        try (Connection conn = dbConn.getConnection()) {
            String sql = """
                SELECT ci.CartItemID, ci.Price, 
                       c.CourseID, c.Title, c.Price as CoursePrice
                FROM cartitem ci
                JOIN courses c ON ci.CourseID = c.CourseID
                JOIN cart ct ON ci.CartID = ct.CartID
                WHERE ct.UserID = ?
            """;
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Cartitem item = new Cartitem();
                        item.setId(rs.getInt("CartItemID"));

                        Cours course = new Cours();
                        course.setId(rs.getInt("CourseID"));
                        course.setTitle(rs.getString("Title"));
                        course.setPrice(rs.getBigDecimal("CoursePrice"));
                        item.setCourseID(course);

                        item.setPrice(rs.getBigDecimal("Price"));
                        cartItems.add(item);
                        totalPrice = totalPrice.add(item.getPrice() != null ? item.getPrice() : BigDecimal.ZERO);
                    }
                }
            }

        } catch (SQLException e) {
            throw new ServletException("Error loading cart items", e);
        }

        session.setAttribute("cartItems", cartItems);
        session.setAttribute("totalPrice", totalPrice);
        request.getRequestDispatcher("/WEB-INF/views/profile/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String value = request.getParameter("courseId");
        int courseId;

        if (value != null && !value.trim().isEmpty()) {
            try {
                courseId = Integer.parseInt(value.trim());
                if (courseId <= 0) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid courseId.");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "courseId must be a number.");
                return;
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "courseId is required.");
            return;
        }

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try (Connection conn = dbConn.getConnection()) {
            switch (action) {
                case "add" -> addToCart(conn, userId, courseId);
                case "remove" -> removeFromCart(conn, userId, courseId);
                default -> response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action.");
            }
        } catch (SQLException e) {
            throw new ServletException("Cart operation failed", e);
        }

        response.sendRedirect("CartServlet");
    }

    private void addToCart(Connection conn, int userId, int courseId) throws SQLException {
        int cartId = getOrCreateCart(conn, userId);

        String checkExist = "SELECT 1 FROM cartitem WHERE CartID = ? AND CourseID = ?";
        try (PreparedStatement ps = conn.prepareStatement(checkExist)) {
            ps.setInt(1, cartId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return; // Course already in cart
            }
        }

        BigDecimal coursePrice = getCoursePrice(conn, courseId);

        String insert = "INSERT INTO cartitem (CartID, CourseID, Price) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(insert)) {
            ps.setInt(1, cartId);
            ps.setInt(2, courseId);
            ps.setBigDecimal(3, coursePrice);
            ps.executeUpdate();
        }
    }

    private void removeFromCart(Connection conn, int userId, int courseId) throws SQLException {
        int cartId = getOrCreateCart(conn, userId);
        String delete = "DELETE FROM cartitem WHERE CartID = ? AND CourseID = ?";
        try (PreparedStatement ps = conn.prepareStatement(delete)) {
            ps.setInt(1, cartId);
            ps.setInt(2, courseId);
            ps.executeUpdate();
        }
    }

    private int getOrCreateCart(Connection conn, int userId) throws SQLException {
        String findCart = "SELECT CartID FROM cart WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(findCart)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("CartID");
            }
        }

        String insertCart = "INSERT INTO cart (UserID, Status, TotalPrice, CreatedAt) VALUES (?, 'active', 0, GETDATE())";
        try (PreparedStatement ps = conn.prepareStatement(insertCart, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }

        throw new SQLException("Failed to create or retrieve cart.");
    }

    private BigDecimal getCoursePrice(Connection conn, int courseId) throws SQLException {
        String sql = "SELECT Price FROM courses WHERE CourseID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal("Price");
            }
        }
        return BigDecimal.ZERO;
    }
}
