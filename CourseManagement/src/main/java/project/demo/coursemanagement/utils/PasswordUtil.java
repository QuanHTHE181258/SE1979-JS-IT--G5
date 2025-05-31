package project.demo.coursemanagement.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    //Hash password using BCrypt
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    //Verify password
    public static boolean verifyPassword(String password, String hashed) {
        try{
            return BCrypt.checkpw(password, hashed);
        }catch (Exception e){
            System.err.println("Error verifying password: " + e.getMessage());
            return false;
        }
    }
}
