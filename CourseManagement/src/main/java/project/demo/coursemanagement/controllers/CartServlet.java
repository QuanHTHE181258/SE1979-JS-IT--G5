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
                       c.CourseID, c.Title, c.Price as CoursePrice,
                       CASE WHEN e.enrollment_id IS NOT NULL THEN 1 ELSE 0 END as IsEnrolled
                FROM cartitem ci
                JOIN courses c ON ci.CourseID = c.CourseID
                JOIN cart ct ON ci.CartID = ct.CartID
                LEFT JOIN enrollments e ON e.course_id = c.CourseID AND e.student_id = ct.UserID
                WHERE ct.UserID = ?
                """;

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    boolean isEnrolled = rs.getInt("IsEnrolled") == 1;
                    if (!isEnrolled) {
                        Cartitem item = new Cartitem();
                        item.setId(rs.getInt("CartItemID"));
                        item.setPrice(rs.getBigDecimal("Price"));

                        Cours course = new Cours();
                        course.setId(rs.getInt("CourseID"));
                        course.setTitle(rs.getString("Title"));
                        course.setPrice(rs.getBigDecimal("CoursePrice"));

                        item.setCourseID(course);
                        cartItems.add(item);
                        totalPrice = totalPrice.add(item.getPrice());
                    } else {
                        // Remove enrolled course from cart
                        int cartItemId = rs.getInt("CartItemID");
                        String deleteSql = "DELETE FROM cartitem WHERE CartItemID = ?";
                        try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                            deleteStmt.setInt(1, cartItemId);
                            deleteStmt.executeUpdate();
                        }
                    }
                }
            }

            // Store updated cart items and total
            session.setAttribute("cartItems", cartItems);
            session.setAttribute("totalPrice", totalPrice);

            request.getRequestDispatcher("/WEB-INF/views/profile/cart.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
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
            // Kiểm tra role của user
            if ("add".equals(action)) {
                String checkRoleSql = """
                    SELECT r.RoleName 
                    FROM user_roles ur 
                    JOIN roles r ON ur.RoleID = r.RoleID 
                    WHERE ur.UserID = ?
                    """;
                try (PreparedStatement checkStmt = conn.prepareStatement(checkRoleSql)) {
                    checkStmt.setInt(1, userId);
                    ResultSet rs = checkStmt.executeQuery();
                    boolean isStudent = false;
                    while (rs.next()) {
                        if ("Student".equals(rs.getString("RoleName"))) {
                            isStudent = true;
                            break;
                        }
                    }
                    if (!isStudent) {
                        session.setAttribute("message", "Chỉ học viên mới có thể thêm khóa học vào giỏ hàng!");
                        response.sendRedirect("CartServlet");
                        return;
                    }
                }
            }

            // Check if user is already enrolled
            String checkEnrollSql = "SELECT COUNT(*) FROM enrollments WHERE student_id = ? AND course_id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkEnrollSql)) {
                checkStmt.setInt(1, userId);
                checkStmt.setInt(2, courseId);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    session.setAttribute("message", "Bạn đã đăng ký khóa học này rồi!");
                    response.sendRedirect("CartServlet");
                    return;
                }
            }

            // Check if user has already purchased the course
            String checkPurchaseSql = """
                SELECT COUNT(*) FROM orders o
                JOIN orderdetails od ON o.OrderID = od.OrderID
                WHERE o.UserID = ? AND od.CourseID = ? AND o.Status = 'Completed'
                """;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkPurchaseSql)) {
                checkStmt.setInt(1, userId);
                checkStmt.setInt(2, courseId);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    session.setAttribute("message", "Bạn đã mua khóa học này rồi!");
                    response.sendRedirect("CartServlet");
                    return;
                }
            }

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
