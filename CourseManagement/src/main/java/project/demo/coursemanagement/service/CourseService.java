package project.demo.coursemanagement.service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import project.demo.coursemanagement.entities.Course;
import project.demo.coursemanagement.utils.HibernateUtil;

public class CourseService {

    private static SessionFactory sessionFactory;
    private static CourseService instance;

    private CourseService(){
        HibernateUtil.getInstance(); // initializes sessionFactory internally
        sessionFactory = HibernateUtil.getSessionFactory();
    }

    public static CourseService getInstance(){
        if(instance == null){
            instance = new CourseService();
        }
        return instance;
    }

    public Course getCourseBy(int id){
        Course course = null;
        try (Session session = sessionFactory.openSession()) {
            course = session.get(Course.class, id);
        }
        return course;
    }

}
