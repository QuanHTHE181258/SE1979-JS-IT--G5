package project.demo.coursemanagement.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import project.demo.coursemanagement.entities.Cartitem;

public interface CartDAO {
    List<Cartitem> getCartItems(int userId);
    String addToCart(int userId, int courseId); // Thay đổi return type thành String để trả về thông báo
    void removeFromCart(int userId, int courseId);
    void deleteCartAndItemsByUserId(int userId);
}