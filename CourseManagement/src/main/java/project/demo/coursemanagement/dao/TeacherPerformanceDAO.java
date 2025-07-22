package project.demo.coursemanagement.dao;

import java.util.List;
import project.demo.coursemanagement.dto.StudentPerformanceDTO;

public interface TeacherPerformanceDAO {
    List<StudentPerformanceDTO> getStudentPerformanceByCourse(int courseId);
    List<Integer> getCoursesByTeacher(int teacherId);
} 