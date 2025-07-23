package project.demo.coursemanagement.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.service.HomeService;
import project.demo.coursemanagement.utils.SessionUtil;

@WebServlet(name = "HomeServlet",urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    private HomeService homeService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.homeService = new HomeService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch course lists using HomeService
        if(SessionUtil.getUserRole(request)!=null){
            if(SessionUtil.getUserRole(request).equals("5") || SessionUtil.getUserRole(request).equals("4")
            || SessionUtil.getUserRole(request).equals("3") || SessionUtil.getUserRole(request).equals("2")){
                request.getRequestDispatcher("/WEB-INF/views/errol.html").forward(request, response);
            }
        }

        request.setAttribute("highestRatedCourses", homeService.getHighestRatedCourses());
        request.setAttribute("paidCourses", homeService.getPaidCourses());
        request.setAttribute("freeCourses", homeService.getFreeCourses());

        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
