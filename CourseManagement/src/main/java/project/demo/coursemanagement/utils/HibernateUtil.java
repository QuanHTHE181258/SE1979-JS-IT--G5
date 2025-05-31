package project.demo.coursemanagement.utils;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static SessionFactory sessionFactory = null;

    private static HibernateUtil instance;

    private HibernateUtil(){
         buildSessionFactory();
    }

    public static void getInstance() {
        if (instance == null) {
            instance = new HibernateUtil();
        }
    }

    private static void buildSessionFactory() {
        try {
            Configuration configuration = new Configuration();
            configuration.configure();  // loads hibernate.cfg.xml

            sessionFactory = configuration.buildSessionFactory();
        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError(e);
        }
    }


    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
