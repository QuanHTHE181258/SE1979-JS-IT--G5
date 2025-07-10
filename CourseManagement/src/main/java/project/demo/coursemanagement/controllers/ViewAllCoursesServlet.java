package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dto.CourseStatsDTO;
import project.demo.coursemanagement.dto.CategoryDTO;
import project.demo.coursemanagement.service.CourseService;
import project.demo.coursemanagement.service.CategoryService;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for viewing all courses with statistics
 */
@WebServlet(name = "ViewAllCoursesServlet", urlPatterns = {"/view-all"})
public class ViewAllCoursesServlet extends HttpServlet {

    private CourseService courseService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            this.courseService = new CourseService();
            this.categoryService = new CategoryService();
            System.out.println("ViewAllCoursesServlet initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing ViewAllCoursesServlet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Failed to initialize servlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy categoryId từ query string (nếu có)
            String categoryParam = request.getParameter("categoryId");
            List<CourseStatsDTO> courseList;

            if (categoryParam != null && !categoryParam.isEmpty()) {
                try {
                    Long categoryId = Long.parseLong(categoryParam);
                    courseList = courseService.getCoursesByCategory(categoryId);
                    System.out.println("Loaded " + courseList.size() + " courses for category ID: " + categoryId);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid category ID format: " + categoryParam);
                    courseList = courseService.getAllCoursesWithStats();
                }
            } else {
                courseList = courseService.getAllCoursesWithStats();
                System.out.println("Loaded " + courseList.size() + " courses total");
            }

            // Lấy toàn bộ danh mục để hiển thị filter dropdown
            List<CategoryDTO> categoryList = categoryService.getAllCategories();
            System.out.println("Loaded " + categoryList.size() + " categories");

            // Debug information
            System.out.println("Setting attributes - courses: " + (courseList != null ? courseList.size() : "null"));
            System.out.println("Setting attributes - categories: " + (categoryList != null ? categoryList.size() : "null"));

            // Gửi dữ liệu sang JSP
            request.setAttribute("courses", courseList);
            request.setAttribute("categories", categoryList);

            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/views/manage-course/view-all.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Error in ViewAllCoursesServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to load course list: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect POST requests to GET
        doGet(request, response);
    }

    @Override
    public void destroy() {
        super.destroy();
        System.out.println("ViewAllCoursesServlet destroyed");
    }
}