package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.entities.*;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.util.*;
import java.util.Date;


public class QuizDAO {

    // 1. Lấy quiz theo LessonID
    public Quiz getQuizByLessonId(int lessonId) {
        Quiz quiz = null;
        String sql = "SELECT * FROM quizzes WHERE LessonID = ? ";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                quiz = Quiz.builder()
                        .id(rs.getInt("QuizID"))
                        .lessonID(Lesson.builder().id(rs.getInt("LessonID")).build())
                        .title(rs.getString("Title"))
                        .durationMinutes(rs.getInt("duration_minutes"))
                        .build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quiz;
    }

    // 2. Lấy danh sách câu hỏi theo QuizID
    public List<Question> getQuestionsByQuizId(int quizId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions WHERE QuizID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Question q = new Question();
                q.setId(rs.getInt("QuestionID"));
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt("QuizID"));
                q.setQuiz(quiz);
                q.setQuestionText(rs.getString("QuestionText"));
                questions.add(q);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }

    // 3. Lấy đáp án theo QuestionID
    public List<Answer> getAnswerByQuestionId(int questionId) {
        List<Answer> list = new ArrayList<>();
        String sql = "SELECT * FROM answers WHERE QuestionID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, questionId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Answer an = new Answer();
                an.setId(rs.getInt("AnswerID"));
                Question q = new Question();
                q.setId(rs.getInt("QuestionID"));
                an.setQuestion(q);
                an.setAnswerText(rs.getString("AnswerText"));
                an.setIsCorrect(rs.getBoolean("IsCorrect"));
                list.add(an);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. Lưu một lần làm quiz (Quiz_Attempt)
    public int saveQuizAttempt(QuizAttempt attempt) {
        int generatedId = -1;
        String sql = "INSERT INTO quiz_attempts (QuizID, UserID, StartTime, Score) VALUES (?, ?, GETDATE(), ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, attempt.getQuiz().getId());
            ps.setInt(2, attempt.getUser().getId());
            ps.setDouble(3, attempt.getScore());

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    // 5. Lưu câu trả lời của user (User_Answer)
    public void saveQuestionAttempt(QuestionAttempt aq) {
        String sql = "INSERT INTO question_attempts (AttemptID, QuestionID, SelectedAnswerID, IsCorrect) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, aq.getId().getAttemptID());
            ps.setInt(2, aq.getId().getQuestionID());
            ps.setInt(3, aq.getAnswer().getId());  // Changed from OptionID to SelectedAnswerID
            ps.setBoolean(4, aq.getIsCorrect());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 6. Lấy đáp án theo OptionID (để kiểm tra đúng/sai)
    public Answer getAnswerById(int id) {
        String sql = "SELECT * FROM answers WHERE AnswerID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Answer answer = new Answer();
                answer.setId(rs.getInt("AnswerID"));
                Question question = new Question();
                question.setId(rs.getInt("QuestionID"));
                answer.setQuestion(question);
                answer.setAnswerText(rs.getString("AnswerText"));
                answer.setIsCorrect(rs.getBoolean("IsCorrect"));
                return answer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 7. Cập nhật điểm quiz attempt
    public void updateQuizAttemptScore(QuizAttempt attempt) {
        String sql = "UPDATE quiz_attempts SET EndTime = GETDATE(), Score = ? WHERE AttemptID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDouble(1, attempt.getScore());
            ps.setInt(2, attempt.getId());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 8. Lấy kết quả làm quiz của user (Quiz_Attempt)
    public QuizAttempt getQuizAttempt(int attemptId) {
        String sql = "SELECT * FROM quiz_attempts WHERE AttemptID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attemptId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return QuizAttempt.builder()
                        .id(rs.getInt("AttemptID"))
                        .user(User.builder().id(rs.getInt("UserID")).build())
                        .quiz(Quiz.builder().id(rs.getInt("QuizID")).build())
                        .startTime(rs.getTimestamp("StartTime"))
                        .endTime(rs.getTimestamp("EndTime"))
                        .score((int)rs.getDouble("Score"))
                        .build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 9. Lấy toàn bộ đáp án user chọn trong một lần làm quiz (User_Answer)
    public List<QuestionAttempt> getQuestionAttempt(int attemptId) {
        List<QuestionAttempt> list = new ArrayList<>();
        String sql = "SELECT qa.*, q.QuestionText, a.AnswerText " +
                "FROM question_attempts qa " +
                "JOIN questions q ON qa.QuestionID = q.QuestionID " +
                "JOIN answers a ON qa.SelectedAnswerID = a.AnswerID " +
                "WHERE qa.AttemptID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attemptId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question question = Question.builder()
                        .id(rs.getInt("QuestionID"))
                        .questionText(rs.getString("QuestionText"))
                        .build();

                Answer answer = Answer.builder()
                        .id(rs.getInt("SelectedAnswerID"))
                        .answerText(rs.getString("AnswerText"))
                        .build();

                list.add(QuestionAttempt.builder()
                        .id(QuestionAttemptId.builder()
                                .attemptID(rs.getInt("AttemptID"))
                                .questionID(rs.getInt("QuestionID"))
                                .build())
                        .attemptID(QuizAttempt.builder().id(rs.getInt("AttemptID")).build())
                        .questionID(question)
                        .answer(answer)
                        .isCorrect(rs.getBoolean("IsCorrect"))
                        .build());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //total question cua 1 quiz
    public int getTotalQuestionsByQuizId(int quizId) {
        int totalQuestions = 0;
        String sql = "SELECT COUNT(*) AS total_questions FROM questions WHERE QuizID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalQuestions = rs.getInt("total_questions");
            }

            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalQuestions;
    }

    public int addQuiz(Quiz quiz) {
        String sql = "INSERT INTO quizzes (LessonID, Title, duration_minutes) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quiz.getLessonID().getId());
            ps.setString(2, quiz.getTitle());
            ps.setInt(3, quiz.getDurationMinutes());

            ps.executeUpdate();

            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating quiz failed, no ID obtained.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int addQuestion(Question question) {
        String sql = "INSERT INTO questions (QuizID, QuestionText) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, question.getQuizID().getId());
            ps.setString(2, question.getQuestionText());

            ps.executeUpdate();

            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating question failed, no ID obtained.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int addAnswer(Answer answer) {
        String sql = "INSERT INTO answers (QuestionID, AnswerText, IsCorrect) VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, answer.getQuestionID().getId());
            ps.setString(2, answer.getAnswerText());
            ps.setBoolean(3, answer.getIsCorrect());

            ps.executeUpdate();

            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating answer option failed, no ID obtained.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public List<Cours> getAllCourses() throws SQLException {
        List<Cours> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cours course = new Cours();
                course.setId(rs.getInt("CourseID"));
                course.setTitle(rs.getString("Title"));
                course.setDescription(rs.getString("Description"));
                course.setPrice(rs.getBigDecimal("Price"));
                course.setRating(rs.getDouble("Rating"));
                course.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                course.setImageURL(rs.getString("ImageURL"));

                User instructor = new User();
                instructor.setId(rs.getInt("InstructorID"));
                course.setInstructorID(instructor);

                Category category = new Category();
                category.setId(rs.getInt("CategoryID"));
                course.setCategory(category);
                course.setStatus(rs.getString("Status"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<Cours>();
        }
        return courses;
    }

    public List<Lesson> getLessonsByCourseId(int courseId) throws SQLException {
        List<Lesson> lessons = new ArrayList<>();
        String sql = "SELECT * FROM lessons WHERE CourseID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {


            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setId(rs.getInt("LessonID"));
                Cours course = new Cours();
                course.setId(rs.getInt("CourseID"));
                lesson.setCourseID(course);
                lesson.setTitle(rs.getString("Title"));
                lesson.setContent(rs.getString("Content"));
                lesson.setStatus(rs.getString("Status"));
                lesson.setIsFreePreview(rs.getBoolean("IsFreePreview"));
                lesson.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
                lessons.add(lesson);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
        return lessons;
    }

    public List<Quiz> getQuizzesByLessonId(int lessonId) throws SQLException {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM quizzes WHERE LessonID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, lessonId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                quizzes.add(Quiz.builder()
                        .id(rs.getInt("QuizID"))
                        .lessonID(Lesson.builder().id(rs.getInt("LessonID")).build())
                        .title(rs.getString("Title"))
                        .durationMinutes(rs.getInt("duration_minutes"))
                        .build()
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
        return quizzes;
    }

    public void createQuiz(Quiz quiz) throws SQLException {
        String sql = "INSERT INTO quizzes (LessonID, Title) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quiz.getLessonID().getId());
            ps.setString(2, quiz.getTitle());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuiz(Quiz quiz) {
        String sql = "UPDATE quizzes SET Title = ? WHERE QuizID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, quiz.getTitle());
            ps.setInt(2, quiz.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createQuestion(Question question) {
        String sql = "INSERT INTO questions (QuizID, QuestionText) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, question.getQuizID().getId());
            ps.setString(2, question.getQuestionText());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void createAnswerOption(Answer answer) throws SQLException {
        String sql = "INSERT INTO answers (QuestionID, AnswerText, IsCorrect) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, answer.getQuestionID().getId());
            ps.setString(2, answer.getAnswerText());
            ps.setBoolean(3, answer.getIsCorrect());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    // Thêm câu hỏi mới cho quiz, trả về questionId vừa tạo
    public int addQuestionToQuiz(int quizId, String questionText) throws SQLException {
        String sql = "INSERT INTO questions (QuizID, QuestionText) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, quizId);
            ps.setString(2, questionText);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    // Thêm đáp án mới cho câu hỏi, trả về optionId vừa tạo
    public int addAnswerToQuestion(int questionId, String answerText, boolean isCorrect) throws SQLException {
        String sql = "INSERT INTO answers (QuestionID, AnswerText, IsCorrect) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, questionId);
            ps.setString(2, answerText);
            ps.setBoolean(3, isCorrect);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    // Cập nhật đáp án đúng/sai cho một option
    public void updateAnswerIsCorrect(int answerId, boolean isCorrect) throws SQLException {
        String sql = "UPDATE answers SET IsCorrect = ? WHERE AnswerID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, isCorrect);
            stmt.setInt(2, answerId);
            stmt.executeUpdate();
        }
    }

    // Xóa một đáp án
    public void deleteAnswerOption(int answerId) throws SQLException {
        String sql = "DELETE FROM answers WHERE AnswerID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, answerId);
            stmt.executeUpdate();
        }
    }

    // Xóa một câu hỏi (và tất cả đáp án liên quan)
    public void deleteQuestion(int questionId) throws SQLException {

        String sql1 = "DELETE FROM answers WHERE QuestionID = ?";
        String sql2 = "DELETE FROM questions WHERE QuestionID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt1 = conn.prepareStatement(sql1);
             PreparedStatement stmt2 = conn.prepareStatement(sql2);) {

            // Xóa đáp án trước
            stmt1.setInt(1, questionId);
            stmt1.executeUpdate();

            // Xóa câu hỏi
            stmt2.setInt(1, questionId);
            stmt2.executeUpdate();
        }

    }

    // Xóa quiz (và toàn bộ câu hỏi + đáp án liên quan)
    public void deleteQuiz(int quizId) throws SQLException {
        String sql1 = "DELETE FROM answers WHERE QuestionID IN (SELECT QuestionID FROM questions WHERE QuizID = ?)";
        String sql2 = "DELETE FROM questions WHERE QuizID = ?";
        String sql3 = "DELETE FROM quizzes WHERE QuizID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt1 = conn.prepareStatement(sql1);
             PreparedStatement stmt2 = conn.prepareStatement(sql2);
             PreparedStatement stmt3 = conn.prepareStatement(sql3);) {
            // Xóa đáp án
            stmt1.setInt(1, quizId);
            stmt1.executeUpdate();

            // Xóa câu hỏi
            stmt2.setInt(1, quizId);
            stmt2.executeUpdate();

            // Xóa quiz
            stmt3.setInt(1, quizId);
            stmt3.executeUpdate();
        }
    }

    // Lấy quiz theo quizId
    public Quiz getQuizById(int quizId) throws SQLException {
        String sql = "SELECT * FROM quizzes WHERE QuizID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return Quiz.builder()
                        .id(rs.getInt("QuizID"))
                        .lessonID(Lesson.builder().id(rs.getInt("LessonID")).build())
                        .title(rs.getString("Title"))
                        .durationMinutes(rs.getInt("duration_minutes"))
                        .build();
            }
        }
        return null;
    }

    // Lấy question theo questionId
    public Question getQuestionById(int questionId) throws SQLException {
        String sql = "SELECT * FROM questions WHERE QuestionID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, questionId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Question question = new Question();
                question.setId(rs.getInt("QuestionID"));
                Quiz quiz = new Quiz();
                quiz.setId(rs.getInt("QuizID"));
                question.setQuiz(quiz);
                question.setQuestionText(rs.getString("QuestionText"));
                return question;
            }
        }
        return null;
    }

    /**
     * Cập nhật đáp án (text, isCorrect)
     */
    public void updateAnswerOption(Answer answer) throws SQLException {
        String sql = "UPDATE answers SET AnswerText = ?, IsCorrect = ? WHERE AnswerID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, answer.getAnswerText());
            ps.setBoolean(2, answer.getIsCorrect());
            ps.setInt(3, answer.getId());  // Lưu ý: đổi getter thành getOptionID()
            ps.executeUpdate();
        }
    }

    public List<Answer> getAnswersByQuestionId(int questionId) throws SQLException {
        List<Answer> answers = new ArrayList<>();
        String sql = "SELECT AnswerID, QuestionID, AnswerText, IsCorrect FROM answers WHERE QuestionID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, questionId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Answer answer = new Answer();
                    answer.setId(rs.getInt("AnswerID"));
                    Question question = new Question();
                    question.setId(rs.getInt("QuestionID"));
                    answer.setQuestion(question);
                    answer.setAnswerText(rs.getString("AnswerText"));
                    answer.setIsCorrect(rs.getBoolean("IsCorrect"));
                    answers.add(answer);
                }
            }
        }
        return answers;
    }

    // Tạo một lần thi mới
    public QuizAttempt createAttempt(int quizId, int userId) {
        String sql = "INSERT INTO quiz_attempts (QuizID, UserID, StartTime) VALUES (?, ?, GETDATE())";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, quizId);
            ps.setInt(2, userId);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return QuizAttempt.builder()
                        .id(rs.getInt(1))
                        .quiz(Quiz.builder().id(quizId).build())
                        .user(User.builder().id(userId).build())
                        .startTime(new Date())
                        .score(0)
                        .build();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kết thúc bài thi và cập nhật điểm
    public void finishAttempt(int attemptId, double score) {
        String sql = "UPDATE quiz_attempts SET EndTime = GETDATE(), Score = ? WHERE AttemptID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, score);
            ps.setInt(2, attemptId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lưu câu trả lời của user cho một câu hỏi
    public void saveQuestionAnswer(int attemptId, int questionId, int selectedAnswerId, boolean isCorrect) {
        String sql = "INSERT INTO question_attempts (AttemptID, QuestionID, SelectedAnswerID, IsCorrect) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, attemptId);
            ps.setInt(2, questionId);
            ps.setInt(3, selectedAnswerId);
            ps.setBoolean(4, isCorrect);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách câu trả lời của user trong một lần thi
    public List<QuestionAttempt> getAttemptAnswers(int attemptId) {
        List<QuestionAttempt> answers = new ArrayList<>();
        String sql = "SELECT qa.*, q.QuestionText, a.AnswerText " +
                "FROM question_attempts qa " +
                "JOIN questions q ON qa.QuestionID = q.QuestionID " +
                "JOIN answers a ON qa.SelectedAnswerID = a.AnswerID " +
                "WHERE qa.AttemptID = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, attemptId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Question question = Question.builder()
                        .id(rs.getInt("QuestionID"))
                        .questionText(rs.getString("QuestionText"))
                        .build();

                Answer answer = Answer.builder()
                        .id(rs.getInt("SelectedAnswerID"))
                        .answerText(rs.getString("AnswerText"))
                        .build();

                QuestionAttempt qa = QuestionAttempt.builder()
                        .id(new QuestionAttemptId(attemptId, rs.getInt("QuestionID")))
                        .attemptID(QuizAttempt.builder().id(attemptId).build())
                        .questionID(question)
                        .answer(answer)
                        .isCorrect(rs.getBoolean("IsCorrect"))
                        .build();

                answers.add(qa);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return answers;
    }

    // Update a question's text
    public void updateQuestion(Question question) throws SQLException {
        String sql = "UPDATE questions SET QuestionText = ? WHERE QuestionID = ?";
        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, question.getQuestionText());
            ps.setInt(2, question.getId());
            ps.executeUpdate();
        }
    }

    public static void main(String[] args) {
        QuizDAO quizDAO = new QuizDAO(); // Đảm bảo bạn đã import QuizDAO đúng cách
        int lessonIdToTest = 2; // thay bằng ID thực tế trong DB của bạn

        Quiz quiz = quizDAO.getQuizByLessonId(lessonIdToTest);

        if (quiz != null) {
            System.out.println("Quiz Found:");
            System.out.println("Quiz ID: " + quiz.getId());
            System.out.println("Lesson ID: " + quiz.getLessonID().getId());
            System.out.println("Title: " + quiz.getTitle());
            System.out.println("Duration: " + quiz.getDurationMinutes() + " minutes");
        } else {
            System.out.println("No quiz found for lessonId = " + lessonIdToTest);
        }
    }

}
