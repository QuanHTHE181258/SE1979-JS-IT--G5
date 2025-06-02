package project.demo.coursemanagement.dao;

import project.demo.coursemanagement.dto.EnrolledCourse;
import project.demo.coursemanagement.entities.Enrollment;

import java.util.List;

/**
 * Data Access Object interface for enrollment-related operations
 */
public interface EnrollmentDAO {

    /**
     * Get an enrollment by its ID
     * @param enrollmentId the ID of the enrollment
     * @return the enrollment object or null if not found
     */
    Enrollment getEnrollment(int enrollmentId);

    /**
     * Get all enrollments for a user
     * @param userId the ID of the user
     * @return a list of enrollments
     */
    List<Enrollment> getEnrollmentsByUser(int userId);

    /**
     * Check if a user is enrolled in a course
     * @param userId the ID of the user
     * @param courseId the ID of the course
     * @return true if the user is enrolled, false otherwise
     */
    boolean isUserEnrolledInCourse(int userId, int courseId);

    /**
     * Enroll a user in a course
     * @param userId the ID of the user
     * @param courseId the ID of the course
     * @return true if enrollment was successful, false otherwise
     */
    boolean enrollUserInCourse(int userId, int courseId);

    /**
     * Get enrolled courses for a user
     * @param userId the ID of the user
     * @return a list of enrolled courses
     */
    List<EnrolledCourse> getEnrolledCoursesByUser(int userId);
}