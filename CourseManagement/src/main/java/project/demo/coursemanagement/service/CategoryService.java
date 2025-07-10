package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.CategoryDAO;
import project.demo.coursemanagement.dao.impl.CategoryDAOImpl;
import project.demo.coursemanagement.dto.CategoryDTO;

import java.util.List;

public class CategoryService {
    private final CategoryDAO categoryDAO;

    public CategoryService() {
        this.categoryDAO = new CategoryDAOImpl();
    }

    public List<CategoryDTO> getAllCategories() {
        return categoryDAO.getAllCategories();
    }
}
