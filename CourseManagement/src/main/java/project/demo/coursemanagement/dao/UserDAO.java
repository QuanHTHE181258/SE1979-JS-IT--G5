package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.User;

public interface UserDAO {

    User findUserByUsernameOrEmail(String identifier);
    User findUserById(Integer id);
    boolean UpdateLastLogin(Integer userId);
}
