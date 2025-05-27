package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.CourseDAO;
import project.demo.coursemanagement.dto.CourseDTO;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.time.Instant;
import java.time.format.DateTimeParseException;

@WebServlet("/update-course")
public class UpdateCourseServlet extends HttpServlet {

    private final CourseDAO courseDAO = new CourseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String courseCode = request.getParameter("code");
        if (courseCode == null || courseCode.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/courses.jsp");
            return;
        }

        CourseDTO course = courseDAO.getCourseByCode(courseCode);
        System.out.println("Searching course with code: " + courseCode);
        if (course == null) {
            System.out.println("Course not found!");
        }


        request.setAttribute("course", course);
        request.getRequestDispatcher("/WEB-INF/views/update-course.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String courseCode = request.getParameter("courseCode");
        String title = request.getParameter("title");
        String shortDescription = request.getParameter("shortDescription");
        String priceStr = request.getParameter("price");
        String durationStr = request.getParameter("durationHours");
        String maxStudentsStr = request.getParameter("maxStudents");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        CourseDTO course = new CourseDTO();
        course.setCourseCode(courseCode);
        course.setTitle(title);
        course.setShortDescription(shortDescription);

        try {
            course.setPrice(priceStr != null && !priceStr.isEmpty() ? new BigDecimal(priceStr) : null);
            course.setDurationHours(durationStr != null && !durationStr.isEmpty() ? Integer.parseInt(durationStr) : 0);
            course.setMaxStudents(maxStudentsStr != null && !maxStudentsStr.isEmpty() ? Integer.parseInt(maxStudentsStr) : 0);
            course.setStartDate(startDateStr != null && !startDateStr.isEmpty()
                    ? Instant.parse(startDateStr + "T00:00:00Z") : null);
            course.setEndDate(endDateStr != null && !endDateStr.isEmpty()
                    ? Instant.parse(endDateStr + "T00:00:00Z") : null);
            boolean updated = courseDAO.updateCourse(course);


        } catch (NumberFormatException | DateTimeParseException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/update-course?code="
                    + URLEncoder.encode(courseCode, "UTF-8") + "&error=invalidinput");
        }
    }
}
