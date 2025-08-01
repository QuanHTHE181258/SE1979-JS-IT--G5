package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/introduce")
public class IntroduceController extends HttpServlet {@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8"); // xử lý request POST/GET
    response.setContentType("text/html;charset=UTF-8"); // trả về HTML với UTF-8

    request.getRequestDispatcher("/WEB-INF/views/introduce.jsp").forward(request, response);
}

}
