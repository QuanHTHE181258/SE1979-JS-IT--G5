package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet("/createcourse")
public class CreateCourseServlet extends HttpServlet {
    private static final Pattern URL_PATTERN = Pattern.compile(
            "^(https?://)?([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$"
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set default dates for the form
        LocalDate today = LocalDate.now();
        request.setAttribute("minDate", today.format(DateTimeFormatter.ISO_DATE));
        request.setAttribute("maxDate", today.plusYears(1).format(DateTimeFormatter.ISO_DATE));

        // Forward đến trang JSP để hiển thị form
        request.getRequestDispatcher("/WEB-INF/views/createcourse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> errors = new ArrayList<>();

        try {
            // Lấy và sanitize dữ liệu từ form
            String courseCode = sanitizeInput(request.getParameter("courseCode"));
            String title = sanitizeInput(request.getParameter("title"));
            String shortDescription = sanitizeInput(request.getParameter("shortDescription"));
            String description = sanitizeInput(request.getParameter("description"));
            String imageUrl = sanitizeInput(request.getParameter("imageUrl"));
            String level = sanitizeInput(request.getParameter("level"));
            String teacherId = sanitizeInput(request.getParameter("teacherId"));
            String categoryId = sanitizeInput(request.getParameter("categoryId"));

            // Parse và validate các trường số
            double price = validateAndParseDouble(request.getParameter("price"), "Price", errors);
            int durationHours = validateAndParseInt(request.getParameter("durationHours"), "Duration", errors);
            int maxStudents = validateAndParseInt(request.getParameter("maxStudents"), "Max Students", errors);

            // Parse và validate các trường ngày tháng
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate enrollmentStartDate = validateAndParseDate(request.getParameter("enrollmentStartDate"), "Enrollment Start Date", errors, formatter);
            LocalDate enrollmentEndDate = validateAndParseDate(request.getParameter("enrollmentEndDate"), "Enrollment End Date", errors, formatter);
            LocalDate startDate = validateAndParseDate(request.getParameter("startDate"), "Course Start Date", errors, formatter);
            LocalDate endDate = validateAndParseDate(request.getParameter("endDate"), "Course End Date", errors, formatter);

            // Validation logic
            validateRequiredField(courseCode, "Course Code", errors);
            validateRequiredField(title, "Title", errors);
            validateRequiredField(level, "Level", errors);
            validateRequiredField(teacherId, "Instructor", errors);
            validateRequiredField(categoryId, "Category", errors);

            // Validate dates
            if (enrollmentStartDate != null && enrollmentEndDate != null) {
                if (enrollmentStartDate.isAfter(enrollmentEndDate)) {
                    errors.add("Enrollment start date must be before end date");
                }
            }

            if (startDate != null && endDate != null) {
                if (startDate.isAfter(endDate)) {
                    errors.add("Course start date must be before end date");
                }
            }

            if (enrollmentEndDate != null && startDate != null) {
                if (enrollmentEndDate.isAfter(startDate)) {
                    errors.add("Enrollment end date must be before course start date");
                }
            }

            // Validate image URL if provided
            if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                if (!URL_PATTERN.matcher(imageUrl).matches()) {
                    errors.add("Invalid image URL format");
                }
            }

            // If there are any errors, return to the form
            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("formData", request.getParameterMap());
                request.getRequestDispatcher("/WEB-INF/views/create_course.jsp").forward(request, response);
                return;
            }

            // TODO: Lưu dữ liệu vào database tại đây
            // Log tạm ra console
            System.out.println("New Course Created:");
            System.out.println("Code: " + courseCode);
            System.out.println("Title: " + title);
            System.out.println("Short: " + shortDescription);
            System.out.println("Detail: " + description);
            System.out.println("Image URL: " + imageUrl);
            System.out.println("Level: " + level);
            System.out.println("Price: " + price);
            System.out.println("Duration: " + durationHours);
            System.out.println("Max Students: " + maxStudents);
            System.out.println("Teacher ID: " + teacherId);
            System.out.println("Category ID: " + categoryId);
            System.out.println("Enrollment Start: " + enrollmentStartDate);
            System.out.println("Enrollment End: " + enrollmentEndDate);
            System.out.println("Course Start: " + startDate);
            System.out.println("Course End: " + endDate);

            // Trả về view xác nhận
            request.setAttribute("message", "Course created successfully!");
            request.getRequestDispatcher("/WEB-INF/views/success.jsp").forward(request, response);

        } catch (Exception e) {
            errors.add("An unexpected error occurred: " + e.getMessage());
            request.setAttribute("errors", errors);
            request.setAttribute("formData", request.getParameterMap());
            request.getRequestDispatcher("/WEB-INF/views/create_course.jsp").forward(request, response);
        }
    }

    private String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        // Remove HTML tags and encode special characters
        return input.replaceAll("<[^>]*>", "").trim();
    }

    private void validateRequiredField(String value, String fieldName, List<String> errors) {
        if (value == null || value.trim().isEmpty()) {
            errors.add(fieldName + " is required");
        }
    }

    private double validateAndParseDouble(String value, String fieldName, List<String> errors) {
        try {
            double number = Double.parseDouble(value);
            if (number < 0) {
                errors.add(fieldName + " cannot be negative");
            }
            return number;
        } catch (NumberFormatException e) {
            errors.add("Invalid " + fieldName.toLowerCase() + " format");
            return -1;
        }
    }

    private int validateAndParseInt(String value, String fieldName, List<String> errors) {
        try {
            int number = Integer.parseInt(value);
            if (number <= 0) {
                errors.add(fieldName + " must be positive");
            }
            return number;
        } catch (NumberFormatException e) {
            errors.add("Invalid " + fieldName.toLowerCase() + " format");
            return -1;
        }
    }

    private LocalDate validateAndParseDate(String value, String fieldName, List<String> errors, DateTimeFormatter formatter) {
        try {
            return LocalDate.parse(value, formatter);
        } catch (DateTimeParseException e) {
            errors.add("Invalid " + fieldName.toLowerCase() + " format");
            return null;
        }
    }
}