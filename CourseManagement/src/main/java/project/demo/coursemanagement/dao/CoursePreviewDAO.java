package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.FeedbackDTO;
import project.demo.coursemanagement.dto.LessonDTO;
import project.demo.coursemanagement.entities.Cours;

import java.util.List;

public interface CoursePreviewDAO {

    CourseDTO getCourseInfoById(int id);

    List<LessonDTO> getLessonsByCourseId(int courseId);

    List<FeedbackDTO> getFeedbacksByCourseId(int courseId);

}
