package project.demo.coursemanagement.utils;

import project.demo.coursemanagement.entities.User;
import project.demo.coursemanagement.entities.Role;
import project.demo.coursemanagement.dao.UserRoleDAO;
import project.demo.coursemanagement.dao.impl.UserRoleDAOImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.List;

/**
 * Utility class for managing user sessions
 */
public class SessionUtil {

    // Session attribute keys
    private static final String USER_SESSION_KEY = "loggedInUser";
    private static final String USER_ID_SESSION_KEY = "userId";
    private static final String USERNAME_SESSION_KEY = "username";
    private static final String USER_ROLE_SESSION_KEY = "userRole";
    private static final String USER_ROLES_SESSION_KEY = "userRoles";

    // Session timeout (30 minutes in seconds)
    private static final int SESSION_TIMEOUT = 30 * 60;

    // UserRoleDAO instance
    private static final UserRoleDAO userRoleDAO = new UserRoleDAOImpl();

    // Set user session with user details
    public static void setUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true); // Create if not exists

        // Set session timeout
        session.setMaxInactiveInterval(SESSION_TIMEOUT);

        // Get user roles
        List<Role> roles = userRoleDAO.findRolesByUserId(user.getId());
        Role primaryRole = userRoleDAO.findPrimaryRoleByUserId(user.getId());

        // Store user information in session
        session.setAttribute(USER_SESSION_KEY, user);
        session.setAttribute(USER_ID_SESSION_KEY, user.getId());
        session.setAttribute(USERNAME_SESSION_KEY, user.getUsername());

        // Store role information
        if (primaryRole != null) {
            session.setAttribute(USER_ROLE_SESSION_KEY, primaryRole.getRoleName());
        } else {
            session.setAttribute(USER_ROLE_SESSION_KEY, "USER"); // Default role
        }

        session.setAttribute(USER_ROLES_SESSION_KEY, roles);

        System.out.println("Session created for user: " + user.getUsername());
    }

  // Get user object from session
    public static User getUserFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false); // Don't create if not exists

        if (session != null) {
            return (User) session.getAttribute(USER_SESSION_KEY);
        }

        return null;
    }

    //Get user ID from session
    public static Integer getUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            return (Integer) session.getAttribute(USER_ID_SESSION_KEY);
        }

        return null;
    }

    //Get username from session
    public static String getUsername(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            return (String) session.getAttribute(USERNAME_SESSION_KEY);
        }

        return null;
    }

    // Get user role from session (primary role)
    public static String getUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            return (String) session.getAttribute(USER_ROLE_SESSION_KEY);
        }

        return null;
    }

    // Get all user roles from session
    @SuppressWarnings("unchecked")
    public static List<Role> getUserRoles(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            return (List<Role>) session.getAttribute(USER_ROLES_SESSION_KEY);
        }

        return null;
    }

    //Check if user is logged in
    public static boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute(USER_SESSION_KEY);
            return user != null;
        }

        return false;
    }

    // Check if user has a specific role (using primary role)
    public static boolean hasRole(HttpServletRequest request, String roleName) {
        String userRole = getUserRole(request);
        return userRole != null && userRole.equals(roleName);
    }

    // Check if user has any of the specified roles
    public static boolean hasAnyRole(HttpServletRequest request, String... roleNames) {
        if (roleNames == null || roleNames.length == 0) {
            return false;
        }

        String userRole = getUserRole(request);
        if (userRole == null) {
            return false;
        }

        for (String roleName : roleNames) {
            if (userRole.equals(roleName)) {
                return true;
            }
        }

        return false;
    }

    // Check if user has all of the specified roles
    public static boolean hasAllRoles(HttpServletRequest request, String... roleNames) {
        if (roleNames == null || roleNames.length == 0) {
            return true;
        }

        List<Role> userRoles = getUserRoles(request);
        if (userRoles == null || userRoles.isEmpty()) {
            return false;
        }

        // Convert user roles to a set of role names for easier checking
        java.util.Set<String> userRoleNames = new java.util.HashSet<>();
        for (Role role : userRoles) {
            userRoleNames.add(role.getRoleName());
        }

        // Check if all specified roles are in the user's roles
        for (String roleName : roleNames) {
            if (!userRoleNames.contains(roleName)) {
                return false;
            }
        }

        return true;
    }

    public static boolean isAdmin(HttpServletRequest request) {
        return hasRole(request, "ADMIN");
    }

    public static boolean isTeacher(HttpServletRequest request) {
        return hasRole(request, "TEACHER");
    }

    public static boolean isStudent(HttpServletRequest request) {
        return hasRole(request, "USER");
    }

    public static boolean isUserManager(HttpServletRequest request) {
        return hasRole(request, "USER_MANAGER");
    }

    public static boolean isCourseManager(HttpServletRequest request) {
        return hasRole(request, "COURSE_MANAGER");
    }

   // Clear user session
    public static void clearUserSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            String username = (String) session.getAttribute(USERNAME_SESSION_KEY);
            session.invalidate();
            System.out.println("Session cleared for user: " + username);
        }
    }

   // Logout user and redirect to login page
    public static void logoutAndRedirect(HttpServletRequest request,
                                         HttpServletResponse response,
                                         String loginUrl) throws Exception {
        clearUserSession(request);
        response.sendRedirect(request.getContextPath() + loginUrl);
    }

    //Set flash message in session
    public static void setFlashMessage(HttpServletRequest request,
                                       String type,
                                       String message) {
        HttpSession session = request.getSession(true);
        session.setAttribute("flashMessageType", type);
        session.setAttribute("flashMessage", message);
    }

    //Get and clear flash message from session
    public static String getAndClearFlashMessage(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            String message = (String) session.getAttribute("flashMessage");
            String type = (String) session.getAttribute("flashMessageType");

            // Remove flash message after getting it
            session.removeAttribute("flashMessage");
            session.removeAttribute("flashMessageType");

            if (message != null) {
                return type + ":" + message;
            }
        }

        return null;
    }

    //Get session information as a string
    public static String getSessionInfo(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            return String.format(
                    "Session ID: %s, User: %s, Role: %s, Created: %d, Last Accessed: %d",
                    session.getId(),
                    session.getAttribute(USERNAME_SESSION_KEY),
                    session.getAttribute(USER_ROLE_SESSION_KEY),
                    session.getCreationTime(),
                    session.getLastAccessedTime()
            );
        }

        return "No active session";
    }
}
