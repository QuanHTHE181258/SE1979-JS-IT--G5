package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.service.CourseService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CourseManagerController", urlPatterns = {
        "/admin/courses",          // Trang giới thiệu tạo Course Manager
        "/admin/courses/new",      // Form/xử lý tạo Course Manager
        "/admin/course-management" // Trang quản lý khóa học
})
public class AdminCourseController extends HttpServlet {
    private final CourseService courseService = new CourseService();
    private static final int PAGE_SIZE = 3;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/admin/courses":
                request.getRequestDispatcher("/WEB-INF/views/admin_course.jsp").forward(request, response);
                break;

            case "/admin/courses/new":
                request.getRequestDispatcher("/WEB-INF/views/admin_course_new.jsp").forward(request, response);
                break;

            case "/admin/course-management":
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

                List<CourseDTO> courses = courseService.getCoursesForManager(keyword, categoryId, page, PAGE_SIZE);
                int totalCourses = courseService.countCourses(keyword, categoryId);
                int totalPages = (int) Math.ceil((double) totalCourses / PAGE_SIZE);

                request.setAttribute("courses", courses);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("keyword", keyword);
                request.setAttribute("categoryId", categoryId);

                request.getRequestDispatcher("/WEB-INF/views/manager-course.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/admin");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/courses/new".equals(path)) {
            // TODO: Implement course manager creation logic
            response.sendRedirect(request.getContextPath() + "/admin/courses");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }
}
