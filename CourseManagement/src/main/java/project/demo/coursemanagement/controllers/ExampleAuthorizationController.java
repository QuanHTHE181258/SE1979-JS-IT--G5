package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.annotations.RequireRole;
import project.demo.coursemanagement.utils.AuthorizationUtil;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.IOException;

/**
 * Controller ví dụ minh họa các cách phân quyền khác nhau
 * 
 * Các endpoint:
 * - /example/public: Tất cả user có thể truy cập
 * - /example/student: Chỉ Student có thể truy cập
 * - /example/teacher: Chỉ Teacher có thể truy cập
 * - /example/admin: Chỉ Admin có thể truy cập
 * - /example/mixed: Admin hoặc Teacher có thể truy cập
 * - /example/resource/:id: Kiểm tra quyền theo resource owner
 */
@WebServlet("/example/*")
public class ExampleAuthorizationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }
        
        switch (pathInfo) {
            case "/public":
                handlePublicAccess(request, response);
                break;
            case "/student":
                handleStudentAccess(request, response);
                break;
            case "/teacher":
                handleTeacherAccess(request, response);
                break;
            case "/admin":
                handleAdminAccess(request, response);
                break;
            case "/mixed":
                handleMixedAccess(request, response);
                break;
            case "/resource":
                handleResourceAccess(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    /**
     * Endpoint công khai - tất cả user có thể truy cập
     */
    private void handlePublicAccess(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Không cần kiểm tra quyền
        request.setAttribute("message", "Đây là trang công khai - tất cả user có thể truy cập");
        request.setAttribute("userInfo", getCurrentUserInfo(request));
        request.getRequestDispatcher("/WEB-INF/views/example-public.jsp").forward(request, response);
    }

    /**
     * Endpoint chỉ dành cho Student
     * Cách 1: Sử dụng AuthorizationUtil
     */
    private void handleStudentAccess(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền Student
        if (!AuthorizationUtil.checkAndRedirect(request, response, "1")) {
            return; // Đã redirect trong checkAndRedirect
        }
        
        request.setAttribute("message", "Đây là trang dành cho Student");
        request.setAttribute("userInfo", getCurrentUserInfo(request));
        request.getRequestDispatcher("/WEB-INF/views/example-student.jsp").forward(request, response);
    }

    /**
     * Endpoint chỉ dành cho Teacher
     * Cách 2: Kiểm tra thủ công
     */
    private void handleTeacherAccess(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        if (!SessionUtil.isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Kiểm tra quyền Teacher
        if (!SessionUtil.isTeacher(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied. Teacher role required.");
            return;
        }
        
        request.setAttribute("message", "Đây là trang dành cho Teacher");
        request.setAttribute("userInfo", getCurrentUserInfo(request));
        request.getRequestDispatcher("/WEB-INF/views/example-teacher.jsp").forward(request, response);
    }

    /**
     * Endpoint chỉ dành cho Admin
     * Cách 3: Sử dụng annotation @RequireRole
     */
    @RequireRole("5")
    private void handleAdminAccess(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Logic sẽ chỉ chạy nếu user có role Admin
        request.setAttribute("message", "Đây là trang dành cho Admin");
        request.setAttribute("userInfo", getCurrentUserInfo(request));
        request.getRequestDispatcher("/WEB-INF/views/example-admin.jsp").forward(request, response);
    }

    /**
     * Endpoint dành cho Admin hoặc Teacher
     * Cách 4: Sử dụng AuthorizationUtil với nhiều role
     */
    private void handleMixedAccess(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền Admin hoặc Teacher
        if (!AuthorizationUtil.checkAndSendError(request, response, "5", "2")) {
            return; // Đã gửi error trong checkAndSendError
        }
        
        request.setAttribute("message", "Đây là trang dành cho Admin hoặc Teacher");
        request.setAttribute("userInfo", getCurrentUserInfo(request));
        request.getRequestDispatcher("/WEB-INF/views/example-mixed.jsp").forward(request, response);
    }

    /**
     * Endpoint kiểm tra quyền theo resource owner
     * Ví dụ: chỉ owner hoặc admin có thể xem resource
     */
    private void handleResourceAccess(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String resourceId = request.getParameter("id");
        if (resourceId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Resource ID is required");
            return;
        }
        
        // Giả sử resource owner ID = resource ID (trong thực tế sẽ query từ database)
        Integer resourceOwnerId = Integer.parseInt(resourceId);
        
        // Kiểm tra quyền truy cập resource
        if (!AuthorizationUtil.canAccessResource(request, resourceOwnerId)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have permission to access this resource");
            return;
        }
        
        request.setAttribute("message", "Bạn có quyền truy cập resource này");
        request.setAttribute("resourceId", resourceId);
        request.setAttribute("userInfo", getCurrentUserInfo(request));
        request.getRequestDispatcher("/WEB-INF/views/example-resource.jsp").forward(request, response);
    }

    /**
     * Lấy thông tin user hiện tại
     */
    private String getCurrentUserInfo(HttpServletRequest request) {
        if (!SessionUtil.isUserLoggedIn(request)) {
            return "Chưa đăng nhập";
        }
        
        Integer userId = SessionUtil.getUserId(request);
        String username = SessionUtil.getUsername(request);
        String userRole = SessionUtil.getUserRole(request);
        
        return String.format("User ID: %d, Username: %s, Role: %s", userId, username, userRole);
    }

    /**
     * POST method với phân quyền
     */
    @Override
    @RequireRole(value = {"2", "5"}, requireAll = false) // Teacher hoặc Admin
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        switch (action) {
            case "create":
                // Chỉ Teacher có thể tạo
                if (!SessionUtil.isTeacher(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only teachers can create resources");
                    return;
                }
                handleCreate(request, response);
                break;
                
            case "update":
                // Teacher hoặc Admin có thể update
                if (!SessionUtil.isTeacher(request) && !SessionUtil.isAdmin(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Teachers or Admins can update resources");
                    return;
                }
                handleUpdate(request, response);
                break;
                
            case "delete":
                // Chỉ Admin có thể delete
                if (!SessionUtil.isAdmin(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only admins can delete resources");
                    return;
                }
                handleDelete(request, response);
                break;
                
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                break;
        }
    }

    private void handleCreate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Logic tạo resource
        response.getWriter().write("Resource created successfully");
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Logic update resource
        response.getWriter().write("Resource updated successfully");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Logic delete resource
        response.getWriter().write("Resource deleted successfully");
    }
} 