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

@WebServlet("/create-new-course")
public class CreateCourseServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/views/create-course.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String courseCode = req.getParameter("courseCode");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String shortDescription = req.getParameter("shortDescription");
        String teacherIdStr = req.getParameter("teacherId");
        String categoryIdStr = req.getParameter("categoryId");
        String imageUrl = req.getParameter("imageUrl");
        String priceStr = req.getParameter("price");
        String durationHoursStr = req.getParameter("durationHours");
        String level = req.getParameter("level");
        String isPublishedStr = req.getParameter("isPublished");
        String isActiveStr = req.getParameter("isActive");
        String maxStudentsStr = req.getParameter("maxStudents");
        String enrollmentStartDateStr = req.getParameter("enrollmentStartDate");
        String enrollmentEndDateStr = req.getParameter("enrollmentEndDate");
        String startDateStr = req.getParameter("startDate");
        String endDateStr = req.getParameter("endDate");

        String error = null;
        // Validate required fields
        if (courseCode == null || courseCode.isEmpty() ||
                title == null || title.isEmpty() ||
                teacherIdStr == null || teacherIdStr.isEmpty() ||
                categoryIdStr == null || categoryIdStr.isEmpty() ||
                priceStr == null || priceStr.isEmpty() ||
                durationHoursStr == null || durationHoursStr.isEmpty() ||
                maxStudentsStr == null || maxStudentsStr.isEmpty()) {
            error = "Please fill in all required fields.";
        }

        int teacherId = 0, categoryId = 0, durationHours = 0, maxStudents = 0;
        BigDecimal price = null;
        boolean isPublished = false, isActive = false;
        Instant enrollmentStartDate = null, enrollmentEndDate = null, startDate = null, endDate = null;
        if (error == null) {
            try {
                teacherId = Integer.parseInt(teacherIdStr);
                categoryId = Integer.parseInt(categoryIdStr);
                price = new BigDecimal(priceStr);
                durationHours = Integer.parseInt(durationHoursStr);
                maxStudents = Integer.parseInt(maxStudentsStr);
                isPublished = "on".equals(isPublishedStr) || "true".equals(isPublishedStr);
                isActive = "on".equals(isActiveStr) || "true".equals(isActiveStr);
                if (enrollmentStartDateStr != null && !enrollmentStartDateStr.isEmpty())
                    enrollmentStartDate = Instant.parse(enrollmentStartDateStr + "T00:00:00Z");
                if (enrollmentEndDateStr != null && !enrollmentEndDateStr.isEmpty())
                    enrollmentEndDate = Instant.parse(enrollmentEndDateStr + "T00:00:00Z");
                if (startDateStr != null && !startDateStr.isEmpty())
                    startDate = Instant.parse(startDateStr + "T00:00:00Z");
                if (endDateStr != null && !endDateStr.isEmpty())
                    endDate = Instant.parse(endDateStr + "T00:00:00Z");
            } catch (NumberFormatException | DateTimeParseException e) {
                error = "Invalid number or date format.";
            }
        }

        if (error != null) {
            req.setAttribute("error", error);
            req.getRequestDispatcher("WEB-INF/views/create-course.jsp").forward(req, resp);
            return;
        }

        CourseDTO course = new CourseDTO();
        course.setCourseCode(courseCode);
        course.setTitle(title);
        course.setDescription(description);
        course.setShortDescription(shortDescription);
        course.setTeacherId(teacherId);
        course.setCategoryId(categoryId);
        course.setImageUrl(imageUrl);
        course.setPrice(price);
        course.setDurationHours(durationHours);
        course.setLevel(level);
        course.setPublished(isPublished);
        course.setActive(isActive);
        course.setMaxStudents(maxStudents);
        course.setEnrollmentStartDate(enrollmentStartDate);
        course.setEnrollmentEndDate(enrollmentEndDate);
        course.setStartDate(startDate);
        course.setEndDate(endDate);

        boolean success = false;
        try {
            success = new CourseDAOImp().insertCourse(course);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
        if (success) {
            resp.sendRedirect("manager-courses");
        } else {
            throw new ServletException("Tạo khóa học thất bại. Không rõ nguyên nhân.");
        }
    }
}
