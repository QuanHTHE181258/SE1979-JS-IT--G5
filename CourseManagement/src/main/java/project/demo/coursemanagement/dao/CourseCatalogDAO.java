package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;

import java.util.List;

public interface CourseCatalogDAO {

    List<CourseDTO> filterCourses(String category, String priceRange, String ratingRange, String status, int page, int size);

    int countFilteredCourses(String category, String priceRange, String ratingRange, String status);

}
