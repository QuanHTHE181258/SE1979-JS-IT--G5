package project.demo.coursemanagement.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AuthorizationUtil {
    
    /**
     * Kiểm tra quyền và redirect nếu không có quyền
     */
    public static boolean checkAndRedirect(HttpServletRequest request, HttpServletResponse response, String... requiredRoles) throws IOException {
        if (!hasPermission(request, requiredRoles)) {
            String contextPath = request.getContextPath();
            SessionUtil.setFlashMessage(request, "error", "You don't have permission to access this resource.");
            response.sendRedirect(contextPath + "/login");
            return false;
        }
        return true;
    }
    
    /**
     * Kiểm tra quyền và trả về error nếu không có quyền
     */
    public static boolean checkAndSendError(HttpServletRequest request, HttpServletResponse response, String... requiredRoles) throws IOException {
        if (!hasPermission(request, requiredRoles)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Required roles: " + String.join(", ", requiredRoles));
            return false;
        }
        return true;
    }
    
    /**
     * Kiểm tra xem user có quyền không
     */
    public static boolean hasPermission(HttpServletRequest request, String... requiredRoles) {
        if (requiredRoles == null || requiredRoles.length == 0) {
            return SessionUtil.isUserLoggedIn(request);
        }
        
        return SessionUtil.hasAnyRole(request, requiredRoles);
    }
    
    /**
     * Kiểm tra xem user có tất cả quyền không
     */
    public static boolean hasAllPermissions(HttpServletRequest request, String... requiredRoles) {
        if (requiredRoles == null || requiredRoles.length == 0) {
            return SessionUtil.isUserLoggedIn(request);
        }
        
        return SessionUtil.hasAllRoles(request, requiredRoles);
    }
    
    /**
     * Kiểm tra quyền cho resource cụ thể (ví dụ: chỉ cho phép owner hoặc admin)
     */
    public static boolean canAccessResource(HttpServletRequest request, Integer resourceOwnerId) {
        Integer currentUserId = SessionUtil.getUserId(request);
        String currentUserRole = SessionUtil.getUserRole(request);
        
        // Owner có thể truy cập
        if (currentUserId != null && currentUserId.equals(resourceOwnerId)) {
            return true;
        }
        
        // Admin có thể truy cập tất cả
        if (SessionUtil.isAdmin(request)) {
            return true;
        }
        
        return false;
    }
    
    /**
     * Kiểm tra quyền cho course (teacher chỉ có thể truy cập course của mình)
     */
    public static boolean canAccessCourse(HttpServletRequest request, Integer courseInstructorId) {
        Integer currentUserId = SessionUtil.getUserId(request);
        
        // Admin có thể truy cập tất cả
        if (SessionUtil.isAdmin(request)) {
            return true;
        }
        
        // Course Manager có thể truy cập tất cả
        if (SessionUtil.isCourseManager(request)) {
            return true;
        }
        
        // Teacher chỉ có thể truy cập course của mình
        if (SessionUtil.isTeacher(request)) {
            return currentUserId != null && currentUserId.equals(courseInstructorId);
        }
        
        return false;
    }
} 