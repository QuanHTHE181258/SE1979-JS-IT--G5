package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.LessonStats;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.entities.Material;
import project.demo.coursemanagement.entities.Quiz;

import java.util.List;

public interface LessonDAO {
    List<LessonStats> getLessonsWithStatsByCourseId(int courseId);
    List<LessonStats> getLessonSummaryByCourseId(int courseId);
    Lesson getLessonById(int lessonId);
    List<Quiz> getQuizzesByLessonId(int lessonId);
    List<Material> getMaterialsByLessonId(int lessonId);
    List<Lesson> getLessonsByCourseId(int courseId);
    boolean updateLesson(Lesson lesson);
}
