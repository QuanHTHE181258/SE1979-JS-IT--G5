package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.utils.SessionUtil;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;

@WebServlet(name = "CourseManagerController", urlPatterns = {
    "/admin/courses",          // Trang giới thiệu tạo Course Manager
    "/admin/courses/new",      // Form/xử lý tạo Course Manager
    "/admin/course-management" // Trang quản lý khóa học
})
public class AdminCourseController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        User loggedInUser = SessionUtil.getUserFromSession(request);

        // Tạm thời bỏ qua kiểm tra đăng nhập cho trang giới thiệu tạo Course Manager để xem layout
        // KIỂM TRA ĐĂNG NHẬP BẮT BUỘC PHẢI CÓ TRONG CODE PRODUCTION
        if (!"/admin/courses".equals(path) && loggedInUser == null) {
             response.sendRedirect(request.getContextPath() + "/login");
             return;
        }

        // Lấy role chỉ khi user đã đăng nhập
        String userRole = (loggedInUser != null) ? loggedInUser.getRole().getRoleName() : null;

        switch (path) {
            case "/admin/courses":
                 // Chỉ ADMIN được truy cập trang giới thiệu tạo Course Manager
                 // Kiểm tra quyền này vẫn được giữ lại
                if ("ADMIN".equals(userRole)) {
                    request.getRequestDispatcher("/WEB-INF/views/admin_course.jsp").forward(request, response);
                } else if (loggedInUser != null) {
                    // Nếu đã đăng nhập nhưng không phải ADMIN
                    response.sendRedirect(request.getContextPath() + "/access-denied"); 
                } else {
                    // Nếu chưa đăng nhập, vẫn hiển thị trang (chỉ cho mục đích xem layout)
                    // Nội dung trang sẽ bị giới hạn bởi kiểm tra session trong JSP (đã comment)
                     request.getRequestDispatcher("/WEB-INF/views/admin_course.jsp").forward(request, response);
                }
                break;
                
            case "/admin/courses/new":
                // Chỉ ADMIN được truy cập form tạo Course Manager mới
                String roleParam = request.getParameter("role");
                if ("ADMIN".equals(userRole) && "COURSE_MANAGER".equals(roleParam)) {
                     request.getRequestDispatcher("/WEB-INF/views/admin_course_new.jsp").forward(request, response);
                } else if (loggedInUser != null && "ADMIN".equals(userRole)){
                    // Nếu là ADMIN nhưng role parameter sai, chuyển hướng về trang giới thiệu
                     response.sendRedirect(request.getContextPath() + "/admin/courses");
                } else {
                     // Nếu chưa đăng nhập hoặc không có quyền, chuyển hướng
                     response.sendRedirect(request.getContextPath() + (loggedInUser == null ? "/login" : "/access-denied"));
                }
                break;
                
            case "/admin/course-management":
                // ADMIN và COURSE_MANAGER được truy cập trang quản lý khóa học
                 if ("ADMIN".equals(userRole) || "COURSE_MANAGER".equals(userRole)) {
                     request.getRequestDispatcher("/WEB-INF/views/course_management.jsp").forward(request, response);
                 } else {
                      // Nếu chưa đăng nhập hoặc không có quyền, chuyển hướng
                      response.sendRedirect(request.getContextPath() + (loggedInUser == null ? "/login" : "/access-denied"));
                 }
                break;
                
            default:
                // Chuyển hướng mặc định nếu URL không khớp
                response.sendRedirect(request.getContextPath() + "/admin"); // Chuyển về trang admin dashboard nếu không khớp
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String path = request.getServletPath();
        User loggedInUser = SessionUtil.getUserFromSession(request);

        // Yêu cầu đăng nhập để thực hiện POST request
        if (loggedInUser == null) {
             response.sendRedirect(request.getContextPath() + "/login");
             return;
        }
        
        String userRole = loggedInUser.getRole().getRoleName();

        if ("/admin/courses/new".equals(path)) {
            // Chỉ ADMIN được phép xử lý POST request tạo Course Manager mới
            if ("ADMIN".equals(userRole)) {
                 // TODO: Implement course manager creation logic
                 response.sendRedirect(request.getContextPath() + "/admin/courses"); // Chuyển hướng sau khi tạo
            } else {
                 response.sendRedirect(request.getContextPath() + "/access-denied");
            }
        } else {
            // Chuyển hướng mặc định cho các POST request không khớp
             response.sendRedirect(request.getContextPath() + "/admin");
        }
    }
}
