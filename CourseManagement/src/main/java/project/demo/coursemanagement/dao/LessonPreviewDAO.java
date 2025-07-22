package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.LessonDTO;

import java.math.BigDecimal;

public interface LessonPreviewDAO {

    LessonDTO getLessonById(int lessonId);

    BigDecimal getCoursePriceByLessonID(int lessonID);

}
