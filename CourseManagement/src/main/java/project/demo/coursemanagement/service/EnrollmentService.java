package project.demo.coursemanagement.service;

import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.hibernate.Transaction;
import project.demo.coursemanagement.dto.EnrolledCourse;
import project.demo.coursemanagement.entities.Cours;
import project.demo.coursemanagement.entities.Enrollment;
import project.demo.coursemanagement.entities.User;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class EnrollmentService {
    private static EnrollmentService enrollmentService;
    private final SessionFactory sessionFactory;

    private EnrollmentService() {
        // TODO: Initialize sessionFactory properly or inject it
        sessionFactory = null; // Fix this to your actual sessionFactory initialization
    }

    public static EnrollmentService getInstance() {
        if (enrollmentService == null) {
            enrollmentService = new EnrollmentService();
        }
        return enrollmentService;
    }

    public Enrollment getEnrollment(int enrollmentId) {
        try (Session session = sessionFactory.openSession()) {
            return session.get(Enrollment.class, enrollmentId);
        }
    }

    public List<Enrollment> getEnrollmentByUser(int userId) {
        try (Session session = sessionFactory.openSession()) {
            return session.createQuery(
                            "FROM Enrollment e WHERE e.student.id = :userId", Enrollment.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public boolean isUserEnrolledInCourse(int userId, int courseId) {
        try (Session session = sessionFactory.openSession()) {
            Long count = session.createQuery(
                            "SELECT COUNT(e) FROM Enrollment e " +
                                    "WHERE e.student.id = :userId AND e.course.id = :courseId AND e.status != 'DROPPED'",
                            Long.class)
                    .setParameter("userId", userId)
                    .setParameter("courseId", courseId)
                    .uniqueResult();
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean enrollUserInCourse(int userId, int courseId) {
        Session session = null;
        Transaction tx = null;
        try {
            session = sessionFactory.openSession();
            tx = session.beginTransaction();

            // Check existing enrollment
            String hql = "FROM Enrollment e WHERE e.student.id = :userId AND e.course.id = :courseId";
            Enrollment existingEnrollment = session.createQuery(hql, Enrollment.class)
                    .setParameter("userId", userId)
                    .setParameter("courseId", courseId)
                    .uniqueResult();

            if (existingEnrollment != null) {
                return false;
            }

            User user = session.get(User.class, userId);
            Cours course = session.get(Cours.class, courseId);

            if (user == null || course == null) {
                return false;
            }

            Enrollment enrollment = new Enrollment();
            enrollment.setStudent(user);
            enrollment.setCourse(course);
            enrollment.setGrade(BigDecimal.ZERO);
            enrollment.setProgressPercentage(BigDecimal.ZERO);
            enrollment.setEnrollmentDate(Instant.now());
            enrollment.setStatus("ACTIVE");
            enrollment.setCertificateIssued(false);

            session.persist(enrollment);
            tx.commit();
            return true;

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) session.close();
        }
    }

    public List<EnrolledCourse> getEnrollmentsByUser(int userId) {
        try (Session session = sessionFactory.openSession()) {
            List<Enrollment> enrollments = session.createQuery(
                            "SELECT e FROM Enrollment e " +
                                    "JOIN FETCH e.course c " +
                                    "LEFT JOIN FETCH c.category " +
                                    "WHERE e.student.id = :userId", Enrollment.class)
                    .setParameter("userId", userId)
                    .list();
            return toEnrolledCourses(enrollments);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private List<EnrolledCourse> toEnrolledCourses(List<Enrollment> enrollments) {
        List<EnrolledCourse> result = new ArrayList<>();
        for (Enrollment enrollment : enrollments) {
            Cours course = enrollment.getCourse();
            EnrolledCourse dto = EnrolledCourse.builder()
                    .id(course.getId())
                    .title(course.getTitle())
                    .imageUrl(course.getImageURL())
                    .enrollmentDate(enrollment.getEnrollmentDate() != null ? enrollment.getEnrollmentDate().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime() : null)
                    .completionDate(enrollment.getCompletionDate() != null ? enrollment.getCompletionDate().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime() : null)
                    .progressPercentage(enrollment.getProgressPercentage())
                    .grade(enrollment.getGrade())
                    .status(enrollment.getStatus())
                    .certificateIssued(enrollment.getCertificateIssued())
                    .build();
            result.add(dto);
        }
        return result;
    }

}
