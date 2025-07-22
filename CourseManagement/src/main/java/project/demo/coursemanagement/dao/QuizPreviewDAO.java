package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.QuizDTO;

import java.util.List;

public interface QuizPreviewDAO {

    List<QuizDTO> getQuizById(int quizId);

}
