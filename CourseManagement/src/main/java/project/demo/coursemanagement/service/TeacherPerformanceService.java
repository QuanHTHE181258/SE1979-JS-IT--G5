package project.demo.coursemanagement.service;

import java.util.List;
import project.demo.coursemanagement.dao.TeacherPerformanceDAO;
import project.demo.coursemanagement.dao.impl.TeacherPerformanceDAOImpl;
import project.demo.coursemanagement.dto.StudentPerformanceDTO;

public class TeacherPerformanceService {
    private TeacherPerformanceDAO dao = new TeacherPerformanceDAOImpl();

    public List<StudentPerformanceDTO> getStudentPerformanceByCourse(int courseId) {
        return dao.getStudentPerformanceByCourse(courseId);
    }

    public List<Integer> getCoursesByTeacher(int teacherId) {
        return dao.getCoursesByTeacher(teacherId);
    }
}
