# Hướng Dẫn Phân Quyền - Course Management System

## 1. Tổng Quan Hệ Thống Phân Quyền

Dự án CourseManagement sử dụng hệ thống phân quyền dựa trên **Role-Based Access Control (RBAC)** với các thành phần chính:

### 1.1 Các Role trong Hệ Thống
- **0 - GUEST**: Khách (chưa đăng nhập)
- **1 - STUDENT**: Học viên
- **2 - TEACHER**: Giảng viên  
- **3 - COURSE_MANAGER**: Quản lý khóa học
- **4 - USER_MANAGER**: Quản lý người dùng
- **5 - ADMIN**: Quản trị viên

### 1.2 Cấu Trúc Database
```sql
-- Bảng roles
CREATE TABLE roles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL
);

-- Bảng user_roles (quan hệ nhiều-nhiều)
CREATE TABLE user_roles (
    UserID INT,
    RoleID INT,
    PRIMARY KEY (UserID, RoleID)
);
```

## 2. Các Thành Phần Chính

### 2.1 Entities
- `Role.java`: Entity đại diện cho role
- `UserRole.java`: Entity quan hệ nhiều-nhiều giữa User và Role
- `UserRoleId.java`: Composite key cho UserRole

### 2.2 Utilities
- `SessionUtil.java`: Quản lý session và kiểm tra quyền
- `AuthorizationUtil.java`: Tiện ích phân quyền nâng cao

### 2.3 Filters
- `AuthorizationFilter.java`: Filter tự động kiểm tra quyền theo URL pattern

### 2.4 Annotations
- `@RequireRole`: Annotation để đánh dấu quyền cần thiết

## 3. Cách Sử Dụng Phân Quyền

### 3.1 Kiểm Tra Quyền Trong Controller

#### Cách 1: Sử dụng AuthorizationUtil
```java
@WebServlet("/admin/dashboard")
public class AdminController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền Admin hoặc Course Manager
        if (!AuthorizationUtil.checkAndRedirect(request, response, "5", "3")) {
            return; // Đã redirect trong checkAndRedirect
        }
        
        // Logic xử lý khi có quyền
        // ...
    }
}
```

#### Cách 2: Kiểm tra thủ công
```java
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    // Kiểm tra đăng nhập
    if (!SessionUtil.isUserLoggedIn(request)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    // Kiểm tra quyền Admin
    if (!SessionUtil.isAdmin(request)) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
        return;
    }
    
    // Logic xử lý khi có quyền
    // ...
}
```

### 3.2 Sử Dụng Annotation @RequireRole

```java
@WebServlet("/teacher/courses")
@RequireRole(value = {"2", "5"}, requireAll = false) // Cần Teacher hoặc Admin
public class TeacherCourseController extends HttpServlet {
    
    @Override
    @RequireRole("2") // Chỉ Teacher mới có thể tạo course
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Logic tạo course
    }
}
```

### 3.3 Kiểm Tra Quyền Trong JSP

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Hiển thị menu theo quyền -->
<c:if test="${sessionScope.userRole == '5'}">
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="fas fa-home"></i> Admin Dashboard
        </a>
    </li>
</c:if>

<c:if test="${sessionScope.userRole == '2'}">
    <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/teacher/dashboard">
            <i class="fas fa-chalkboard-teacher"></i> Teacher Dashboard
        </a>
    </li>
</c:if>

<!-- Kiểm tra quyền cho button -->
<c:if test="${sessionScope.userRole == '5' || sessionScope.userRole == '3'}">
    <button class="btn btn-primary" onclick="editCourse(${course.id})">
        <i class="fas fa-edit"></i> Edit Course
    </button>
