/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.impl.QuizDAO;
import project.demo.coursemanagement.entities.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "QuizController", urlPatterns = {"/QuizController"})
public class QuizController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet QuizController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuizController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        QuizDAO quizDAO = new QuizDAO();
        String action = request.getParameter("action");
        if ("manageQuiz".equals(action))
        try {
            List<Cours> courses = quizDAO.getAllCourses();
            request.setAttribute("courses", courses);

            String courseIdStr = request.getParameter("courseId");
            String lessonIdStr = request.getParameter("lessonId");

            if (courseIdStr != null) {
                int courseId = Integer.parseInt(courseIdStr);
                List<Lesson> lessons = quizDAO.getLessonsByCourseId(courseId);
                request.setAttribute("lessons", lessons);
            }

            if (lessonIdStr != null) {
                int lessonId = Integer.parseInt(lessonIdStr);
                List<Quiz> quizzes = quizDAO.getQuizzesByLessonId(lessonId);
                request.setAttribute("quizzes", quizzes);

                Map<Integer, List<Question>> questionsMap = new HashMap<>();
                Map<Integer, List<Answer>> answersMap = new HashMap<>();

                for (Quiz quiz : quizzes) {
                    List<Question> questions = quizDAO.getQuestionsByQuizId(quiz.getId());
                    questionsMap.put(quiz.getId(), questions);
                    for (Question question : questions) {
                        List<Answer> options = quizDAO.getAnswerByQuestionId(question.getId());
                        answersMap.put(question.getId(), options);
                    }
                }

                request.setAttribute("questions", questionsMap);
                request.setAttribute("answers", answersMap);
            }

            request.getRequestDispatcher("/WEB-INF/views/ManageQuiz.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        QuizDAO quizDAO = new QuizDAO();
        try {
            String action = request.getParameter("action");

            if ("createQuiz".equals(action)) {
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                String title = request.getParameter("title");
                int duration = Integer.parseInt(request.getParameter("duration"));
                Quiz quiz = new Quiz(0, Lesson.builder().id(lessonId).build(), title, duration);
                quizDAO.createQuiz(quiz);
            } else if ("editQuiz".equals(action)) {
                int quizId = Integer.parseInt(request.getParameter("quizId"));
                String title = request.getParameter("title");
                int duration = Integer.parseInt(request.getParameter("duration"));
                Quiz quiz = new Quiz(quizId, Lesson.builder().id(0).build(), title, duration);
                quizDAO.updateQuiz(quiz);
            } else if ("addQuestion".equals(action)) {
                int quizId = Integer.parseInt(request.getParameter("quizId"));
                String questionText = request.getParameter("questionText");
                quizDAO.createQuestion(new Question(0, Quiz.builder().id(quizId).build(), questionText));
            } else if ("deleteQuestion".equals(action)) {
                try {
                    int questionId = Integer.parseInt(request.getParameter("questionId"));

                    // Gọi DAO để xóa câu hỏi và các đáp án liên quan
                    quizDAO.deleteQuestion(questionId);

                    // Lấy lại lessonId để redirect đúng trang
                    String lessonId = request.getParameter("lessonId");

                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if ("addAnswer".equals(action)) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                String answerText = request.getParameter("answerText");
                boolean isCorrect = "1".equals(request.getParameter("isCorrect"));

                // Kiểm tra xem câu hỏi đã có đáp án đúng chưa
                List<Answer> existingAnswers = quizDAO.getAnswersByQuestionId(questionId);

                // Nếu đã có đáp án đúng, set isCorrect=false cho đáp án mới
                if (existingAnswers != null && existingAnswers.stream().anyMatch(Answer::getIsCorrect)) {
                    isCorrect = false;  // Đặt là false nếu đã có đáp án đúng
                }

                // Tạo và lưu câu trả lời mới
                quizDAO.createAnswerOption(new Answer(0, Question.builder().id(questionId).build(), answerText, isCorrect));
            } else if ("editAnswer".equals(action)) {
                int answerId = Integer.parseInt(request.getParameter("answerId"));
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                String answerText = request.getParameter("answerText");
                boolean isCorrect = "1".equals(request.getParameter("isCorrect"));

                // Kiểm tra nếu câu trả lời này được đánh dấu là đúng
                if (isCorrect) {
                    // Lấy danh sách các đáp án của câu hỏi
                    List<Answer> existingAnswers = quizDAO.getAnswersByQuestionId(questionId);

                    // Kiểm tra xem có đáp án đúng khác chưa
                    boolean hasCorrectAnswer = false;
                    for (Answer ao : existingAnswers) {
                        if (ao.getIsCorrect()) {
                            hasCorrectAnswer = true;
                            // Nếu câu trả lời đang được chỉnh sửa là đúng, thì chúng ta sẽ đặt lại đáp án cũ thành sai
                            if (ao.getQuestionID().getId() != answerId) {
                                ao.setIsCorrect(false);
                                quizDAO.updateAnswerOption(ao); // Cập nhật lại đáp án này thành sai
                            }
                        }
                    }

                    // Nếu chưa có đáp án đúng, bạn có thể chỉnh sửa đáp án mới thành đúng
                    if (!hasCorrectAnswer || (hasCorrectAnswer && existingAnswers.size() == 1)) {
                        // Đặt isCorrect cho đáp án hiện tại thành true
                        Answer ao = new Answer(answerId, Question.builder().id(questionId).build(), answerText, isCorrect);
                        quizDAO.updateAnswerOption(ao);
                    } else {
                        // Nếu đã có đáp án đúng, ngừng việc cập nhật và thông báo lỗi
                        request.setAttribute("error", "Một câu hỏi chỉ có thể có một đáp án đúng.");
                        // Trả về giao diện với thông báo lỗi
                    }
                } else {
                    // Nếu câu trả lời không phải là đúng, chỉ cần cập nhật bình thường
                    Answer ao = new Answer(answerId, Question.builder().id(questionId).build(), answerText, isCorrect);
                    quizDAO.updateAnswerOption(ao);
                }
            } else if ("deleteAnswer".equals(action)) {
                int answerId = Integer.parseInt(request.getParameter("answerId"));
                quizDAO.deleteAnswerOption(answerId);
                // Redirect back to quiz page
                String lessonId = request.getParameter("lessonId");
            } else if (action.equals("editAnswersBulk")) {
                int questionId = Integer.parseInt(request.getParameter("questionId"));
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));

                String[] answerIds = request.getParameterValues("answerIds");
                String[] answerTexts = request.getParameterValues("answerTexts");
                String[] correctAnswers = request.getParameterValues("correctAnswers"); // Checkbox checked

                Set<Integer> correctSet = new HashSet<>();
                if (correctAnswers != null) {
                    for (String correctId : correctAnswers) {
                        correctSet.add(Integer.parseInt(correctId));
                    }
                }

                // Lấy danh sách các đáp án hiện tại của câu hỏi
                List<Answer> existingAnswers = quizDAO.getAnswersByQuestionId(questionId);

                // Kiểm tra số lượng đáp án đúng, nếu có hơn một đáp án đúng, ngừng thực hiện
                if (correctSet.size() > 1) {
                    request.setAttribute("error", "Một câu hỏi chỉ có thể có một đáp án đúng.");
                    return; // Dừng lại và trả về thông báo lỗi
                }

                for (int i = 0; i < answerIds.length; i++) {
                    int answerId = Integer.parseInt(answerIds[i]);
                    String newText = answerTexts[i];
                    boolean isCorrect = correctSet.contains(answerId);

                    Answer ao = new Answer();
                    ao.setId(answerId);     // ID của đáp án
                    ao.setAnswerText(newText);          // Nội dung đáp án
                    ao.setIsCorrect(isCorrect);   // Có đúng không

                    // Cập nhật đáp án
                    quizDAO.updateAnswerOption(ao);

                    // Nếu đáp án mới là đúng, kiểm tra và hủy đánh dấu các đáp án cũ là đúng
                    if (isCorrect) {
                        for (Answer existingAnswer : existingAnswers) {
                            if (existingAnswer.getId() != answerId && existingAnswer.getIsCorrect()) {
                                // Nếu đáp án hiện tại đang là đúng và không phải đáp án đang được cập nhật, thì đánh dấu là sai
                                existingAnswer.setIsCorrect(false);
                                quizDAO.updateAnswerOption(existingAnswer);
                            }
                        }
                    }
                }
            }

            String lessonId = request.getParameter("lessonId");
            // Sau khi xử lý thành công (ví dụ thêm, sửa hoặc xóa quiz)
            response.sendRedirect("QuizController?action=manageQuiz&lessonId=" + (lessonId != null ? lessonId : "") + "&message=success");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
