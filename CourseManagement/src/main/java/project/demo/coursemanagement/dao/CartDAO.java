package project.demo.coursemanagement.dao;

public interface CartDAO {
    void deleteCartByUserId(int userId);
    void deleteCartAndItemsByUserId(int userId);
}