</c:if>
```

### 3.4 Kiểm Tra Quyền Resource-Specific

```java
// Kiểm tra quyền truy cập course (teacher chỉ có thể truy cập course của mình)
public boolean canAccessCourse(HttpServletRequest request, Integer courseInstructorId) {
    Integer currentUserId = SessionUtil.getUserId(request);
    
    // Admin có thể truy cập tất cả
    if (SessionUtil.isAdmin(request)) {
        return true;
    }
    
    // Teacher chỉ có thể truy cập course của mình
    if (SessionUtil.isTeacher(request)) {
        return currentUserId != null && currentUserId.equals(courseInstructorId);
    }
    
    return false;
}
```

## 4. URL Pattern Filtering

### 4.1 Cấu Hình Filter
```java
@WebFilter(urlPatterns = {
    "/admin/*",      // Chỉ Admin
    "/teacher/*",    // Chỉ Teacher  
    "/course-manager/*", // Chỉ Course Manager
    "/user-manager/*"    // Chỉ User Manager
})
public class AuthorizationFilter implements Filter {
    // Tự động kiểm tra quyền theo URL pattern
}
```

### 4.2 URL Mapping
- `/admin/*` → Role 5 (Admin)
- `/teacher/*` → Role 2 (Teacher)
- `/course-manager/*` → Role 3 (Course Manager)
- `/user-manager/*` → Role 4 (User Manager)
- `/student/*` → Role 1 (Student)

## 5. Session Management

### 5.1 Lưu Trữ Thông Tin Session
```java
// Khi đăng nhập thành công
SessionUtil.setUserSession(request, user);

// Session sẽ chứa:
// - loggedInUser: User object
// - userId: User ID
// - username: Username
// - userRole: Primary role ID
// - userRoles: List of all roles
```

### 5.2 Lấy Thông Tin Session
```java
// Kiểm tra đăng nhập
boolean isLoggedIn = SessionUtil.isUserLoggedIn(request);

// Lấy user ID
Integer userId = SessionUtil.getUserId(request);

// Lấy role
String role = SessionUtil.getUserRole(request);

// Kiểm tra role cụ thể
boolean isAdmin = SessionUtil.isAdmin(request);
boolean isTeacher = SessionUtil.isTeacher(request);
boolean isStudent = SessionUtil.isStudent(request);
```

## 6. Redirect Logic

### 6.1 Redirect Sau Đăng Nhập
```java
private void redirectToDashboard(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
    
    String contextPath = request.getContextPath();
    String userRole = SessionUtil.getUserRole(request);
    
    switch (userRole) {
        case "5": // Admin
            response.sendRedirect(contextPath + "/admin/dashboard");
            break;
        case "2": // Teacher
            response.sendRedirect(contextPath + "/teacher/dashboard");
            break;
        case "1": // Student
            response.sendRedirect(contextPath + "/student-dashboard");
            break;
        case "3": // Course Manager
            response.sendRedirect(contextPath + "/course-manager/dashboard");
            break;
        case "4": // User Manager
            response.sendRedirect(contextPath + "/user-manager/dashboard");
            break;
        default:
            response.sendRedirect(contextPath + "/student-dashboard");
            break;
    }
}
```

## 7. Best Practices

### 7.1 Security Guidelines
1. **Luôn kiểm tra quyền ở cả Controller và View**
2. **Sử dụng HTTPS cho tất cả request**
3. **Validate input từ user**
4. **Log các hoạt động quan trọng**
5. **Sử dụng prepared statements để tránh SQL injection**

### 7.2 Code Organization
1. **Tách biệt logic phân quyền vào utility classes**
2. **Sử dụng annotation để đánh dấu quyền**
3. **Tạo constants cho role IDs**
4. **Document rõ ràng quyền của từng endpoint**

### 7.3 Error Handling
```java
// Xử lý lỗi phân quyền
if (!SessionUtil.isAdmin(request)) {
    SessionUtil.setFlashMessage(request, "error", "You don't have permission to access this resource.");
    response.sendRedirect(request.getContextPath() + "/login");
    return;
}
```

## 8. Ví Dụ Thực Tế

### 8.1 Controller với Phân Quyền
```java
@WebServlet("/course/*")
public class CourseController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        
        switch (action) {
            case "/view":
                // Tất cả user đã đăng nhập có thể xem
                if (!SessionUtil.isUserLoggedIn(request)) {
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }
                viewCourse(request, response);
                break;
                
            case "/edit":
                // Chỉ owner hoặc admin có thể edit
                Integer courseId = Integer.parseInt(request.getParameter("id"));
                if (!canEditCourse(request, courseId)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                editCourse(request, response);
                break;
                
            case "/delete":
                // Chỉ admin có thể delete
                if (!SessionUtil.isAdmin(request)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
                deleteCourse(request, response);
                break;
        }
    }
    
    private boolean canEditCourse(HttpServletRequest request, Integer courseId) {
        // Logic kiểm tra quyền edit course
        return AuthorizationUtil.canAccessResource(request, getCourseOwnerId(courseId));
    }
}
```

### 8.2 JSP với Conditional Rendering
```jsp
<div class="course-actions">
    <!-- View button - tất cả user -->
    <a href="${pageContext.request.contextPath}/course/view?id=${course.id}" 
       class="btn btn-primary">View Course</a>
    
    <!-- Edit button - chỉ owner hoặc admin -->
    <c:if test="${sessionScope.userId == course.instructorId || sessionScope.userRole == '5'}">
        <a href="${pageContext.request.contextPath}/course/edit?id=${course.id}" 
           class="btn btn-warning">Edit Course</a>
    </c:if>
    
    <!-- Delete button - chỉ admin -->
    <c:if test="${sessionScope.userRole == '5'}">
        <button onclick="deleteCourse(${course.id})" class="btn btn-danger">Delete Course</button>
    </c:if>
</div>
```

## 9. Testing Phân Quyền

### 9.1 Unit Test
```java
@Test
public void testAdminAccess() {
    // Mock request với admin role
    HttpServletRequest mockRequest = mock(HttpServletRequest.class);
    when(SessionUtil.isAdmin(mockRequest)).thenReturn(true);
    
    // Test logic
    assertTrue(AuthorizationUtil.hasPermission(mockRequest, "5"));
}

@Test
public void testTeacherAccess() {
    // Mock request với teacher role
    HttpServletRequest mockRequest = mock(HttpServletRequest.class);
    when(SessionUtil.isTeacher(mockRequest)).thenReturn(true);
    
    // Test logic
    assertTrue(AuthorizationUtil.hasPermission(mockRequest, "2"));
    assertFalse(AuthorizationUtil.hasPermission(mockRequest, "5")); // Không phải admin
}
```

## 10. Troubleshooting

### 10.1 Các Lỗi Thường Gặp
1. **Session timeout**: Kiểm tra session timeout configuration
2. **Role không đúng**: Kiểm tra database và session data
3. **Filter không hoạt động**: Kiểm tra web.xml configuration
4. **Redirect loop**: Kiểm tra logic redirect

### 10.2 Debug Tips
```java
// Debug session data
System.out.println("User ID: " + SessionUtil.getUserId(request));
System.out.println("User Role: " + SessionUtil.getUserRole(request));
System.out.println("Is Admin: " + SessionUtil.isAdmin(request));
System.out.println("Is Teacher: " + SessionUtil.isTeacher(request));
```

---

**Lưu ý**: Hệ thống phân quyền này đảm bảo tính bảo mật và dễ bảo trì. Luôn cập nhật và test kỹ lưỡng khi thay đổi logic phân quyền. 