package project.demo.coursemanagement.service;

import project.demo.coursemanagement.dao.EnrollmentDAO;
import project.demo.coursemanagement.dao.impl.EnrollmentDAOImp;
import project.demo.coursemanagement.dto.EnrolledCourse;
import project.demo.coursemanagement.entities.Enrollment;

import java.util.List;

/**
 * Service class for enrollment-related operations
 */
public class EnrollmentService {
    private static EnrollmentService enrollmentService;
    private final EnrollmentDAO enrollmentDAO;

    private EnrollmentService() {
        enrollmentDAO = new EnrollmentDAOImp();
    }

    public static EnrollmentService getInstance() {
        if (enrollmentService == null) {
            enrollmentService = new EnrollmentService();
        }
        return enrollmentService;
    }

    /**
     * Get an enrollment by its ID
     * @param enrollmentId the ID of the enrollment
     * @return the enrollment object or null if not found
     */
    public Enrollment getEnrollment(int enrollmentId) {
        return enrollmentDAO.getEnrollment(enrollmentId);
    }

    /**
     * Get all enrollments for a user
     * @param userId the ID of the user
     * @return a list of enrollments
     */
    public List<Enrollment> getEnrollmentByUser(int userId) {
        return enrollmentDAO.getEnrollmentsByUser(userId);
    }

    /**
     * Check if a user is enrolled in a course
     * @param userId the ID of the user
     * @param courseId the ID of the course
     * @return true if the user is enrolled, false otherwise
     */
    public boolean isUserEnrolledInCourse(int userId, int courseId) {
        return enrollmentDAO.isUserEnrolledInCourse(userId, courseId);
    }

    /**
     * Enroll a user in a course
     * @param userId the ID of the user
     * @param courseId the ID of the course
     * @return true if enrollment was successful, false otherwise
     */
    public boolean enrollUserInCourse(int userId, int courseId) {
        return enrollmentDAO.enrollUserInCourse(userId, courseId);
    }

    /**
     * Get enrolled courses for a user
     * @param userId the ID of the user
     * @return a list of enrolled courses
     */
    public List<EnrolledCourse> getEnrollmentsByUser(int userId) {
        return enrollmentDAO.getEnrolledCoursesByUser(userId);
    }
}