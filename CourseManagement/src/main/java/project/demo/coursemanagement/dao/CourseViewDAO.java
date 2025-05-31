package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Course;
import java.util.List;

public interface CourseViewDAO {

    List<CourseDTO> getAllCourses();

}
