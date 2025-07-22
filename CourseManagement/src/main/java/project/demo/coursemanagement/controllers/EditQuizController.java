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
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet(name = "EditQuizController", urlPatterns = {"/edit-quiz"})
public class EditQuizController extends HttpServlet {
    private QuizDAO quizDAO;
    private static final Logger logger = Logger.getLogger(EditQuizController.class.getName());

    @Override
    public void init() throws ServletException {
        quizDAO = new QuizDAO();
        logger.info("EditQuizController initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        logger.info("GET request received for quiz ID: " + quizId);

        try {
            Quiz quiz = quizDAO.getQuizById(quizId);
            // Only check if user is logged in
            if (user == null) {
                logger.warning("Unauthorized access attempt - user not logged in");
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Please login to edit quizzes.");
                return;
            }

            logger.info("User " + user.getId() + " accessing quiz " + quizId);
            List<Question> questions = quizDAO.getQuestionsByQuizId(quizId);
            for (Question q : questions) {
                List<Answer> answers = quizDAO.getAnswerByQuestionId(q.getId());
                q.setAnswers(answers);
                logger.fine("Loaded question ID: " + q.getId() + " with " + answers.size() + " answers");
            }
            quiz.setQuestions(questions);
            request.setAttribute("quiz", quiz);
            logger.info("Successfully loaded quiz " + quizId + " with " + questions.size() + " questions");
            request.getRequestDispatcher("/WEB-INF/views/quiz/edit-quiz.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in doGet: " + e.getMessage(), e);
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        String action = request.getParameter("action");
        logger.info("POST request received - Action: " + action + ", Quiz ID: " + quizId);

        try {
            Quiz quiz = quizDAO.getQuizById(quizId);
            if (user == null) {
                logger.warning("Unauthorized post attempt - user not logged in");
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Please login to edit quizzes.");
                return;
            }

            // Handle delete actions first
            if ("deleteAnswer".equals(action)) {
                int answerId = Integer.parseInt(request.getParameter("answerId"));
                logger.info("Deleting answer ID: " + answerId);
                quizDAO.deleteAnswerOption(answerId);
                logger.info("Successfully deleted answer ID: " + answerId);
                response.sendRedirect("edit-quiz?quizId=" + quizId);
                return;
            } else if ("deleteQuestion".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                logger.info("Deleting question ID: " + questionId);
                quizDAO.deleteQuestion(questionId);
                logger.info("Successfully deleted question ID: " + questionId);
                response.sendRedirect("edit-quiz?quizId=" + quizId);
                return;
            } else if ("deleteQuiz".equals(action)) {
                logger.info("Deleting quiz ID: " + quizId);
                quizDAO.deleteQuiz(quizId);
                logger.info("Successfully deleted quiz ID: " + quizId);
                response.sendRedirect("learning-page");
                return;
            }

            // Handle other actions
            if ("updateQuiz".equals(action)) {
                String title = request.getParameter("title");
                logger.info("Updating quiz " + quizId + " title to: " + title);
                quiz.setTitle(title);
                quizDAO.updateQuiz(quiz);
                logger.info("Successfully updated quiz title");
            } else if ("updateQuestion".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                String questionText = request.getParameter("questionText");
                logger.info("Updating question ID: " + questionId + " text to: " + questionText);
                Question question = quizDAO.getQuestionById(questionId);
                question.setQuestionText(questionText);
                quizDAO.updateQuestion(question);
                logger.info("Successfully updated question ID: " + questionId);
            } else if ("updateAnswer".equals(action)) {
                int answerId = Integer.parseInt(request.getParameter("answerId"));
                String answerText = request.getParameter("answerText");
                boolean isCorrect = "on".equals(request.getParameter("isCorrect"));
                logger.info("Updating answer ID: " + answerId + " text to: " + answerText + ", isCorrect: " + isCorrect);
                Answer answer = quizDAO.getAnswerById(answerId);
                answer.setAnswerText(answerText);
                answer.setIsCorrect(isCorrect);
                quizDAO.updateAnswerOption(answer);
                logger.info("Successfully updated answer ID: " + answerId);
            } else if ("addQuestion".equals(action)) {
                String questionText = request.getParameter("newQuestionText");
                logger.info("Adding new question to quiz " + quizId + ": " + questionText);
                Question question = Question.builder()
                        .quizID(Quiz.builder().id(quizId).build())
                        .questionText(questionText)
                        .build();
                int newQuestionId = quizDAO.addQuestion(question);
                logger.info("Successfully added new question with ID: " + newQuestionId);
            } else if ("addAnswer".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                String answerText = request.getParameter("newAnswerText");
                boolean isCorrect = "on".equals(request.getParameter("isCorrect"));
                logger.info("Adding new answer to question " + questionId + ": " + answerText + ", isCorrect: " + isCorrect);
                Answer answer = Answer.builder()
                        .questionID(Question.builder().id(questionId).build())
                        .answerText(answerText)
                        .isCorrect(isCorrect)
                        .build();
                int newAnswerId = quizDAO.addAnswer(answer);
                logger.info("Successfully added new answer with ID: " + newAnswerId);
            }

            response.sendRedirect("edit-quiz?quizId=" + quizId);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in doPost: " + e.getMessage(), e);
            response.sendRedirect("error.jsp");
        }
    }
}
