package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.QuizDAO;
import project.demo.coursemanagement.entities.Quiz;
import project.demo.coursemanagement.entities.Question;
import project.demo.coursemanagement.entities.QuizAttempt;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Answer;
import java.sql.*;
import java.util.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class QuizDAOImpl implements QuizDAO {
    @Override
    public Quiz getQuizById(int quizId) {
        String sql = "SELECT QuizID, LessonID, Title FROM quizzes WHERE QuizID = ?";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(rs.getInt("QuizID"));
                    project.demo.coursemanagement.entities.Lesson lesson = new project.demo.coursemanagement.entities.Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    quiz.setLessonID(lesson);
                    quiz.setTitle(rs.getString("Title"));
                    return quiz;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Question> getQuestionsByQuizId(int quizId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT QuestionID, QuizID, QuestionText FROM questions WHERE QuizID = ?";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Question question = new Question();
                    question.setId(rs.getInt("QuestionID"));
                    Quiz quiz = new Quiz();
                    quiz.setId(rs.getInt("QuizID"));
                    question.setQuiz(quiz);
                    question.setQuestionText(rs.getString("QuestionText"));
                    questions.add(question);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return questions;
    }

    @Override
    public List<QuizAttempt> getAttemptsByQuizId(int quizId) {
        List<QuizAttempt> attempts = new ArrayList<>();
        String sql = "SELECT AttemptID, QuizID, UserID, StartTime, EndTime, Score FROM quiz_attempts WHERE QuizID = ? ORDER BY StartTime DESC";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quizId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    QuizAttempt attempt = new QuizAttempt();
                    attempt.setId(rs.getInt("AttemptID"));
                    Quiz quiz = new Quiz();
                    quiz.setId(rs.getInt("QuizID"));
                    attempt.setQuiz(quiz);
                    User user = new User();
                    user.setId(rs.getInt("UserID"));
                    attempt.setUser(user);
                    attempt.setStartTime(rs.getTimestamp("StartTime").toInstant());
                    Timestamp endTime = rs.getTimestamp("EndTime");
                    if (endTime != null) {
                        attempt.setEndTime(endTime.toInstant());
                    }
                    attempt.setScore(rs.getInt("Score"));
                    attempts.add(attempt);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return attempts;
    }

    @Override
    public List<Quiz> getQuizzesByLessonId(int lessonId) {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT QuizID, LessonID, Title FROM quizzes WHERE LessonID = ?";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lessonId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(rs.getInt("QuizID"));
                    project.demo.coursemanagement.entities.Lesson lesson = new project.demo.coursemanagement.entities.Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    quiz.setLessonID(lesson);
                    quiz.setTitle(rs.getString("Title"));
                    quizzes.add(quiz);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return quizzes;
    }

    @Override
    public List<Answer> getAnswersByQuestionId(int questionId) {
        List<Answer> answers = new ArrayList<>();
        String sql = "SELECT AnswerID, QuestionID, AnswerText, IsCorrect FROM answers WHERE QuestionID = ?";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, questionId);
            try (ResultSet rs = stmt.executeQuery()) {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return answers;
    }

    @Override
    public boolean addQuiz(Quiz quiz) {
        String sql = "INSERT INTO quizzes (LessonID, Title) VALUES (?, ?)";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, quiz.getLessonID().getId());
            stmt.setString(2, quiz.getTitle());

            int result = stmt.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        quiz.setId(rs.getInt(1)); // Set the generated ID back to the quiz object
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean addQuestion(Question question) {
        String sql = "INSERT INTO questions (QuizID, QuestionText) VALUES (?, ?)";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, question.getQuiz().getId());
            stmt.setString(2, question.getQuestionText());

            int result = stmt.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        question.setId(rs.getInt(1)); // Set the generated ID back to the question object
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean addAnswer(Answer answer) {
        String sql = "INSERT INTO answers (QuestionID, AnswerText, IsCorrect) VALUES (?, ?, ?)";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, answer.getQuestion().getId());
            stmt.setString(2, answer.getAnswerText());
            stmt.setBoolean(3, answer.getIsCorrect());

            int result = stmt.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        answer.setId(rs.getInt(1)); // Set the generated ID back to the answer object
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int addQuizAndGetId(Quiz quiz) {
        String sql = "INSERT INTO quizzes (LessonID, Title) VALUES (?, ?)";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, quiz.getLessonID().getId());
            stmt.setString(2, quiz.getTitle());

            int result = stmt.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        int id = rs.getInt(1);
                        quiz.setId(id);
                        return id;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int addQuestionAndGetId(Question question) {
        String sql = "INSERT INTO questions (QuizID, QuestionText) VALUES (?, ?)";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, question.getQuiz().getId());
            stmt.setString(2, question.getQuestionText());

            int result = stmt.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        int id = rs.getInt(1);
                        question.setId(id);
                        return id;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
