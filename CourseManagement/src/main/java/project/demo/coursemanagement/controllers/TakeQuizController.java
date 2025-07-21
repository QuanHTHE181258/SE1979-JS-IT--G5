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

@WebServlet(name = "TakeQuizController", urlPatterns = {"/take-quiz"})
public class TakeQuizController extends HttpServlet {

    private QuizDAO quizDAO;

    @Override
    public void init() throws ServletException {
        quizDAO = new QuizDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "start";
        }

        try {
            switch (action) {
                case "start":
                    startQuiz(request, response);
                    break;
                case "result":
                    viewResult(request, response);
                    break;
                case "review":
                    reviewQuiz(request, response);
                    break;
                default:
                    response.sendRedirect("learning-page");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("submit".equals(action)) {
            submitQuiz(request, response);
        }
    }

    private void startQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            Quiz quiz = quizDAO.getQuizByLessonId(lessonId);

            if (quiz == null) {
                response.sendRedirect("learning-page?lessonId=" + lessonId);
                return;
            }

            // Create new quiz attempt with StartTime
            QuizAttempt attempt = quizDAO.createAttempt(quiz.getId(), user.getId());
            System.out.println("[DEBUG] Created new quiz attempt: " + attempt.getId() + " QuizID : " + quiz.getId() + " for user: " + user.getUsername());
            // Get questions and answers
            List<Question> questions = quizDAO.getQuestionsByQuizId(quiz.getId());
            for (Question question : questions) {
                List<Answer> answers = quizDAO.getAnswerByQuestionId(question.getId());
                question.setAnswers(answers);
            }
            quiz.setQuestions(questions);

            // Store in session
            session.setAttribute("currentQuiz", quiz);
            session.setAttribute("currentAttempt", attempt);

            request.setAttribute("quiz", quiz);
            request.getRequestDispatcher("/WEB-INF/views/quiz/take-quiz.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("learning-page");
        }
    }

    private void submitQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        QuizAttempt attempt = (QuizAttempt) session.getAttribute("currentAttempt");
        Quiz quiz = (Quiz) session.getAttribute("currentQuiz");

        if (attempt == null || quiz == null) {
            response.sendRedirect("learning-page");
            return;
        }

        try {
            // Get questions and process answers
            List<Question> questions = quizDAO.getQuestionsByQuizId(quiz.getId());
            int correctAnswers = 0;

            for (Question question : questions) {
                String selectedAnswerId = request.getParameter("question_" + question.getId());
                if (selectedAnswerId != null) {
                    int answerId = Integer.parseInt(selectedAnswerId);
                    Answer selectedAnswer = quizDAO.getAnswerById(answerId);

                    // Save user's answer
                    quizDAO.saveQuestionAnswer(
                        attempt.getId(),
                        question.getId(),
                        answerId,
                        selectedAnswer.getIsCorrect()
                    );

                    if (selectedAnswer.getIsCorrect()) {
                        correctAnswers++;
                    }
                }
            }

            // Calculate and update score
            double score = ((double) correctAnswers / questions.size()) * 100;
            quizDAO.finishAttempt(attempt.getId(), score);

            // Clean up session
            session.removeAttribute("currentQuiz");
            session.removeAttribute("currentAttempt");
            System.out.println("successfully submitted quiz attempt: " + attempt.getId() + " with score: " + score);
            // Redirect to result page
            response.sendRedirect("take-quiz?action=result&attemptId=" + attempt.getId());

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void viewResult(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int attemptId = Integer.parseInt(request.getParameter("attemptId"));
            QuizAttempt attempt = quizDAO.getAttemptDetails(attemptId);

            if (attempt == null) {
                response.sendRedirect("learning-page");
                return;
            }

            // Get quiz details
            Quiz quiz = quizDAO.getQuizById(attempt.getQuiz().getId());
            List<QuestionAttempt> questionAttempts = quizDAO.getAttemptAnswers(attemptId);

            request.setAttribute("attempt", attempt);
            request.setAttribute("quiz", quiz);
            request.setAttribute("questionAttempts", questionAttempts);
            request.getRequestDispatcher("/WEB-INF/views/quiz/quiz-result.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void reviewQuiz(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int attemptId = Integer.parseInt(request.getParameter("attemptId"));

            // Get attempt details
            QuizAttempt attempt = quizDAO.getAttemptDetails(attemptId);
            if (attempt == null) {
                response.sendRedirect("learning-page");
                return;
            }

            // Get quiz and questions
            Quiz quiz = quizDAO.getQuizById(attempt.getQuiz().getId());
            List<Question> questions = quizDAO.getQuestionsByQuizId(quiz.getId());
            for (Question question : questions) {
                List<Answer> answers = quizDAO.getAnswerByQuestionId(question.getId());
                question.setAnswers(answers);
            }
            quiz.setQuestions(questions);

            // Get user's answers
            List<QuestionAttempt> questionAttempts = quizDAO.getAttemptAnswers(attemptId);

            request.setAttribute("attempt", attempt);
            request.setAttribute("quiz", quiz);
            request.setAttribute("questionAttempts", questionAttempts);
            request.getRequestDispatcher("/WEB-INF/views/quiz/quiz-review.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
