package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CartDAO;
import project.demo.coursemanagement.entities.Cartitem;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {

    private final DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public List<Cartitem> getCartItems(int userId) {
        System.out.println("=== CartDAO getCartItems Debug ===");
        System.out.println("Getting cart items for userId: " + userId);

        List<Cartitem> items = new ArrayList<>();

        String sql = """
            SELECT ci.CartItemID, ci.Price, 
                   c.CourseID, c.Title, c.Price as CoursePrice
            FROM cartitem ci
            JOIN courses c ON ci.CourseID = c.CourseID
            JOIN cart ct ON ci.CartID = ct.CartID
            WHERE ct.UserID = ?
        """;

        System.out.println("Executing SQL: " + sql);
        System.out.println("With userId parameter: " + userId);

        try (Connection conn = dbConn.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                int rowCount = 0;
                while (rs.next()) {
                    rowCount++;
                    System.out.println("Processing row " + rowCount + ":");

                    Cartitem item = new Cartitem();
                    int cartItemId = rs.getInt("CartItemID");
                    item.setId(cartItemId);
                    System.out.println("  - CartItemID: " + cartItemId);

                    Cours course = new Cours();
                    int courseId = rs.getInt("CourseID");
                    String courseTitle = rs.getString("Title");
                    BigDecimal coursePrice = rs.getBigDecimal("CoursePrice");

                    System.out.println("  - CourseID from DB: " + courseId);
                    System.out.println("  - Course Title: " + courseTitle);
                    System.out.println("  - Course Price: " + coursePrice);

                    course.setId(courseId);
                    course.setTitle(courseTitle);
                    course.setPrice(coursePrice);

                    System.out.println("  - Course object after setting: " + course);
                    System.out.println("  - Course.getId(): " + course.getId());

                    item.setCourseID(course);

                    BigDecimal itemPrice = rs.getBigDecimal("Price");
                    item.setPrice(itemPrice);
                    System.out.println("  - Item Price: " + itemPrice);

                    items.add(item);

                    System.out.println("  - Item added to list. Course in item: " + item.getCourseID());
                    System.out.println("  - Item.getCourseID().getId(): " +
                            (item.getCourseID() != null ? item.getCourseID().getId() : "NULL"));
                }

                System.out.println("Total rows processed: " + rowCount);
                System.out.println("Total items in list: " + items.size());
            }

        } catch (SQLException e) {
            System.err.println("ERROR in getCartItems:");
            e.printStackTrace();
            throw new RuntimeException("Error loading cart items", e);
        }

        System.out.println("Returning " + items.size() + " items");
        return items;
    }

    @Override
    public String addToCart(int userId, int courseId) {
        try (Connection conn = dbConn.getConnection()) {
            // Kiểm tra xem khóa học đã được enroll chưa
            if (isCourseEnrolled(conn, userId, courseId)) {
                System.out.println("Course already enrolled for user " + userId);
                return "ALREADY_ENROLLED";
            }

            int cartId = getOrCreateCart(conn, userId);

            // Kiểm tra xem khóa học đã có trong giỏ hàng chưa
            if (isCourseInCart(conn, cartId, courseId)) {
                System.out.println("Course already in cart for user " + userId);
                return "ALREADY_IN_CART";
            }

            BigDecimal price = getCoursePrice(conn, courseId);
            System.out.println("Course price: " + price);

            String insert = "INSERT INTO cartitem (CartID, CourseID, Price) VALUES (?, ?, ?)";
            System.out.println("Executing insert: " + insert);
            System.out.println("Parameters: cartId=" + cartId + ", courseId=" + courseId + ", price=" + price);

            try (PreparedStatement ps = conn.prepareStatement(insert)) {
                ps.setInt(1, cartId);
                ps.setInt(2, courseId);
                ps.setBigDecimal(3, price);
                int rowsAffected = ps.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);

                if (rowsAffected > 0) {
                    System.out.println("addToCart completed successfully");
                    return "SUCCESS";
                } else {
                    return "FAILED";
                }
            }

        } catch (SQLException e) {
            System.err.println("ERROR in addToCart:");
            e.printStackTrace();
            throw new RuntimeException("Error adding course to cart", e);
        }
    }

    @Override
    public void removeFromCart(int userId, int courseId) {
        System.out.println("=== CartDAO removeFromCart Debug ===");
        System.out.println("Removing courseId " + courseId + " from cart for userId " + userId);

        try (Connection conn = dbConn.getConnection()) {
            Integer cartId = getCartId(conn, userId);
            System.out.println("Cart ID: " + cartId);

            if (cartId == null) {
                System.out.println("No cart found for user, nothing to remove");
                return;
            }

            String delete = "DELETE FROM cartitem WHERE CartID = ? AND CourseID = ?";
            System.out.println("Executing delete: " + delete);
            System.out.println("Parameters: cartId=" + cartId + ", courseId=" + courseId);

            try (PreparedStatement ps = conn.prepareStatement(delete)) {
                ps.setInt(1, cartId);
                ps.setInt(2, courseId);
                int rowsAffected = ps.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);

                if (rowsAffected == 0) {
                    System.out.println("WARNING: No rows were deleted. Item might not exist in cart.");
                } else {
                    System.out.println("Item successfully removed from cart");
                }
            }
        } catch (SQLException e) {
            System.err.println("ERROR in removeFromCart:");
            e.printStackTrace();
            throw new RuntimeException("Error removing course from cart", e);
        }

        System.out.println("removeFromCart completed");
    }

    @Override
    public void deleteCartAndItemsByUserId(int userId) {
        System.out.println("=== CartDAO deleteCartAndItemsByUserId Debug ===");
        System.out.println("Deleting entire cart for userId: " + userId);

        String getCartIdSql = "SELECT CartID FROM cart WHERE UserID = ?";
        String deleteItemsSql = "DELETE FROM cartitem WHERE CartID = ?";
        String deleteCartSql = "DELETE FROM cart WHERE CartID = ?";

        try (Connection conn = dbConn.getConnection()) {
            Integer cartId = null;

            // Lấy CartID
            try (PreparedStatement ps = conn.prepareStatement(getCartIdSql)) {
                ps.setInt(1, userId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        cartId = rs.getInt("CartID");
                        System.out.println("Found cart ID: " + cartId);
                    } else {
                        System.out.println("No cart found for user");
                        return;
                    }
                }
            }

            // Xóa cartitem
            try (PreparedStatement ps = conn.prepareStatement(deleteItemsSql)) {
                ps.setInt(1, cartId);
                int itemsDeleted = ps.executeUpdate();
                System.out.println("Deleted " + itemsDeleted + " cart items");
            }

            // Xóa cart
            try (PreparedStatement ps = conn.prepareStatement(deleteCartSql)) {
                ps.setInt(1, cartId);
                int cartsDeleted = ps.executeUpdate();
                System.out.println("Deleted " + cartsDeleted + " carts");
            }

        } catch (SQLException e) {
            System.err.println("ERROR in deleteCartAndItemsByUserId:");
            e.printStackTrace();
        }

        System.out.println("deleteCartAndItemsByUserId completed");
    }

    // ========== PRIVATE METHODS ==========

    private int getOrCreateCart(Connection conn, int userId) throws SQLException {
        System.out.println("Getting or creating cart for userId: " + userId);

        String find = "SELECT CartID FROM cart WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(find)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int cartId = rs.getInt("CartID");
                    System.out.println("Found existing cart: " + cartId);
                    return cartId;
                }
            }
        }

        System.out.println("No existing cart found, creating new one");
        String insert = "INSERT INTO cart (UserID, Status, TotalPrice, CreatedAt) VALUES (?, 'active', 0, GETDATE())";
        try (PreparedStatement ps = conn.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Insert cart rows affected: " + rowsAffected);

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int newCartId = rs.getInt(1);
                    System.out.println("Created new cart with ID: " + newCartId);
                    return newCartId;
                }
            }
        }

        throw new SQLException("Unable to create or retrieve cart.");
    }

    private Integer getCartId(Connection conn, int userId) throws SQLException {
        System.out.println("Getting cart ID for userId: " + userId);

        String sql = "SELECT CartID FROM cart WHERE UserID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Integer cartId = rs.getInt("CartID");
                    System.out.println("Found cart ID: " + cartId);
                    return cartId;
                } else {
                    System.out.println("No cart found for user");
                }
            }
        }
        return null;
    }

    private boolean isCourseEnrolled(Connection conn, int userId, int courseId) throws SQLException {
        String sql = "SELECT 1 FROM enrollments WHERE student_id = ? AND course_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                boolean enrolled = rs.next();
                System.out.println("Course " + courseId + " enrolled for user " + userId + ": " + enrolled);
                return enrolled;
            }
        }
    }

    private boolean isCourseInCart(Connection conn, int cartId, int courseId) throws SQLException {
        String sql = "SELECT 1 FROM cartitem WHERE CartID = ? AND CourseID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                boolean inCart = rs.next();
                System.out.println("Course " + courseId + " in cart " + cartId + ": " + inCart);
                return inCart;
            }
        }
    }

    private BigDecimal getCoursePrice(Connection conn, int courseId) throws SQLException {
        String sql = "SELECT Price FROM courses WHERE CourseID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BigDecimal price = rs.getBigDecimal("Price");
                    System.out.println("Course " + courseId + " price: " + price);
                    return price;
                }
            }
        }
        System.out.println("Course " + courseId + " not found, returning ZERO price");
        return BigDecimal.ZERO;
    }
}