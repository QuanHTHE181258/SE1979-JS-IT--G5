package project.demo.coursemanagement.controller;

import project.demo.coursemanagement.service.QuizService;
import project.demo.coursemanagement.service.QuizService.QuizQuestionData;
import project.demo.coursemanagement.service.QuizService.QuizAnswerData;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/add-quiz")
public class AddQuizServlet extends HttpServlet {
    private QuizService quizService = new QuizService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lessonId = request.getParameter("lessonId");
        request.setAttribute("lessonId", lessonId);
        request.getRequestDispatcher("/WEB-INF/views/add-quiz.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            String title = request.getParameter("title");

            // Get questions data
            String[] questionTexts = request.getParameterValues("questionText");
            List<QuizQuestionData> questions = new ArrayList<>();

            if (questionTexts != null) {
                for (int i = 0; i < questionTexts.length; i++) {
                    String questionText = questionTexts[i];
                    if (questionText != null && !questionText.trim().isEmpty()) {
                        // Get answers for this question
                        String[] answers = request.getParameterValues("answers_" + i);
                        String[] correctAnswers = request.getParameterValues("correctAnswer_" + i);

                        List<QuizAnswerData> answerList = new ArrayList<>();
                        if (answers != null) {
                            for (int j = 0; j < answers.length; j++) {
                                if (answers[j] != null && !answers[j].trim().isEmpty()) {
                                    boolean isCorrect = false;
                                    if (correctAnswers != null) {
                                        for (String correctIndex : correctAnswers) {
                                            if (correctIndex.equals(String.valueOf(j))) {
                                                isCorrect = true;
                                                break;
                                            }
                                        }
                                    }
                                    answerList.add(new QuizAnswerData(answers[j], isCorrect));
                                }
                            }
                        }

                        if (!answerList.isEmpty()) {
                            questions.add(new QuizQuestionData(questionText, answerList));
                        }
                    }
                }
            }

            boolean success = quizService.createQuiz(lessonId, title, questions);

            if (success) {
                response.sendRedirect("lesson-details?id=" + lessonId + "&success=Quiz created successfully!");
            } else {
                request.setAttribute("error", "Failed to create quiz. Please try again.");
                request.setAttribute("lessonId", lessonId);
                request.getRequestDispatcher("/WEB-INF/views/add-quiz.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while creating the quiz.");
            request.setAttribute("lessonId", request.getParameter("lessonId"));
            request.getRequestDispatcher("/WEB-INF/views/add-quiz.jsp").forward(request, response);
        }
    }
}