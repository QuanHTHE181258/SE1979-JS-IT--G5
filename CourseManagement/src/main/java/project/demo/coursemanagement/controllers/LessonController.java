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
import project.demo.coursemanagement.dao.impl.CourseDAO;
import project.demo.coursemanagement.dao.impl.LessonDAO;
import project.demo.coursemanagement.dao.impl.QuizDAO;
import project.demo.coursemanagement.entities.*;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.IOException;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "LessonController", urlPatterns = {"/LessonController"})
public class LessonController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO CourseDAO = new CourseDAO();
        LessonDAO lessonDAO = new LessonDAO();
        QuizDAO quizDAO = new QuizDAO();
        String action = request.getParameter("action");
        if ("quizDetail".equals(action)) { //lấy ra danh sách câu hỏi, câu trl từ view list quiz for student
            String attemptIdStr = request.getParameter("attemptId");
            if (attemptIdStr == null || attemptIdStr.isEmpty()) {
                response.sendRedirect("/WEB-INF/views/errorPage.jsp");
            } else {
                // Proceed with parsing
                int attemptId = Integer.parseInt(attemptIdStr);
                List<QuestionOption> Quiz = lessonDAO.getQuestionOptions(attemptId);
                request.setAttribute("QuizDetail", Quiz);
                request.getRequestDispatcher("/WEB-INF/views/ViewQuizDetail.jsp").forward(request, response);
            }
        } else if ("manageLesson".equals(action)) {

            var userID = SessionUtil.getUserId(request);
            //danh cho teacher
            String courseIdStr = request.getParameter("courseId");
            List<Cours> courses = CourseDAO.getCourseByTeacherId(userID);
            List<Lesson> lessons;

            if (courseIdStr != null && !courseIdStr.isEmpty()) {
                int courseId = Integer.parseInt(courseIdStr);
                lessons = lessonDAO.getLessonsByCourseId(courseId);
                request.setAttribute("selectedCourseId", courseId);
            } else {
                lessons = lessonDAO.getLessonsByTeacherId(userID);
            }

            request.setAttribute("courses", courses);
            request.setAttribute("lessons", lessons);
            request.getRequestDispatcher("/WEB-INF/views/ManageLesson.jsp").forward(request, response);
        } else if ("addLesson".equals(action)) {
            var userID = SessionUtil.getUserId(request);
            if (userID != null) {
                CourseDAO courseDAO = new CourseDAO();
                List<Cours> courses = courseDAO.getCourseByTeacherId(userID);

                request.setAttribute("courses", courses);
                request.getRequestDispatcher("/WEB-INF/views/AddLesson.jsp").forward(request, response);
            } else {
                response.sendRedirect("login"); // hoặc xử lý khác nếu chưa đăng nhập
                return;
            }
        } else if ("editLesson".equals(action)) { //  ADD THIS BLOCK
            int lessonId = Integer.parseInt(request.getParameter("lessonId"));
            Lesson lesson = lessonDAO.getLessonById(lessonId);
            List<Cours> courses = CourseDAO.getAllCourses(); // Or however you get the courses

            request.setAttribute("lesson", lesson);
            request.setAttribute("courses", courses);
            request.getRequestDispatcher("/WEB-INF/views/EditLesson.jsp").forward(request, response);
        } else {  //for student
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            var userID = SessionUtil.getUserId(request);
            List<Lesson> lessons = lessonDAO.getLessonsByCourseId(courseId);
            request.setAttribute("lessons", lessons);
            if (userID == null) {
                response.sendRedirect("login"); // Chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
                return;
            } else {    //show lesson detail list for student
                if ("detail".equals(action)) {
                    int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                    boolean enrolled = lessonDAO.isUserEnrolled(userID, courseId);
                    if (enrolled) {
                        Lesson lesson = lessonDAO.getLessonDetails(lessonId, courseId);
                        request.setAttribute("lesson", lesson);

                        // Lấy quiz cho bài học
                        Quiz quiz = quizDAO.getQuizByLessonId(lessonId);
                        if (quiz != null) {
                            List<Question> questions = quizDAO.getQuestionsByQuizId(quiz.getId());
                            for (Question question : questions) {
                                List<Answer> options = quizDAO.getAnswerByQuestionId(question.getId());
                                question.setAnswerOptions(options);
                            }
                            quiz.setQuestions(questions);

                            int totalQuestion = quizDAO.getTotalQuestionsByQuizId(quiz.getId());
                            request.setAttribute("totalQuestion", totalQuestion);
                            request.setAttribute("quiz", quiz);

                            request.setAttribute("durationMinutes", quiz.getDurationMinutes());
                        }

                        request.getRequestDispatcher("/WEB-INF/views/LessonDetail.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("LessonController?courseId=" + courseId);
                        return;
                    }
                } else if ("myQuizHistory".equals(action)) {
                    List<QuizHistory> listQuiz = lessonDAO.getQuizHistoryByCourseAndUser(courseId, userID);
                    request.setAttribute("listQuiz", listQuiz);
                    request.getRequestDispatcher("/WEB-INF/views/ViewQuizHistory.jsp").forward(request, response);
                }
//                else { //show list lesson
//                    boolean enrolled = lessonDAO.isUserEnrolled(userID, courseId);
//                    List<Lesson_Completion> lessonCompleted = lessonDAO.getListLessonCompleted(courseId);
//                    request.setAttribute("userId", userID);
//                    request.setAttribute("lessonCompleted", lessonCompleted);
//                    request.setAttribute("lessons", lessons);
//                    request.setAttribute("enrolled", enrolled);
//                    request.setAttribute("courseId", courseId);
//                    request.getRequestDispatcher("ListLesson.jsp").forward(request, response);
//                }
                List<Cours> courses = CourseDAO.getAllCourses();
                request.setAttribute("courses", courses);
                request.getRequestDispatcher("/WEB-INF/views/AddLesson.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        var userID = SessionUtil.getUserId(request);

        // Kiểm tra đăng nhập
        if (userID == null) {
            response.sendRedirect("login");
            return;
        }

        LessonDAO lessonDAO = new LessonDAO();

        try {
            if ("enroll".equals(action)) {
                // Xử lý enroll
                // TODO: Thêm logic enroll tại đây nếu cần
            } else if ("submitQuiz".equals(action)) {
                // Xử lý nộp bài kiểm tra
                processQuizSubmission(request, response, userID);
            } else if ("updateLesson".equals(action)) {
                // Xử lý cập nhật bài học
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String videoUrl = request.getParameter("videoUrl");

                Lesson lesson = lessonDAO.getLessonById(lessonId);
                lesson.setTitle(title);
                lesson.setContent(content);

                lessonDAO.updateLesson(lesson);

                response.sendRedirect("LessonController?action=manageLesson");
                return; // Quan trọng: không cho chạy tiếp xuống dưới
            }
//            else if ("addLesson".equals(action)) {
//                // Xử lý thêm bài học mới
//                int courseId = Integer.parseInt(request.getParameter("courseId"));
//                String title = request.getParameter("title");
//                String content = request.getParameter("content");
//                String videoUrl = request.getParameter("videoUrl");
//                Date createdAt = new Date(); // lấy thời điểm hiện tại
//
//                Lesson lesson = new Lesson(0, courseId, title, content, videoUrl, createdAt);
//                boolean success = lessonDAO.addLesson(lesson);
//
//                if (success) {
//                    response.sendRedirect("AddLesson.jsp?success=1");
//                } else {
//                    response.sendRedirect("AddLesson.jsp?error=1");
//                }
//                return;
//            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

    private void processQuizSubmission(HttpServletRequest request, HttpServletResponse response, int userId) throws ServletException, IOException {
        LessonDAO lessonDAO = new LessonDAO();
        QuizDAO quizDAO = new QuizDAO();
        CourseDAO CourseDAO = new CourseDAO();
        var userID = SessionUtil.getUserId(request);

        int quizId = Integer.parseInt(request.getParameter("quizId"));
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        Lesson lesson = lessonDAO.getLessonDetails(lessonId, Integer.parseInt(request.getParameter("courseId")));
        List<Question> questions = quizDAO.getQuestionsByQuizId(quizId);
        int score = 0;

        // Save Quiz Attempt
        QuizAttempt attempt = new QuizAttempt();
        attempt.setUser(User.builder().id(userID).build());
        attempt.setQuiz(Quiz.builder().id(quizId).build());
        attempt.setAttemptDate(new Date());
        int attemptId = quizDAO.saveQuizAttempt(attempt);

        // Xử lý câu trả lời
        for (Question question : questions) {
            int questionId = question.getId();
            String selectedOptionIdStr = request.getParameter("question_" + questionId);
            if (selectedOptionIdStr != null && !selectedOptionIdStr.isEmpty()) { // Kiểm tra nếu có option được chọn
                int selectedOptionId = Integer.parseInt(selectedOptionIdStr);
                Answer selectedOption = quizDAO.getAnswerById(selectedOptionId);

                // Lưu câu trả lời của user
                QuestionAttempt questionAttempt = new QuestionAttempt();
                QuestionAttemptId questionAttemptId = new QuestionAttemptId();
                questionAttemptId.setAttemptID(attemptId);
                questionAttemptId.setQuestionID(questionId);
                questionAttempt.setId(questionAttemptId);


                questionAttempt.setQuestionID(Question.builder().id(questionId).build());
                questionAttempt.setAnswer(Answer.builder().id(selectedOptionId).build());
                quizDAO.saveQuestionAttempt(questionAttempt);

                if (selectedOption != null && selectedOption.getIsCorrect()) {
                    score++;
                }
            }
        }

        int totalQuestion = quizDAO.getTotalQuestionsByQuizId(quizId);

//        if ((double) score / totalQuestion >= 0.7) {
//            lessonDAO.saveLessonCompletion(userId, lessonId);
//            CourseDAO.updateEnrollmentStatusForStudent(userID);
//        }

        request.setAttribute("totalQuestion", totalQuestion);

        // Cập nhật Quiz Attempt với điểm
        attempt.setId(attemptId);
        attempt.setScore((double) score);
        quizDAO.updateQuizAttemptScore(attempt);

        // Chuyển hướng đến trang kết quả hoặc hiển thị kết quả
        request.setAttribute("lesson", lesson);
        request.setAttribute("attemptId", attemptId);
        request.getRequestDispatcher("/WEB-INF/views/ResultQuiz.jsp").forward(request, response);
//        request.getRequestDispatcher("/WEB-INF/views/LessonDetail.jsp").forward(request, response);

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
