package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CourseCatalogDAO;
import project.demo.coursemanagement.dao.impl.CourseCatalogDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;

import java.util.List;

public class CourseCatalogService {
    private final CourseCatalogDAO dao = new CourseCatalogDAOimp();

    public List<CourseDTO> filterCourses(String category, String priceRange, String ratingRange, String status, int page, int size) {
        return dao.filterCourses(category, priceRange, ratingRange, status, page, size);
    }

    public int countFilteredCourses(String category, String priceRange, String ratingRange, String status) {
        return dao.countFilteredCourses(category, priceRange, ratingRange, status);
    }
}
