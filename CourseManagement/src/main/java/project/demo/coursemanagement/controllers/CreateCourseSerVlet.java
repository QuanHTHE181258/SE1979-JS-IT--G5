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
import project.demo.coursemanagement.dao.impl.UserDAOImpl;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Category;
import project.demo.coursemanagement.dao.CategoryDAO;
import project.demo.coursemanagement.dao.impl.CategoryDAOImpl;
import project.demo.coursemanagement.dao.UserDAO;
import project.demo.coursemanagement.dto.CategoryDTO;

@WebServlet(name = "CreateCourseServlet", urlPatterns = {"/create-course"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024)
public class CreateCourseSerVlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loggedInUser");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        CategoryDAO categoryDAO = new CategoryDAOImpl();
        List<CategoryDTO> categories = categoryDAO.getAllCategories();
        req.setAttribute("categories", categories);

        // Lấy danh sách instructor (chỉ user có role Instructor)
        UserDAO userDAO = new UserDAOImpl();
        List<User> instructors = userDAO.findUsers("", "Teacher", 0, 100); // Lọc theo role Instructor
        req.setAttribute("instructors", instructors);

        req.getRequestDispatcher("/WEB-INF/views/manage-course/create-course.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Map<String, String> errors = new HashMap<>();
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String categoryIdStr = req.getParameter("categoryId");
        String instructorIdStr = req.getParameter("instructorId");
        Part imagePart = req.getPart("image");

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
        Long categoryId = null;
        try {
            categoryId = Long.parseLong(categoryIdStr);
        } catch (Exception e) {
            errors.put("categoryId", "Category is required.");
        }
        Long instructorId = null;
        try {
            instructorId = Long.parseLong(instructorIdStr);
        } catch (Exception e) {
            errors.put("instructorId", "Instructor is required.");
        }
        String imageFileName = null;
        if (imagePart == null || imagePart.getSize() == 0) {
            errors.put("image", "Image is required.");
        } else {
            String submittedFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            if (!submittedFileName.matches("(?i).+\\.(jpg|jpeg|png|gif)$")) {
                errors.put("image", "Only image files (jpg, jpeg, png, gif) are allowed.");
            } else {
                imageFileName = System.currentTimeMillis() + "_" + submittedFileName;
            }
        }

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            doGet(req, resp);
            return;
        }

        // Lưu ảnh
        String uploadPath = getServletContext().getRealPath("/assets/images/");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();
        imagePart.write(uploadPath + File.separator + imageFileName);
        String imageUrl = "assets/images/" + imageFileName;

        // Chuẩn bị entity Cours
        Cours cours = new Cours();
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
        category.setId(Integer.parseInt(categoryIdStr));
        cours.setCategory(category);
        cours.setStatus("active");
        // Lưu DB
        CourseDAO courseDAO = new CourseDAOImpl();
        boolean success = courseDAO.insertCourse(cours);
        if (!success) {
            errors.put("global", "Lỗi khi lưu khóa học vào hệ thống. Vui lòng thử lại!");
            req.setAttribute("errors", errors);
            doGet(req, resp);
            return;
        }
        resp.sendRedirect("view-all");
    }
}
