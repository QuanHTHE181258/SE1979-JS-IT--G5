package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.QuizPreviewDAO;
import project.demo.coursemanagement.dto.QuizDTO;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QuizPreviewDAOimp implements QuizPreviewDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public List<QuizDTO> getQuizById(int quizId) {
        List<QuizDTO> list = new ArrayList<>();
        String sql = """
                SELECT qz.QuizID, qz.Title, qs.QuestionText, a.AnswerText
                FROM quizzes qz
                JOIN questions qs ON qz.QuizID = qs.QuizID
                JOIN answers a ON a.QuestionID = qs.QuestionID
                JOIN lessons l ON l.LessonID = qz.LessonID
                WHERE l.LessonID = ?
                """;

        try (Connection con = dbConn.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                QuizDTO quiz = new QuizDTO();
                quiz.setQuizID(rs.getInt("QuizID"));
                quiz.setTitle(rs.getString("Title"));
                quiz.setQuestionText(rs.getString("QuestionText"));
                quiz.setAnswer(rs.getString("AnswerText"));
                list.add(quiz);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
