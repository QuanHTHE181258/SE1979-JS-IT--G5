package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.service.CourseCatalogService;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/courseCatalog")
public class CourseCatalogServlet extends HttpServlet {
    private final CourseCatalogService service = new CourseCatalogService();
    private final int PAGE_SIZE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String priceRange = request.getParameter("priceRange");
        String ratingRange = request.getParameter("ratingRange");
        String status = request.getParameter("status");

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ignored) {}

        int totalCourses = service.countFilteredCourses(category, priceRange, ratingRange, status);
        int totalPages = (int) Math.ceil(totalCourses / (double) PAGE_SIZE);

        List<CourseDTO> courses = service.filterCourses(category, priceRange, ratingRange, status, page, PAGE_SIZE);

        request.setAttribute("courses", courses);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Preserve filters
        request.setAttribute("category", category);
        request.setAttribute("priceRange", priceRange);
        request.setAttribute("ratingRange", ratingRange);
        request.setAttribute("status", status);

        request.getRequestDispatcher("WEB-INF/views/course-catalog.jsp").forward(request, response);
    }
}
