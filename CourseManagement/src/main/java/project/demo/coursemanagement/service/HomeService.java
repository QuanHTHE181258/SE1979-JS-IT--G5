package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.HomeDAO;
import project.demo.coursemanagement.dao.impl.HomeDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class HomeService {
    private HomeDAO homeDAO;

    public HomeService() {
        this.homeDAO = new HomeDAOimp();
    }

    public List<CourseDTO> getAllCourses() {
        return homeDAO.getAllCourses();
    }
}