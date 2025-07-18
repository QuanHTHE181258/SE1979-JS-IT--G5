package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.User;

public interface InstructorInfoDAO {

    User getUserByUsername(String username);

}
