package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.LessonDAO;
import project.demo.coursemanagement.dao.impl.LessonDAOImpl;
import project.demo.coursemanagement.dto.LessonStats;

import java.util.List;

public class LessonService {
    public List<LessonStats> getLessonsWithStatsByCourseId(int courseId) {
        LessonDAO lessonDAO = new LessonDAOImpl();
        return lessonDAO.getLessonsWithStatsByCourseId(courseId);
    }
}
