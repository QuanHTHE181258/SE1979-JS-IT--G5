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

    public boolean blockUser(int userId) {
        System.out.println("[LOG] Attempting to block user with ID: " + userId);
        boolean result = userDAO.blockUser(userId);
        System.out.println("[LOG] Block user result for ID " + userId + ": " + result);
        return result;
    }

    public boolean unblockUser(int userId) {
        System.out.println("[LOG] Attempting to unblock user with ID: " + userId);
        boolean result = userDAO.unblockUser(userId);
        System.out.println("[LOG] Unblock user result for ID " + userId + ": " + result);
        return result;
    }

    public User authenticate(String identifier, String password){
        //find user by user name or email
        User user = userDAO.findUserByUsernameOrEmail(identifier);
        if(user == null){
            System.out.println("User not found");
            return null;
        }
        // Check if blocked
        if(user.isBlocked()){
            System.out.println("Tài khoản đã bị chặn");
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

    public User findUserById(Integer userId) {
        if (userId == null) {
            return null;
        }
        return userDAO.findUserById(userId);
    }

    public List<User> getUsers(String search, String roleFilter, int page) {
        int offset = (page - 1) * USERS_PER_PAGE;
        List<User> users = userDAO.findUsers(search, roleFilter, offset, USERS_PER_PAGE);
        long blockedCount = users.stream().filter(User::isBlocked).count();
        System.out.println("[LOG] User list loaded: total=" + users.size() + ", blocked=" + blockedCount);
        users.forEach(u -> System.out.println("[LOG] UserID=" + u.getId() + ", Username=" + u.getUsername() + ", Blocked=" + u.isBlocked()));
        return users;
    }

//    public int getTotalPages(String search, String roleName) {
//        int totalUsers = userDAO.total(search, roleName);
//        return (int) Math.ceil((double) totalUsers / USERS_PER_PAGE);
//    }

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
        System.out.println("=== Starting user creation process ===");
        System.out.println("Raw roleName received: '" + roleName + "'");

        // Basic validation
        if (username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                roleName == null || roleName.trim().isEmpty()) {
            throw new IllegalArgumentException("Username, email, password, and role are required.");
        }

        // Check username and email existence
        System.out.println("Checking for existing username/email...");
        User existingUser = userDAO.findUserByUsernameOrEmail(username);
        if (existingUser != null) {
            System.out.println("Username/Email already exists!");
            throw new Exception("Username or Email already exists");
        }

        // Find Role by name
        System.out.println("Looking up role with exact name: '" + roleName + "'");
        Role role = roleDAO.findByRoleName(roleName);
        if (role == null) {
            System.out.println("Role not found in database. Available roles:");
            List<Role> allRoles = roleDAO.findAll();
            for (Role r : allRoles) {
                System.out.println("- '" + r.getRoleName() + "' (ID: " + r.getId() + ")");
            }
            throw new IllegalArgumentException("Invalid role specified: " + roleName);
        }
        System.out.println("Found role: '" + role.getRoleName() + "' (ID: " + role.getId() + ")");

        // Create User object
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPhoneNumber(phoneNumber);

        // Create the user first
        System.out.println("Creating user in database...");
        boolean success = userDAO.createUser(user);
        if (!success) {
            System.out.println("Failed to create user!");
            throw new Exception("Failed to create user.");
        }
        System.out.println("User created successfully with ID: " + user.getId());

        // Then assign the role to the user
        System.out.println("Assigning role to user...");
        success = userRoleDAO.assignRoleToUser(user.getId(), role.getId());
        if (!success) {
            System.out.println("Failed to assign role! Rolling back user creation...");
            userDAO.deleteUser(user.getId());
            throw new Exception("Failed to assign role to user.");
        }
        System.out.println("Role assigned successfully");
        System.out.println("=== User creation completed successfully ===");
    }
    public int countUsers(String search, String roleName){
        return userDAO.countUsers(search, roleName);
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

    public int getTotalUsers(String search, String roleFilter) {
        return userDAO.countUsers(search, roleFilter);
    }

    public User findById(int userId) {
        return userDAO.findUserById(userId);
    }

    public boolean updateUser(User user) {
        try {
            userDAO.updateUser(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
