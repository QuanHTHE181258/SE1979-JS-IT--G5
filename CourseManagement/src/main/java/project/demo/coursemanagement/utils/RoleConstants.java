package project.demo.coursemanagement.utils;

/**
 * Constants cho các role trong hệ thống
 * Giúp tránh hardcode role IDs và dễ bảo trì
 */
public class RoleConstants {
    
    // Role IDs
    public static final int GUEST_ROLE_ID = 0;
    public static final int STUDENT_ROLE_ID = 1;
    public static final int TEACHER_ROLE_ID = 2;
    public static final int COURSE_MANAGER_ROLE_ID = 3;
    public static final int USER_MANAGER_ROLE_ID = 4;
    public static final int ADMIN_ROLE_ID = 5;
    
    // Role Names
    public static final String GUEST_ROLE_NAME = "GUEST";
    public static final String STUDENT_ROLE_NAME = "STUDENT";
    public static final String TEACHER_ROLE_NAME = "TEACHER";
    public static final String COURSE_MANAGER_ROLE_NAME = "COURSE_MANAGER";
    public static final String USER_MANAGER_ROLE_NAME = "USER_MANAGER";
    public static final String ADMIN_ROLE_NAME = "ADMIN";
    
    // Role Display Names (tiếng Việt)
    public static final String GUEST_DISPLAY_NAME = "Khách";
    public static final String STUDENT_DISPLAY_NAME = "Học viên";
    public static final String TEACHER_DISPLAY_NAME = "Giảng viên";
    public static final String COURSE_MANAGER_DISPLAY_NAME = "Quản lý khóa học";
    public static final String USER_MANAGER_DISPLAY_NAME = "Quản lý người dùng";
    public static final String ADMIN_DISPLAY_NAME = "Quản trị viên";
    
    /**
     * Chuyển đổi role ID thành role name
     */
    public static String getRoleName(int roleId) {
        switch (roleId) {
            case GUEST_ROLE_ID:
                return GUEST_ROLE_NAME;
            case STUDENT_ROLE_ID:
                return STUDENT_ROLE_NAME;
            case TEACHER_ROLE_ID:
                return TEACHER_ROLE_NAME;
            case COURSE_MANAGER_ROLE_ID:
                return COURSE_MANAGER_ROLE_NAME;
            case USER_MANAGER_ROLE_ID:
                return USER_MANAGER_ROLE_NAME;
            case ADMIN_ROLE_ID:
                return ADMIN_ROLE_NAME;
            default:
                return "UNKNOWN";
        }
    }
    
    /**
     * Chuyển đổi role ID thành display name
     */
    public static String getRoleDisplayName(int roleId) {
        switch (roleId) {
            case GUEST_ROLE_ID:
                return GUEST_DISPLAY_NAME;
            case STUDENT_ROLE_ID:
                return STUDENT_DISPLAY_NAME;
            case TEACHER_ROLE_ID:
                return TEACHER_DISPLAY_NAME;
            case COURSE_MANAGER_ROLE_ID:
                return COURSE_MANAGER_DISPLAY_NAME;
            case USER_MANAGER_ROLE_ID:
                return USER_MANAGER_DISPLAY_NAME;
            case ADMIN_ROLE_ID:
                return ADMIN_DISPLAY_NAME;
            default:
                return "Không xác định";
        }
    }
    
    /**
     * Chuyển đổi role name thành role ID
     */
    public static int getRoleId(String roleName) {
        if (roleName == null) {
            return GUEST_ROLE_ID;
        }
        
        switch (roleName.toUpperCase()) {
            case GUEST_ROLE_NAME:
                return GUEST_ROLE_ID;
            case STUDENT_ROLE_NAME:
                return STUDENT_ROLE_ID;
            case TEACHER_ROLE_NAME:
                return TEACHER_ROLE_ID;
            case COURSE_MANAGER_ROLE_NAME:
                return COURSE_MANAGER_ROLE_ID;
            case USER_MANAGER_ROLE_NAME:
                return USER_MANAGER_ROLE_ID;
            case ADMIN_ROLE_NAME:
                return ADMIN_ROLE_ID;
            default:
                return GUEST_ROLE_ID;
        }
    }
    
    /**
     * Kiểm tra role có phải là admin không
     */
    public static boolean isAdmin(int roleId) {
        return roleId == ADMIN_ROLE_ID;
    }
    
    /**
     * Kiểm tra role có phải là teacher không
     */
    public static boolean isTeacher(int roleId) {
        return roleId == TEACHER_ROLE_ID;
    }
    
    /**
     * Kiểm tra role có phải là student không
     */
    public static boolean isStudent(int roleId) {
        return roleId == STUDENT_ROLE_ID;
    }
    
    /**
     * Kiểm tra role có phải là course manager không
     */
    public static boolean isCourseManager(int roleId) {
        return roleId == COURSE_MANAGER_ROLE_ID;
    }
    
    /**
     * Kiểm tra role có phải là user manager không
     */
    public static boolean isUserManager(int roleId) {
        return roleId == USER_MANAGER_ROLE_ID;
    }
    
    /**
     * Kiểm tra role có phải là guest không
     */
    public static boolean isGuest(int roleId) {
        return roleId == GUEST_ROLE_ID;
    }
    
    /**
     * Lấy tất cả role IDs
     */
    public static int[] getAllRoleIds() {
        return new int[]{
            GUEST_ROLE_ID,
            STUDENT_ROLE_ID,
            TEACHER_ROLE_ID,
            COURSE_MANAGER_ROLE_ID,
            USER_MANAGER_ROLE_ID,
            ADMIN_ROLE_ID
        };
    }
    
    /**
     * Lấy tất cả role names
     */
    public static String[] getAllRoleNames() {
        return new String[]{
            GUEST_ROLE_NAME,
            STUDENT_ROLE_NAME,
            TEACHER_ROLE_NAME,
            COURSE_MANAGER_ROLE_NAME,
            USER_MANAGER_ROLE_NAME,
            ADMIN_ROLE_NAME
        };
    }
    
    /**
     * Lấy tất cả display names
     */
    public static String[] getAllDisplayNames() {
        return new String[]{
            GUEST_DISPLAY_NAME,
            STUDENT_DISPLAY_NAME,
            TEACHER_DISPLAY_NAME,
            COURSE_MANAGER_DISPLAY_NAME,
            USER_MANAGER_DISPLAY_NAME,
            ADMIN_DISPLAY_NAME
        };
    }
    
    /**
     * Kiểm tra role có được phép đăng ký tự do không
     */
    public static boolean isSelfRegistrationAllowed(int roleId) {
        return roleId == STUDENT_ROLE_ID || roleId == TEACHER_ROLE_ID;
    }
    
    /**
     * Kiểm tra role có cần admin approval không
     */
    public static boolean requiresAdminApproval(int roleId) {
        return roleId == COURSE_MANAGER_ROLE_ID || 
               roleId == USER_MANAGER_ROLE_ID || 
               roleId == ADMIN_ROLE_ID;
    }
    
    /**
     * Lấy role mặc định cho user mới
     */
    public static int getDefaultRoleId() {
        return STUDENT_ROLE_ID;
    }
    
    /**
     * Lấy role name mặc định
     */
    public static String getDefaultRoleName() {
        return STUDENT_ROLE_NAME;
    }
} 