package project.demo.coursemanagement.service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import project.demo.coursemanagement.entities.Course;
import project.demo.coursemanagement.utils.HibernateUtil;
import project.demo.coursemanagement.dao.CourseViewDAOimp;
import project.demo.coursemanagement.dto.CourseDTO;

import java.util.List;

public class CourseService {

    private static SessionFactory sessionFactory;
    private static CourseService instance;

    private CourseViewDAOimp courseDAO;

    private CourseService(){
        HibernateUtil.getInstance(); // initializes sessionFactory internally
        sessionFactory = HibernateUtil.getSessionFactory();
        this.courseDAO = new CourseViewDAOimp();

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

    public List<CourseDTO> getAllCourses() {
        return courseDAO.getAllCourses();
    }

}
