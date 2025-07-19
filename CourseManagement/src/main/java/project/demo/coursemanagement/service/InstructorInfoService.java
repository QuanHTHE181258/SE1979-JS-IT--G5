package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.InstructorInfoDAO;
import project.demo.coursemanagement.dao.impl.InstructorInfoDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;
import project.demo.coursemanagement.dto.UserDTO;

import java.util.List;

public class InstructorInfoService {

    private static InstructorInfoService instance;
    private final InstructorInfoDAO instructorInfoDAO;

    private InstructorInfoService() {
        this.instructorInfoDAO = new InstructorInfoDAOimp();
    }

    public static InstructorInfoService getInstance() {
        if (instance == null) {
            instance = new InstructorInfoService();
        }
        return instance;
    }

    public UserDTO getInstructorInfo(String username) {
        return instructorInfoDAO.getUserByUsername(username);
    }

    public List<CourseDTO> getCoursesByInstructorUsername(String username) {
        return instructorInfoDAO.getCoursesByInstructorUsername(username);
    }

    public List<CourseDTO> getCoursesByInstructorUsernameAndPage(String username, int page, int size) {
        return instructorInfoDAO.getCoursesByInstructorUsernameAndPage(username, page, size);
    }

    public int countCoursesByInstructor(String username) {
        return instructorInfoDAO.countCoursesByInstructor(username);
    }


}
