package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;

import java.util.List;

public interface HomeDAO {

    List<CourseDTO> getAllCourses();

}