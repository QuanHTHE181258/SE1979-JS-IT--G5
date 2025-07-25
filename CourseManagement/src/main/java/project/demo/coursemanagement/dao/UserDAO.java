package project.demo.coursemanagement.dao;
import java.util.List;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Role;


public interface UserDAO {

    User findUserByUsernameOrEmail(String identifier);

    User findUserById(Integer id);

    User findUserByIdIncludeInactive(Integer id);

    boolean UpdateLastLogin(Integer userId);

    List<User> getAllUsers();
    List<User> getRecentUsersByRole(int limit, String role);

    List<User> searchUsersByName(String searchTerm);

    List<User> getRecentLogins(int limit);

    boolean updatePassword(Integer userId, String newPassword);

    boolean updateAndUploadAvatar(Integer userId, String avatarPath);

    // Methods for User Management
    List<User> findUsers(String search, String roleName, int offset, int limit);
    int countUsers(String search, String roleName);
    boolean createUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(int userId);

    List<User> searchRecentActivities(String keyword, int limit, String role);
}
