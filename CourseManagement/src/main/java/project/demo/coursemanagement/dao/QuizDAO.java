package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.entities.Quiz;
import project.demo.coursemanagement.entities.Question;
import project.demo.coursemanagement.entities.QuizAttempt;
import project.demo.coursemanagement.entities.Answer;
import java.util.List;

public interface QuizDAO {
    Quiz getQuizById(int quizId);
    List<Question> getQuestionsByQuizId(int quizId);
    List<QuizAttempt> getAttemptsByQuizId(int quizId);
    List<Quiz> getQuizzesByLessonId(int lessonId);
    List<Answer> getAnswersByQuestionId(int questionId);
}
