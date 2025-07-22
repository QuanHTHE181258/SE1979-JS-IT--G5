package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.QuizPreviewDAO;
import project.demo.coursemanagement.dao.impl.QuizPreviewDAOimp;
import project.demo.coursemanagement.dto.QuizDTO;

import java.util.List;

public class QuizPreviewService {
    private static QuizPreviewService instance;
    private final QuizPreviewDAO quizDAO;

    private QuizPreviewService() {
        this.quizDAO = new QuizPreviewDAOimp();
    }

    public static QuizPreviewService getInstance() {
        if (instance == null) {
            instance = new QuizPreviewService();
        }
        return instance;
    }

    public List<QuizDTO> getQuizById(int quizId) {
        return quizDAO.getQuizById(quizId);
    }
}
