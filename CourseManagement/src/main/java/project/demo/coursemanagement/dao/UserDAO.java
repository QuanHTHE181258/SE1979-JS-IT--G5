package project.demo.coursemanagement.dao;
import java.util.List;
import project.demo.coursemanagement.entities.User;

public interface UserDAO {

    User findUserByUsernameOrEmail(String identifier);
    User findUserById(Integer id);
    User findUserByIdIncludeInactive(Integer id);
    boolean UpdateLastLogin(Integer userId);
    List<User> getAllUsers();
    List<User> searchUsersByName(String searchTerm);
}
