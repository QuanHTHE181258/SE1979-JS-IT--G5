package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dto.CourseDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/manager-courses")
public class ManagerCourseListServlet extends HttpServlet {
    private final CourseDAO courseDAO = new CourseDAO();
    private static final int PAGE_SIZE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String categoryParam = request.getParameter("categoryId");
        String pageParam = request.getParameter("page");

        Integer categoryId = null;
        int page = 1;

        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryParam);
            } catch (NumberFormatException ignored) {}
        }

        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        List<CourseDTO> courses = courseDAO.getCoursesForManager(keyword, categoryId, page, PAGE_SIZE);

        int totalCourses = courseDAO.countCourses(keyword, categoryId);
        int totalPages = (int) Math.ceil((double) totalCourses / PAGE_SIZE);

        request.setAttribute("courses", courses);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("categoryId", categoryId);

        request.getRequestDispatcher("/WEB-INF/views/manager-course.jsp").forward(request, response);
    }
}
