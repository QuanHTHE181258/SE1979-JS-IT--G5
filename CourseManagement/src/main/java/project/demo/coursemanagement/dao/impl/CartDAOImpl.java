package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.CartDAO;

public class CartDAOImpl implements CartDAO {
    @Override
    public void deleteCartByUserId(int userId) {
        // Không dùng nữa, để trống hoặc throw exception nếu cần
        throw new UnsupportedOperationException("Not supported. Use deleteCartAndItemsByUserId instead.");
    }

    @Override
    public void deleteCartAndItemsByUserId(int userId) {
        try (java.sql.Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection()) {
            int cartId = -1;
            String getCartIdSql = "SELECT CartID FROM cart WHERE UserID = ?";
            try (java.sql.PreparedStatement ps = conn.prepareStatement(getCartIdSql)) {
                ps.setInt(1, userId);
                try (java.sql.ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        cartId = rs.getInt("CartID");
                    }
                }
            }
            if (cartId > 0) {
                String deleteCartItemSql = "DELETE FROM cartitem WHERE CartID = ?";
                try (java.sql.PreparedStatement ps = conn.prepareStatement(deleteCartItemSql)) {
                    ps.setInt(1, cartId);
                    ps.executeUpdate();
                }
                String deleteCartSql = "DELETE FROM cart WHERE CartID = ?";
                try (java.sql.PreparedStatement ps = conn.prepareStatement(deleteCartSql)) {
                    ps.setInt(1, cartId);
                    ps.executeUpdate();
                }
            }
        } catch (Exception e) {
            System.out.println("[DEBUG] Error deleting cart after checkout: " + e.getMessage());
        }
    }
}
