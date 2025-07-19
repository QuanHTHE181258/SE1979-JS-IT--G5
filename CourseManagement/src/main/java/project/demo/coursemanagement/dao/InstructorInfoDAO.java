package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.UserDTO;
import project.demo.coursemanagement.entities.User;

import java.util.List;

public interface InstructorInfoDAO {

    UserDTO getUserByUsername(String username);

    List<CourseDTO> getCoursesByInstructorUsername(String username);

}
