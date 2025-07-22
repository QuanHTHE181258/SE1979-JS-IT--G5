package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.impl.QuizDAOImpl;
import project.demo.coursemanagement.entities.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/quiz-details")
public class QuizDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String quizId = request.getParameter("id");

        if (quizId != null && !quizId.isEmpty()) {
            try {
                QuizDAOImpl quizDAO = new QuizDAOImpl();
                Quiz quiz = quizDAO.getQuizById(Integer.parseInt(quizId));

                if (quiz != null) {
                    List<Question> questions = quizDAO.getQuestionsByQuizId(quiz.getId());
                    List<QuizAttempt> attempts = quizDAO.getAttemptsByQuizId(quiz.getId());

                    // Create a map to store answers for each question
                    Map<Integer, List<Answer>> questionAnswers = new HashMap<>();
                    for (Question question : questions) {
                        List<Answer> answers = quizDAO.getAnswersByQuestionId(question.getId());
                        questionAnswers.put(question.getId(), answers);
                    }

                    request.setAttribute("quiz", quiz);
                    request.setAttribute("questions", questions);
                    request.setAttribute("attempts", attempts);
                    request.setAttribute("questionAnswers", questionAnswers);

                    request.getRequestDispatcher("WEB-INF/views/quiz-details.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("list-lesson");
    }
}
