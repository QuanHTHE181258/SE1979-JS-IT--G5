package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import project.demo.coursemanagement.dao.impl.QuizDAOImpl;
import project.demo.coursemanagement.entities.Answer;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.entities.Question;
import project.demo.coursemanagement.entities.Quiz;

@WebServlet("/addQuiz")
public class AddQuizServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lessonId = request.getParameter("lessonId");
        request.setAttribute("lessonId", lessonId);
        request.getRequestDispatcher("/WEB-INF/views/addQuiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            String quizTitle = request.getParameter("quizTitle");

            // Create and save Quiz
            Quiz quiz = new Quiz();
            Lesson lesson = new Lesson();
            lesson.setId(lessonId);
            quiz.setLessonID(lesson);
            quiz.setTitle(quizTitle);

            QuizDAOImpl quizDAO = new QuizDAOImpl();
            int quizId = quizDAO.addQuizAndGetId(quiz); // Thêm method mới để lấy ID của quiz vừa thêm

            if (quizId <= 0) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add quiz");
                return;
            }

            // Set the generated ID back to the quiz object
            quiz.setId(quizId);

            // Process Questions
            String[] questionTexts = request.getParameterValues("questionText[]");
            if (questionTexts != null) {
                for (int i = 0; i < questionTexts.length; i++) {
                    // Create and save Question
                    Question question = new Question();
                    question.setQuiz(quiz);
                    question.setQuestionText(questionTexts[i]);
                    int questionId = quizDAO.addQuestionAndGetId(question); // Thêm method mới

                    if (questionId > 0) {
                        question.setId(questionId);

                        // Process Answers for this question
                        String[] answerTexts = request.getParameterValues("answerText_" + i + "[]");
                        String[] isCorrects = request.getParameterValues("isCorrect_" + i + "[]");

                        if (answerTexts != null) {
                            for (int j = 0; j < answerTexts.length; j++) {
                                Answer answer = new Answer();
                                answer.setQuestion(question);
                                answer.setAnswerText(answerTexts[j]);

                                // Check if this answer is marked as correct
                                boolean isCorrect = false;
                                if (isCorrects != null && j < isCorrects.length) {
                                    isCorrect = "true".equals(isCorrects[j]);
                                }
                                answer.setIsCorrect(isCorrect);
                                quizDAO.addAnswer(answer);
                            }
                        }
                    }
                }
            }

            // Redirect back to the lesson page
            response.sendRedirect(request.getContextPath() + "/lesson?id=" + lessonId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing quiz: " + e.getMessage());
        }
    }
}
