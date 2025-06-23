package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.QuizDAO;
import project.demo.coursemanagement.dao.impl.QuizDAOImpl;
import project.demo.coursemanagement.entities.Quiz;
import java.util.List;

public class QuizService {
    public List<Quiz> getQuizzesByLessonId(int lessonId) {
        QuizDAO quizDAO = new QuizDAOImpl();
        return quizDAO.getQuizzesByLessonId(lessonId);
    }
}

