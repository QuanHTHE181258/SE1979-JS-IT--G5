package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.impl.UserDAOImpl;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.utils.PasswordUtil;
import project.demo.coursemanagement.dao.RoleDAO;
import project.demo.coursemanagement.dao.impl.RoleDAOImpl;
import project.demo.coursemanagement.dao.UserRoleDAO;
import project.demo.coursemanagement.dao.impl.UserRoleDAOImpl;

import java.util.List;

public class UserService {

    private static final int USERS_PER_PAGE = 10;
    private final UserDAO userDAO;
    private final RoleDAO roleDAO;
    private final UserRoleDAO userRoleDAO;

    public UserService(){
        this.userDAO = new UserDAOImpl();
        this.roleDAO = new RoleDAOImpl();
        this.userRoleDAO = new UserRoleDAOImpl();
    }

    public User authenticate(String identifier, String password){
        //find user by user name or email
        User user = userDAO.findUserByUsernameOrEmail(identifier);
        if(user == null){
            System.out.println("User not found");
            return null;
        }

        // Check if password matches
        if(PasswordUtil.verifyPassword(password, user.getPasswordHash())){
            userDAO.UpdateLastLogin(user.getId());
            System.out.println("Authentication successful");
            return user;
        }else{
            System.out.println("Authentication failed");
            return null;
        }
    }

    public boolean isValidCredentials(String identifier, String password) {
        return authenticate(identifier, password) != null;
    }

    // Methods for User Management

    public List<User> getUsers(String search, String roleName, int page) {
        int offset = (page - 1) * USERS_PER_PAGE;
        // If roleName is null or empty, filter by TEACHER and USER implicitly if needed, 
        // or handle this logic in the DAO based on your exact requirements for "All Roles"
        // For now, directly pass roleName to DAO, assuming DAO handles null/empty by not filtering.
        // If "All Roles" means ONLY Teacher and User, you might need to adjust here or in DAO.
        return userDAO.findUsers(search, roleName, offset, USERS_PER_PAGE);
    }

    public int getTotalPages(String search, String roleName) {
        int totalUsers = userDAO.countUsers(search, roleName);
        return (int) Math.ceil((double) totalUsers / USERS_PER_PAGE);
    }

    public User getUserById(int userId) {
         // Use findUserByIdIncludeInactive if you need to edit inactive users
        return userDAO.findUserById(userId); 
    }

    public User getUserByIdWithRole(int userId) {
        User user = userDAO.findUserById(userId);
        if (user != null) {
            // Get user's role
            List<Role> userRoles = userRoleDAO.findRolesByUserId(userId);
            // Không setRole vào entity User nữa
            // Nếu cần, có thể trả về userRoles.get(0) hoặc roleName ngoài entity
        }
        return user;
    }

    public void createUser(String username, String email, String password, String firstName, String lastName, String phoneNumber, String roleName) throws Exception {
        // Basic validation - only require username, email, password, and roleName for creation
        if (username == null || username.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty() || roleName == null || roleName.trim().isEmpty()) {
            throw new IllegalArgumentException("Username, email, password, and role are required.");
        }

        // Check username and email existence
        if (userDAO.findUserByUsernameOrEmail(username) != null) {
            throw new Exception("Username or Email already exists"); // Assuming findUserByUsernameOrEmail checks both
        }

        // Find Role by name
        Role role = roleDAO.findByRoleName(roleName);
        if (role == null) {
            throw new IllegalArgumentException("Invalid role specified.");
        }

        // Create User object
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPhoneNumber(phoneNumber);
        // Set other default fields if necessary (e.g., created_at, updated_at)

        // Create the user first
        boolean success = userDAO.createUser(user);
        if (!success) {
            throw new Exception("Failed to create user.");
        }

        // Then assign the role to the user
        success = userRoleDAO.assignRoleToUser(user.getId(), role.getId());
        if (!success) {
            // If role assignment fails, delete the user to maintain consistency
            userDAO.deleteUser(user.getId());
            throw new Exception("Failed to assign role to user.");
        }
    }

