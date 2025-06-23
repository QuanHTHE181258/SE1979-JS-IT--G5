package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.Quiz;
import java.util.List;

public interface QuizDAO {
    List<Quiz> getQuizzesByLessonId(int lessonId);
}

