<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ví Dụ Phân Quyền - Course Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">
            <i class="fas fa-shield-alt"></i> 
            Ví Dụ Phân Quyền
        </h1>

        <!-- Thông tin user hiện tại -->
        <div class="card mb-4">
            <div class="card-header">
                <h5><i class="fas fa-user"></i> Thông Tin User Hiện Tại</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${sessionScope.userId != null}">
                        <p><strong>User ID:</strong> ${sessionScope.userId}</p>
                        <p><strong>Username:</strong> ${sessionScope.username}</p>
                        <p><strong>Role ID:</strong> ${sessionScope.userRole}</p>
                        <p><strong>Role Name:</strong> 
                            <c:choose>
                                <c:when test="${sessionScope.userRole == '0'}">Khách</c:when>
                                <c:when test="${sessionScope.userRole == '1'}">Học viên</c:when>
                                <c:when test="${sessionScope.userRole == '2'}">Giảng viên</c:when>
                                <c:when test="${sessionScope.userRole == '3'}">Quản lý khóa học</c:when>
                                <c:when test="${sessionScope.userRole == '4'}">Quản lý người dùng</c:when>
                                <c:when test="${sessionScope.userRole == '5'}">Quản trị viên</c:when>
                                <c:otherwise>Không xác định</c:otherwise>
                            </c:choose>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-muted">Chưa đăng nhập</p>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Menu điều hướng theo quyền -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-bars"></i> Menu Điều Hướng</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Menu công khai -->
                            <div class="col-md-3 mb-2">
                                <a href="${pageContext.request.contextPath}/example/public" class="btn btn-outline-primary w-100">
                                    <i class="fas fa-globe"></i> Trang Công Khai
                                </a>
                            </div>

                            <!-- Menu cho Student -->
                            <c:if test="${sessionScope.userRole == '1'}">
                                <div class="col-md-3 mb-2">
                                    <a href="${pageContext.request.contextPath}/example/student" class="btn btn-outline-success w-100">
                                        <i class="fas fa-user-graduate"></i> Trang Student
                                    </a>
                                </div>
                            </c:if>

                            <!-- Menu cho Teacher -->
                            <c:if test="${sessionScope.userRole == '2'}">
                                <div class="col-md-3 mb-2">
                                    <a href="${pageContext.request.contextPath}/example/teacher" class="btn btn-outline-info w-100">
                                        <i class="fas fa-chalkboard-teacher"></i> Trang Teacher
                                    </a>
                                </div>
                            </c:if>

                            <!-- Menu cho Admin -->
                            <c:if test="${sessionScope.userRole == '5'}">
                                <div class="col-md-3 mb-2">
                                    <a href="${pageContext.request.contextPath}/example/admin" class="btn btn-outline-danger w-100">
                                        <i class="fas fa-user-shield"></i> Trang Admin
                                    </a>
                                </div>
                            </c:if>

                            <!-- Menu cho Admin hoặc Teacher -->
                            <c:if test="${sessionScope.userRole == '5' || sessionScope.userRole == '2'}">
                                <div class="col-md-3 mb-2">
                                    <a href="${pageContext.request.contextPath}/example/mixed" class="btn btn-outline-warning w-100">
                                        <i class="fas fa-users"></i> Trang Hỗn Hợp
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Ví dụ kiểm tra quyền cho resource -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-key"></i> Kiểm Tra Quyền Resource</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">Test quyền truy cập resource theo owner ID:</p>
                        
                        <div class="row">
                            <c:forEach var="i" begin="1" end="5">
                                <div class="col-md-2 mb-2">
                                    <a href="${pageContext.request.contextPath}/example/resource?id=${i}" 
                                       class="btn btn-sm btn-outline-secondary w-100">
                                        Resource ${i}
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <small class="text-muted">
                            <i class="fas fa-info-circle"></i> 
                            Chỉ owner hoặc admin có thể truy cập resource
                        </small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Ví dụ form với phân quyền -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-edit"></i> Form Với Phân Quyền</h5>
                    </div>
                    <div class="card-body">
                        <!-- Form tạo resource - chỉ Teacher -->
                        <c:if test="${sessionScope.userRole == '2'}">
                            <form method="post" action="${pageContext.request.contextPath}/example" class="mb-3">
                                <input type="hidden" name="action" value="create">
                                <div class="row">
                                    <div class="col-md-8">
                                        <input type="text" name="resourceName" class="form-control" 
                                               placeholder="Tên resource" required>
                                    </div>
                                    <div class="col-md-4">
                                        <button type="submit" class="btn btn-success w-100">
                                            <i class="fas fa-plus"></i> Tạo Resource
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </c:if>

                        <!-- Form update resource - Teacher hoặc Admin -->
                        <c:if test="${sessionScope.userRole == '2' || sessionScope.userRole == '5'}">
                            <form method="post" action="${pageContext.request.contextPath}/example" class="mb-3">
                                <input type="hidden" name="action" value="update">
                                <div class="row">
                                    <div class="col-md-8">
                                        <input type="text" name="resourceName" class="form-control" 
                                               placeholder="Tên resource mới" required>
                                    </div>
                                    <div class="col-md-4">
                                        <button type="submit" class="btn btn-warning w-100">
                                            <i class="fas fa-edit"></i> Cập Nhật Resource
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </c:if>

                        <!-- Form delete resource - chỉ Admin -->
                        <c:if test="${sessionScope.userRole == '5'}">
                            <form method="post" action="${pageContext.request.contextPath}/example">
                                <input type="hidden" name="action" value="delete">
                                <div class="row">
                                    <div class="col-md-8">
                                        <input type="number" name="resourceId" class="form-control" 
                                               placeholder="ID resource cần xóa" required>
                                    </div>
                                    <div class="col-md-4">
                                        <button type="submit" class="btn btn-danger w-100" 
                                                onclick="return confirm('Bạn có chắc muốn xóa resource này?')">
                                            <i class="fas fa-trash"></i> Xóa Resource
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </c:if>

                        <!-- Thông báo nếu không có quyền -->
                        <c:if test="${sessionScope.userRole == null || sessionScope.userRole == '1'}">
                            <div class="alert alert-info">
                                <i class="fas fa-lock"></i> 
                                Bạn cần quyền Teacher hoặc Admin để thực hiện các thao tác này.
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bảng hiển thị theo quyền -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5><i class="fas fa-table"></i> Bảng Dữ Liệu Theo Quyền</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên</th>
                                    <th>Mô tả</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Resource 1</td>
                                    <td>Mô tả resource 1</td>
                                    <td>
                                        <!-- View - tất cả user -->
                                        <a href="#" class="btn btn-sm btn-primary">
                                            <i class="fas fa-eye"></i> Xem
                                        </a>
                                        
                                        <!-- Edit - chỉ owner hoặc admin -->
                                        <c:if test="${sessionScope.userId == 1 || sessionScope.userRole == '5'}">
                                            <a href="#" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i> Sửa
                                            </a>
                                        </c:if>
                                        
                                        <!-- Delete - chỉ admin -->
                                        <c:if test="${sessionScope.userRole == '5'}">
                                            <a href="#" class="btn btn-sm btn-danger">
                                                <i class="fas fa-trash"></i> Xóa
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Resource 2</td>
                                    <td>Mô tả resource 2</td>
                                    <td>
                                        <a href="#" class="btn btn-sm btn-primary">
                                            <i class="fas fa-eye"></i> Xem
                                        </a>
                                        
                                        <c:if test="${sessionScope.userId == 2 || sessionScope.userRole == '5'}">
                                            <a href="#" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i> Sửa
                                            </a>
                                        </c:if>
                                        
                                        <c:if test="${sessionScope.userRole == '5'}">
                                            <a href="#" class="btn btn-sm btn-danger">
                                                <i class="fas fa-trash"></i> Xóa
                                            </a>
                                        </c:if>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thông báo lỗi phân quyền -->
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle"></i> 
                <strong>Lỗi:</strong> ${param.error}
            </div>
        </c:if>

        <!-- Thông báo thành công -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> 
                <strong>Thành công:</strong> ${param.success}
            </div>
        </c:if>

        <!-- Nút quay lại -->
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Quay Lại Trang Chủ
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 