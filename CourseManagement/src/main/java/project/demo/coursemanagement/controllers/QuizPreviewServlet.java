package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import project.demo.coursemanagement.dto.QuizDTO;
import project.demo.coursemanagement.service.QuizPreviewService;

import java.io.IOException;
import java.util.List;

@WebServlet("/quizPreview")
public class QuizPreviewServlet extends HttpServlet {

    private final QuizPreviewService quizService = QuizPreviewService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int quizId = Integer.parseInt(request.getParameter("id"));
            List<QuizDTO> quizList = quizService.getQuizById(quizId);

            request.setAttribute("quizList", quizList);
            request.getRequestDispatcher("WEB-INF/views/quiz-preview.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quiz ID không hợp lệ.");
        }
    }
}
