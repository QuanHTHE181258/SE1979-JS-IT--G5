package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.QuizDAO;
import project.demo.coursemanagement.entities.Quiz;
import project.demo.coursemanagement.entities.Lesson;
import java.sql.*;
import java.util.*;

public class QuizDAOImpl implements QuizDAO {
    @Override
    public List<Quiz> getQuizzesByLessonId(int lessonId) {
        List<Quiz> list = new ArrayList<>();
        String sql = "SELECT QuizID, LessonID, Title FROM quizzes WHERE LessonID = ? ORDER BY QuizID";
        try (Connection conn = project.demo.coursemanagement.utils.DatabaseConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, lessonId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(rs.getInt("QuizID"));
                    Lesson lesson = new Lesson();
                    lesson.setId(rs.getInt("LessonID"));
                    quiz.setLessonID(lesson);
                    quiz.setTitle(rs.getString("Title"));
                    list.add(quiz);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

