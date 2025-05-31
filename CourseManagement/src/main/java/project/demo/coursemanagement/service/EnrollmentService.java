package project.demo.coursemanagement.service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import project.demo.coursemanagement.entities.Enrollment;
import project.demo.coursemanagement.utils.HibernateUtil;


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
}
