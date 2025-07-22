package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.LessonPreviewDAO;
import project.demo.coursemanagement.dao.impl.LessonPreviewDAOimp;
import project.demo.coursemanagement.dto.LessonDTO;

import java.math.BigDecimal;

public class LessonPreviewService {
    private final LessonPreviewDAO lessonDAO = new LessonPreviewDAOimp();

    public LessonDTO getLesson(int lessonId) {
        return lessonDAO.getLessonById(lessonId);
    }

    public BigDecimal getCoursePriceByLessonID(int lessonID) {
        return lessonDAO.getCoursePriceByLessonID(lessonID);
    }

}
