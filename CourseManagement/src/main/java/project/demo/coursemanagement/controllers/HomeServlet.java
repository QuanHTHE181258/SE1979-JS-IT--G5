package project.demo.coursemanagement.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.service.HomeService;
import project.demo.coursemanagement.service.EnrollmentService;

@WebServlet(name = "HomeServlet",urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    private HomeService homeService;
    private EnrollmentService enrollmentService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.homeService = new HomeService();
        this.enrollmentService = EnrollmentService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch course lists using HomeService
        request.setAttribute("mostPopularCourses", homeService.getMostPopularCourses());
        request.setAttribute("paidCourses", homeService.getPaidCourses());
        request.setAttribute("freeCourses", homeService.getFreeCourses());

        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
