package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.UserDAOImpl;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.PasswordUtil;

public class UserService {

    private final UserDAO userDAO;

    public UserService(){
        this.userDAO = new UserDAOImpl();
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
}
