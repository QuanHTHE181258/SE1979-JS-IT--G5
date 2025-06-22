package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.impl.CourseDAOImpl;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewTeachingCoursesServlet", urlPatterns = {"/teaching-courses"})
public class ViewTeachingCoursesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loggedInUser");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        Integer instructorId = user.getId();
        CourseDAOImpl courseDAO = new CourseDAOImpl();
        List<Cours> courses = courseDAO.getCoursesByInstructorId(instructorId);
        req.setAttribute("courses", courses);
        req.getRequestDispatcher("/WEB-INF/views/teaching-courses.jsp").forward(req, resp);
    }
}
