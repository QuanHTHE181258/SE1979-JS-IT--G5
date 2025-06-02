package project.demo.coursemanagement.service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import project.demo.coursemanagement.dto.EnrolledCourse;
import project.demo.coursemanagement.entities.Course;
import project.demo.coursemanagement.entities.Enrollment;
import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.utils.HibernateUtil;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class EnrollmentService {
    private static EnrollmentService enrollmentService;
    private final SessionFactory sessionFactory;

    private EnrollmentService() {
        HibernateUtil.getInstance(); // initializes sessionFactory internally
        sessionFactory = HibernateUtil.getSessionFactory();
    }

    public static EnrollmentService getInstance() {
        if (enrollmentService == null) {
            enrollmentService = new EnrollmentService();
        }
        return enrollmentService;
    }

    public Enrollment getEnrollment(int enrollmentId) {
        Enrollment enrollment = null;
        try (Session session = sessionFactory.openSession()) {
            enrollment = session.get(Enrollment.class, enrollmentId);
        }
        return enrollment;
    }

    public List<Enrollment> getEnrollmentByUser(int userId) {
        List<Enrollment> enrollments = new ArrayList<>();

        try (Session session = sessionFactory.openSession()) {
            enrollments = session.createQuery(
                            "FROM Enrollment e WHERE e.student.id = :userId", Enrollment.class)
                    .setParameter("userId", userId)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace(); // Consider using a logger in production
        }

        return enrollments;
    }

    public boolean isUserEnrolledInCourse(int userId, int courseId) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "SELECT COUNT(e) FROM Enrollment e " +
                        "WHERE e.student.id = :userId " +
                        "AND e.course.id = :courseId " +
                        "AND e.status != 'DROPPED'";
            
            Long count = session.createQuery(hql, Long.class)
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

            String hql = "FROM Enrollment e WHERE e.student.id = :userId AND e.course.id = :courseId";
            Enrollment existingEnrollment = session.createQuery(hql, Enrollment.class)
                    .setParameter("userId", userId)
                    .setParameter("courseId", courseId)
                    .uniqueResult();

            if (existingEnrollment != null) {
                return false;
            }

            User user = session.get(User.class, userId);
            Course course = session.get(Course.class, courseId);

            if (user == null || course == null) {
                return false;
            }

            Enrollment enrollment = new Enrollment();
            enrollment.setStudent(user);
            enrollment.setCourse(course);
            enrollment.setGrade(new BigDecimal(0));
            enrollment.setProgressPercentage(new BigDecimal(0));
            enrollment.setEnrollmentDate(LocalDateTime.now());
            enrollment.setStatus("ACTIVE");

            session.persist(enrollment);
            tx.commit();

            return true;

        } catch (Exception e) {
            if (tx != null) {
                try {
                    tx.rollback();
                } catch (Exception rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public List<EnrolledCourse> getEnrollmentsByUser(int userId) {
        List<Enrollment> enrollments = new ArrayList<>();
        try (Session session = sessionFactory.openSession()) {
            // Use join fetch to eagerly load the course and its category
            enrollments = session.createQuery(
                    "FROM Enrollment e JOIN FETCH e.course c LEFT JOIN FETCH c.category " +
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
        List<EnrolledCourse> enrolledCourses = new ArrayList<>();
        for (Enrollment enrollment : enrollments) {
            Course course = enrollment.getCourse();
            EnrolledCourse enrolledCourse = new EnrolledCourse();
            
            // Set basic course information
            enrolledCourse.setId(course.getId());
            enrolledCourse.setCourseCode(course.getCourseCode());
            enrolledCourse.setTitle(course.getTitle());
            enrolledCourse.setCategory(course.getCategory());
            enrolledCourse.setImageUrl(course.getImageUrl());
            enrolledCourse.setDurationHours(course.getDurationHours());
            
            // Set enrollment specific information
            enrolledCourse.setEnrollmentStartDate(enrollment.getEnrollmentDate());
            enrolledCourse.setProgressPercentage(enrollment.getProgressPercentage());
            enrolledCourse.setGrade(enrollment.getGrade());
            enrolledCourse.setStatus(enrollment.getStatus());
            
            enrolledCourses.add(enrolledCourse);
        }
        return enrolledCourses;
    }

}
