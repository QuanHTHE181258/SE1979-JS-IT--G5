package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dao.impl.CourseDAOImpl;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Category;
import project.demo.coursemanagement.dao.CategoryDAO;
import project.demo.coursemanagement.dao.impl.CategoryDAOImpl;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dao.impl.UserDAOImpl;
import project.demo.coursemanagement.dto.CategoryDTO;

@WebServlet(name = "UpdateCourseServlet", urlPatterns = {"/update-course"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class UpdateCourseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect("view-all");
            return;
        }
        Integer id = null;
        try {
            id = Integer.parseInt(idStr);
        } catch (Exception e) {
            resp.sendRedirect("view-all");
            return;
        }
        CourseDAO courseDAO = new CourseDAOImpl();
        List<project.demo.coursemanagement.dto.CourseStatsDTO> courses = courseDAO.getAllCoursesWithStats();
        project.demo.coursemanagement.dto.CourseStatsDTO course = null;
        for (var c : courses) {
            if (c.getId() != null && c.getId().intValue() == id) {
                course = c;
                break;
            }
        }
        if (course == null) {
            resp.sendRedirect("view-all");
            return;
        }
        // Lấy danh sách category
        CategoryDAO categoryDAO = new CategoryDAOImpl();
        List<CategoryDTO> categories = categoryDAO.getAllCategories();
        req.setAttribute("categories", categories);
        // Lấy danh sách instructor
        UserDAO userDAO = new UserDAOImpl();
        List<User> instructors = userDAO.findUsers("", "Teacher", 0, 100);
        req.setAttribute("instructors", instructors);
        req.setAttribute("course", course);
        req.getRequestDispatcher("/WEB-INF/views/manage-course/update-course.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Map<String, String> errors = new HashMap<>();
        String idStr = req.getParameter("id");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String categoryIdStr = req.getParameter("categoryId");
        String instructorIdStr = req.getParameter("instructorId");
        Part imagePart = req.getPart("image");
        String oldImage = req.getParameter("oldImage");
        Integer id = null;
        try {
            id = Integer.parseInt(idStr);
        } catch (Exception e) {
            resp.sendRedirect("view-all");
            return;
        }
        // Validation
        if (title == null || title.trim().isEmpty() || title.length() > 255) {
            errors.put("title", "Title is required and must be less than 255 characters.");
        }
        if (description == null || description.trim().isEmpty() || description.length() > 2000) {
            errors.put("description", "Description is required and must be less than 2000 characters.");
        }
        BigDecimal price = null;
        try {
            price = new BigDecimal(priceStr);
            if (price.compareTo(BigDecimal.ZERO) < 0) {
                errors.put("price", "Price must be non-negative.");
            }
        } catch (Exception e) {
            errors.put("price", "Invalid price.");
        }
        Integer categoryId = null;
        try {
            categoryId = Integer.parseInt(categoryIdStr);
        } catch (Exception e) {
            errors.put("categoryId", "Category is required.");
        }
        Integer instructorId = null;
        try {
            instructorId = Integer.parseInt(instructorIdStr);
        } catch (Exception e) {
            errors.put("instructorId", "Instructor is required.");
        }
        String imageFileName = null;
        String imageUrl = oldImage;
        if (imagePart != null && imagePart.getSize() > 0) {
            String submittedFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            if (!submittedFileName.matches("(?i).+\\.(jpg|jpeg|png|gif)$")) {
                errors.put("image", "Only image files (jpg, jpeg, png, gif) are allowed.");
            } else {
                imageFileName = System.currentTimeMillis() + "_" + submittedFileName;
                String uploadPath = getServletContext().getRealPath("/assets/images/");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                imagePart.write(uploadPath + File.separator + imageFileName);
                imageUrl = "assets/images/" + imageFileName;
            }
        }
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            doGet(req, resp);
            return;
        }
        // Chuẩn bị entity Cours
        Cours cours = new Cours();
        cours.setId(id);
        cours.setTitle(title);
        cours.setDescription(description);
        cours.setPrice(price);
        cours.setImageURL(imageUrl);
        // Gán instructor
        User instructor = new User();
        instructor.setId(instructorId != null ? instructorId.intValue() : null);
        cours.setInstructorID(instructor);
        // Gán category
        Category category = new Category();
        category.setId(categoryId);
        cours.setCategory(category);
        cours.setStatus("active");
        // Lưu DB
        CourseDAO courseDAO = new CourseDAOImpl();
        boolean success = courseDAO.updateCourse(cours);
        if (!success) {
            errors.put("global", "Lỗi khi cập nhật khóa học. Vui lòng thử lại!");
            req.setAttribute("errors", errors);
            doGet(req, resp);
            return;
        }
        resp.sendRedirect("view-all");
    }
}
