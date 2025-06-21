package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.impl.CourseDAOImp;
import project.demo.coursemanagement.dto.CourseDTO;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.format.DateTimeParseException;

@WebServlet("/update-course")
public class UpdateCourseServlet extends HttpServlet {

    private final CourseDAOImp courseDAO = new CourseDAOImp();

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
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        String level = request.getParameter("level");
        String isPublishedStr = request.getParameter("isPublished");
        String isActiveStr = request.getParameter("isActive");
        String categoryIdStr = request.getParameter("categoryId");
        String enrollmentStartStr = request.getParameter("enrollmentStartDate");
        String enrollmentEndStr = request.getParameter("enrollmentEndDate");
        String teacherIdStr = request.getParameter("teacherId");

        CourseDTO course = new CourseDTO();
        course.setCourseCode(courseCode);
        course.setTitle(title);
        course.setShortDescription(shortDescription);
        course.setDescription(description);
        course.setImageUrl(imageUrl);
        course.setLevel(level);
        course.setPublished("1".equals(isPublishedStr) || "true".equalsIgnoreCase(isPublishedStr));
        course.setActive("1".equals(isActiveStr) || "true".equalsIgnoreCase(isActiveStr));

        try {
            if (title == null || title.trim().isEmpty()) {
                request.setAttribute("error", "Title is required.");
                forwardBackWithCourse(request, response, course);
                return;
            }

            BigDecimal price;
            try {
                price = new BigDecimal(priceStr);
                if (price.compareTo(BigDecimal.ZERO) < 0) throw new NumberFormatException();
                course.setPrice(price);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid price format.");
                forwardBackWithCourse(request, response, course);
                return;
            }

            try {
                course.setDurationHours(Integer.parseInt(durationStr));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid duration.");
                forwardBackWithCourse(request, response, course);
                return;
            }

            try {
                course.setMaxStudents(Integer.parseInt(maxStudentsStr));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid max students value.");
                forwardBackWithCourse(request, response, course);
                return;
            }

            try {
                course.setStartDate(parseDate(startDateStr));
                course.setEndDate(parseDate(endDateStr));
                course.setEnrollmentStartDate(parseDate(enrollmentStartStr));
                course.setEnrollmentEndDate(parseDate(enrollmentEndStr));
            } catch (DateTimeParseException e) {
                request.setAttribute("error", "Invalid date format.");
                forwardBackWithCourse(request, response, course);
                return;
            }

            course.setCategoryId(parseIntOrDefault(categoryIdStr, 0));
            course.setTeacherId(parseIntOrDefault(teacherIdStr, 4));

            boolean updated = courseDAO.updateCourse(course);
            if (updated) {
                response.sendRedirect("update-course?code=" + courseCode + "&status=success");
            } else {
                request.setAttribute("error", "Update failed. Please try again.");
                forwardBackWithCourse(request, response, course);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unexpected error occurred.");
            forwardBackWithCourse(request, response, course);
        }
    }
    private void forwardBackWithCourse(HttpServletRequest request, HttpServletResponse response, CourseDTO course)
            throws ServletException, IOException {
        request.setAttribute("course", course);
        request.getRequestDispatcher("/WEB-INF/views/update-course.jsp").forward(request, response);
    }

    private Instant parseDate(String dateStr) {
        return (dateStr != null && !dateStr.isEmpty()) ? Instant.parse(dateStr + "T00:00:00Z") : null;
    }

    private int parseIntOrDefault(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

}