    public void updateUser(int userId, String username, String email, String phoneNumber, String roleName) throws Exception {
        // Basic validation
         if (username == null || username.trim().isEmpty() || email == null || email.trim().isEmpty() || phoneNumber == null || phoneNumber.trim().isEmpty() || roleName == null || roleName.trim().isEmpty()) {
            throw new IllegalArgumentException("Username, email, phone, and role are required.");
        }

        User existingUser = userDAO.findUserById(userId); // Use findUserById since no isActive field
        if (existingUser == null) {
            throw new Exception("User not found.");
        }

        // Check if email is being changed and if new email already exists
        if (!existingUser.getEmail().equalsIgnoreCase(email)) {
             User userWithSameEmail = userDAO.findUserByUsernameOrEmail(email); // Assuming this checks email only if input is email format
             if (userWithSameEmail != null && !userWithSameEmail.getId().equals(userId)) {
                 throw new Exception("Email already exists.");
             }
        }
         // Check if username is being changed and if new username already exists
         if (!existingUser.getUsername().equalsIgnoreCase(username)) {
              User userWithSameUsername = userDAO.findUserByUsernameOrEmail(username); // Assuming this checks username only if input is not email format
              if (userWithSameUsername != null && !userWithSameUsername.getId().equals(userId)) {
                  throw new Exception("Username already exists.");
              }
         }

        // Find Role by name
        Role newRole = roleDAO.findByRoleName(roleName); 
        if (newRole == null) {
            throw new IllegalArgumentException("Invalid role specified.");
        }

        // Update user object
        existingUser.setUsername(username);
        existingUser.setEmail(email);
        existingUser.setPhoneNumber(phoneNumber);
        // Update other fields if necessary (e.g., updated_at)

        boolean success = userDAO.updateUser(existingUser);
        if (!success) {
            throw new Exception("Failed to update user.");
        }

        // Update user role
        // First remove all existing roles
        userRoleDAO.removeAllRolesFromUser(userId);
        // Then assign the new role
        success = userRoleDAO.assignRoleToUser(userId, newRole.getId());
        if (!success) {
            throw new Exception("Failed to update user role.");
        }
    }

     public void deleteUser(int userId) throws Exception {
         User userToDelete = userDAO.findUserById(userId);
         if (userToDelete == null) {
             throw new Exception("User not found.");
         }
         // TODO: Add check to prevent deleting the currently logged-in user

         boolean success = userDAO.deleteUser(userId);
          if (!success) {
            throw new Exception("Failed to delete user.");
        }
     }

     // Note: User entity no longer has isActive field, so this method is removed
     // If status tracking is needed, it should be implemented differently

     // Assuming RoleDAO exists and has findByRoleName
     // You might also need a method to get all roles for the dropdown in JSP
      public List<Role> getAllRoles() {
          return roleDAO.findAll(); // Assuming RoleDAO has findAll
      }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public User findUserByIdIncludeInactive(int userId) {
        return userDAO.findUserByIdIncludeInactive(userId);
    }

    public boolean updateUserActiveStatus(int userId, boolean active) {
        project.demo.coursemanagement.dao.RegisterDAO registerDAO = new project.demo.coursemanagement.dao.impl.RegisterDAOImpl();
        return registerDAO.updateUserActiveStatus(userId, active);
    }

    public List<User> searchRecentActivities(String keyword, int limit, String role) {
        return userDAO.searchRecentActivities(keyword, limit, role);
    }

    public List<User> getRecentUsersByRole(int limit, String role) {
        return userDAO.getRecentUsersByRole(limit, role);
    }

    public Role getPrimaryRoleByUserId(int userId) {
        return userRoleDAO.findPrimaryRoleByUserId(userId);
    }

}
