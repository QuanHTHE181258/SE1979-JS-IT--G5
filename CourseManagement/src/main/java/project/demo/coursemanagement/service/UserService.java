package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.impl.UserDAOImpl;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.utils.PasswordUtil;
import project.demo.coursemanagement.dao.RoleDAO;
import project.demo.coursemanagement.dao.impl.RoleDAOImpl;

import java.util.List;

public class UserService {

    private static final int USERS_PER_PAGE = 10;
    private final UserDAO userDAO;
    private final RoleDAO roleDAO;

    public UserService(){
        this.userDAO = new UserDAOImpl();
        this.roleDAO = new RoleDAOImpl(); // Assuming you have a RoleDAO
    }

    public User authenticate(String identifier, String password){
        //find user by user name or email
        User user = userDAO.findUserByUsernameOrEmail(identifier);
        if(user == null){
            System.out.println("User not found");
            return null;
        }

        if(!user.getIsActive()){
            System.out.println("User is not active");
            return null;
        }

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

    public void createUser(String username, String email, String password, String firstName, String lastName, String phone, String roleName) throws Exception {
        // Basic validation - only require username, email, password, and roleName for creation
        if (username == null || username.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty() || roleName == null || roleName.trim().isEmpty()) {
            throw new IllegalArgumentException("Username, email, password, and role are required.");
        }

        // Check username and email existence
        if (userDAO.findUserByUsernameOrEmail(username) != null) {
            throw new Exception("Username or Email already exists"); // Assuming findUserByUsernameOrEmail checks both
        }

        // Find Role by name
        Role role = roleDAO.findByRoleName(roleName); // Assuming RoleDAO has findByRoleName
        if (role == null) {
            throw new IllegalArgumentException("Invalid role specified.");
        }

        // Create User object
        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        user.setRole(role);
        user.setIsActive(true);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPhone(phone);
        user.setEmailVerified(false); // Set default value
        // Set other default fields if necessary (e.g., created_at, updated_at)

        boolean success = userDAO.createUser(user);
        if (!success) {
            throw new Exception("Failed to create user.");
        }
    }

    public void updateUser(int userId, String username, String email, String phone, String roleName, boolean isActive) throws Exception {
        // Basic validation
         if (username == null || username.trim().isEmpty() || email == null || email.trim().isEmpty() || phone == null || phone.trim().isEmpty() || roleName == null || roleName.trim().isEmpty()) {
            throw new IllegalArgumentException("Username, email, phone, and role are required.");
        }

        User existingUser = userDAO.findUserByIdIncludeInactive(userId); // Use IncludeInactive to update status
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
        existingUser.setPhone(phone);
        existingUser.setRole(newRole);
        existingUser.setIsActive(isActive);
        // Update other fields if necessary (e.g., updated_at)

        boolean success = userDAO.updateUser(existingUser);
         if (!success) {
            throw new Exception("Failed to update user.");
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

     public void toggleUserStatus(int userId) throws Exception {
         User userToToggle = userDAO.findUserByIdIncludeInactive(userId);
         if (userToToggle == null) {
              throw new Exception("User not found.");
         }
          // TODO: Add check to prevent deactivating the currently logged-in user

         userToToggle.setIsActive(!userToToggle.getIsActive());

         boolean success = userDAO.updateUser(userToToggle);
          if (!success) {
            throw new Exception("Failed to toggle user status.");
        }
     }

     // Assuming RoleDAO exists and has findByRoleName
     // You might also need a method to get all roles for the dropdown in JSP
      public List<Role> getAllRoles() {
          return roleDAO.findAll(); // Assuming RoleDAO has findAll
      }
}
