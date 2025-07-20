package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.LessonStats;
import java.util.List;

public interface LessonDAO {
    List<LessonStats> getLessonsWithStatsByCourseId(int courseId);
    List<LessonStats> getLessonSummaryByCourseId(int courseId);
}
