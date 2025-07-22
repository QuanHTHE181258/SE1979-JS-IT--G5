package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.LessonDAO;
import project.demo.coursemanagement.dao.impl.LessonDAOImpl;
import project.demo.coursemanagement.dto.LessonStats;
import project.demo.coursemanagement.entities.Lesson;

import java.util.List;

public class LessonService {
    public List<LessonStats> getLessonsWithStatsByCourseId(int courseId) {
        LessonDAO lessonDAO = new LessonDAOImpl();
        return lessonDAO.getLessonsWithStatsByCourseId(courseId);
    }

    public Lesson getLessonById(int lessonId) {
        LessonDAO lessonDAO = new LessonDAOImpl();
        return lessonDAO.getLessonById(lessonId);
    }

    public List<Lesson> getLessonsByCourseId(int courseId) {
        LessonDAO lessonDAO = new LessonDAOImpl();
        // You may want to order by LessonID or another field as needed
        return lessonDAO.getLessonsByCourseId(courseId);
    }
}
