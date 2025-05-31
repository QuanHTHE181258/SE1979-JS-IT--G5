package project.demo.coursemanagement.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.InputStream;
import java.io.IOException;

public class DatabaseConnection {

    private static DatabaseConnection instance;
    private String url;
    private String user;
    private String password;

    private DatabaseConnection() {
        loadProperties();
    }

    private void loadProperties() {
        try {
            Properties properties = new Properties();
            try (InputStream input = getClass().getClassLoader().getResourceAsStream("database.properties")) {
                if (input == null) {
                    throw new IOException("Unable to find database.properties");
                }
                properties.load(input);
            }
            url = properties.getProperty("db.url");
            user = properties.getProperty("db.user");
            password = properties.getProperty("db.password");
            String driver = properties.getProperty("db.driver");
            // Load the JDBC driver
            Class.forName(driver);
        } catch (IOException | ClassNotFoundException e) {
            System.err.println("Could not load properties file 'db.properties'");
            e.printStackTrace();
        }
    }

    public static DatabaseConnection getInstance() {
        if(instance == null) {
            synchronized (DatabaseConnection.class) {
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }return instance;
    }

    public Connection getConnection() throws SQLException {
        try{
            return DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            System.err.println("Connection failed: " + e.getMessage());
            throw e;
        }
    }

    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Failed to close connection: " + e.getMessage());
            }
        }
    }

    public boolean testConnection() {
        try (Connection connection = getConnection()) {
            return connection != null && !connection.isClosed();
        } catch (SQLException e) {
            System.err.println("Test connection failed: " + e.getMessage());
            return false;
        }
    }
}
