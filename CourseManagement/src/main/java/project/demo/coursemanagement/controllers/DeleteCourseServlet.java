
package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.dao.impl.CourseDAOImp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/delete-course")
public class DeleteCourseServlet extends HttpServlet {
    @Override
    protected void doGet( HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String courseCode = request.getParameter("code");

        if (courseCode != null && !courseCode.isEmpty()) {
            CourseDAOImp dao = new CourseDAOImp();
            dao.deleteCourseByCode(courseCode);
        }

        response.sendRedirect("manager-courses");
    }
}
