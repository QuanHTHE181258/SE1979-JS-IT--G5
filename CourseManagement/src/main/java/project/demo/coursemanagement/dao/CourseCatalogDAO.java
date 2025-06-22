package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.entities.Cours;

public interface CourseCatalogDAO {

    CourseDTO getCourseInfoById(int id);

}
