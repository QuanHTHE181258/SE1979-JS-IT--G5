package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CategoryDTO;

import java.util.List;

public interface CategoryDAO {
    /**
     * Retrieves all categories from the database
     * @return List of CategoryDTO objects
     */
    List<CategoryDTO> getAllCategories();

    /**
     * Gets a category by its ID
     * @param id The category ID
     * @return The CategoryDTO object or null if not found
     */
    CategoryDTO getCategoryById(Long id);

    /**
     * Creates a new category
     * @param category The category to create
     * @return The ID of the created category
     */
    Long createCategory(CategoryDTO category);

    /**
     * Updates an existing category
     * @param category The category with updated information
     * @return true if successful, false otherwise
     */
    boolean updateCategory(CategoryDTO category);

    /**
     * Deletes a category by its ID
     * @param id The ID of the category to delete
     * @return true if successful, false otherwise
     */
    boolean deleteCategory(Long id);
}
