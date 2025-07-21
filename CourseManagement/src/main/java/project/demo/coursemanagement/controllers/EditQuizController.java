package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.demo.coursemanagement.dao.impl.QuizDAO;
import project.demo.coursemanagement.entities.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "EditQuizController", urlPatterns = {"/edit-quiz"})
public class EditQuizController extends HttpServlet {
    private QuizDAO quizDAO;

    @Override
    public void init() throws ServletException {
        quizDAO = new QuizDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        try {
            Quiz quiz = quizDAO.getQuizById(quizId);
            // Only check if user is logged in
            if (user == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Please login to edit quizzes.");
                return;
            }
            List<Question> questions = quizDAO.getQuestionsByQuizId(quizId);
            for (Question q : questions) {
                List<Answer> answers = quizDAO.getAnswerByQuestionId(q.getId());
                q.setAnswers(answers);
            }
            quiz.setQuestions(questions);
            request.setAttribute("quiz", quiz);
            request.getRequestDispatcher("/WEB-INF/views/quiz/edit-quiz.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in EditQuizController.doGet: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        try {
            Quiz quiz = quizDAO.getQuizById(quizId);
            if (user == null) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Please login to edit quizzes.");
                return;
            }
            String action = request.getParameter("action");
            if ("updateQuiz".equals(action)) {
                String title = request.getParameter("title");
                quiz.setTitle(title);
                quizDAO.updateQuiz(quiz);
            } else if ("updateQuestion".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                String questionText = request.getParameter("questionText");
                Question question = quizDAO.getQuestionById(questionId);
                question.setQuestionText(questionText);
                quizDAO.updateQuestion(question);
            } else if ("updateAnswer".equals(action)) {
                int answerId = Integer.parseInt(request.getParameter("answerId"));
                String answerText = request.getParameter("answerText");
                boolean isCorrect = "on".equals(request.getParameter("isCorrect"));
                Answer answer = quizDAO.getAnswerById(answerId);
                answer.setAnswerText(answerText);
                answer.setIsCorrect(isCorrect);
                quizDAO.updateAnswerOption(answer);
            } else if ("addQuestion".equals(action)) {
                String questionText = request.getParameter("newQuestionText");
                Question question = Question.builder()
                        .quizID(Quiz.builder().id(quizId).build())
                        .questionText(questionText)
                        .build();
                quizDAO.addQuestion(question);
            } else if ("deleteQuestion".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                quizDAO.deleteQuestion(questionId);
            } else if ("addAnswer".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                String answerText = request.getParameter("newAnswerText");
                boolean isCorrect = "on".equals(request.getParameter("isCorrect"));
                Answer answer = Answer.builder()
                        .questionID(Question.builder().id(questionId).build())
                        .answerText(answerText)
                        .isCorrect(isCorrect)
                        .build();
                quizDAO.addAnswer(answer);
            } else if ("deleteAnswer".equals(action)) {
                int answerId = Integer.parseInt(request.getParameter("answerId"));
                quizDAO.deleteAnswerOption(answerId);
            } else if ("deleteQuiz".equals(action)) {
                quizDAO.deleteQuiz(quizId);
                response.sendRedirect("learning-page");
                return;
            }
            response.sendRedirect("edit-quiz?quizId=" + quizId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
