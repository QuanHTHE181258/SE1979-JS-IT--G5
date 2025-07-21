package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.LessonStats;
import project.demo.coursemanagement.entities.Lesson;
import java.util.List;

public interface LessonDAO {
    List<LessonStats> getLessonsWithStatsByCourseId(int courseId);
    Lesson getLessonById(int lessonId);
    List<Lesson> getLessonsByCourseId(int courseId);
    boolean updateLesson(Lesson lesson);
}
