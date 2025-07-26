<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Khóa Học</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/create_course_style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f8fafc 0%, #e0eafc 100%);
            min-height: 100vh;
        }
        .form-container {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.10);
            padding: 2.5rem 4.5rem 2rem 4.5rem;
            max-width: 900px;
            margin: 48px auto;
            width: 90vw;
        }
        .form-title {
            font-weight: 700;
            font-size: 2.3rem;
            color: #185a9d;
            margin-bottom: 2rem;
            text-align: center;
            letter-spacing: 1px;
        }
        label {
            font-weight: 600;
            color: #374151;
        }
        .form-control, .form-select {
            border-radius: 12px;
            padding: 0.75rem 1.25rem;
            font-size: 1.08rem;
            margin-bottom: 0.5rem;
            border: 1.5px solid #e0eafc;
        }
        .form-control:focus, .form-select:focus {
            border-color: #43cea2;
            box-shadow: 0 0 0 0.15rem rgba(67,206,162,.10);
        }
        .error {
            color: #e74c3c;
            font-size: 0.97rem;
            margin-left: 8px;
        }
        .btn-create {
            background: linear-gradient(135deg, #43cea2 0%, #185a9d 100%);
            color: #fff;
            font-weight: 600;
            border: none;
            border-radius: 12px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            box-shadow: 0 4px 16px rgba(67,206,162,0.12);
            transition: all 0.2s;
        }
        .btn-create:hover {
            background: linear-gradient(135deg, #185a9d 0%, #43cea2 100%);
            color: #fff;
            transform: translateY(-2px) scale(1.03);
        }
        .btn-cancel {
            background: linear-gradient(135deg, #f85032 0%, #e73827 100%);
            color: #fff;
            font-weight: 600;
            border: none;
            border-radius: 12px;
            padding: 0.75rem 2.5rem;
            font-size: 1.1rem;
            margin-left: 8px;
            box-shadow: 0 4px 16px rgba(248,80,50,0.12);
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-cancel:hover {
            background: linear-gradient(135deg, #e73827 0%, #f85032 100%);
            color: #fff;
            transform: translateY(-2px) scale(1.03);
            text-decoration: none;
        }
        .form-label {
            margin-bottom: 0.3rem;
        }
        .form-group {
            margin-bottom: 1.2rem;
        }
        .form-section {
            margin-bottom: 1.5rem;
        }
        .form-icon {
            color: #185a9d;
            margin-right: 8px;
        }
        @media (max-width: 900px) {
            .form-container {
                padding: 2rem 1rem 1.5rem 1rem;
                max-width: 99vw;
            }
        }
    </style>
</head>
<body>
<div class="form-container">
    <div class="form-title">
        <i class="fas fa-plus-circle form-icon"></i> Tạo Khóa Học Mới
    </div>
    <form action="create-course" method="post" enctype="multipart/form-data">
        <div class="form-group form-section">
            <label class="form-label"><i class="fas fa-heading form-icon"></i>Tiêu Đề:</label>
            <input type="text" class="form-control" name="title" value="${param.title}" required maxlength="255">
            <c:if test="${not empty errors.title}"><span class="error">${errors.title}</span></c:if>
        </div>
        <div class="form-group form-section">
            <label class="form-label"><i class="fas fa-align-left form-icon"></i>Mô Tả:</label>
            <textarea class="form-control" name="description" required maxlength="2000" rows="3">${param.description}</textarea>
            <c:if test="${not empty errors.description}"><span class="error">${errors.description}</span></c:if>
        </div>
        <div class="form-group form-section">
            <label class="form-label"><i class="fas fa-dollar-sign form-icon"></i>Giá ($):</label>
            <input type="number" class="form-control" name="price" min="0" step="0.01" value="${param.price}" required>
            <c:if test="${not empty errors.price}"><span class="error">${errors.price}</span></c:if>
        </div>
        <div class="form-group form-section">
            <label class="form-label"><i class="fas fa-tags form-icon"></i>Danh Mục:</label>
            <select class="form-select" name="categoryId" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}" ${cat.id == param.categoryId ? 'selected' : ''}>
                        <c:out value="${cat.name}"/>
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty errors.categoryId}"><span class="error">${errors.categoryId}</span></c:if>
        </div>
        <div class="form-group form-section">
            <label class="form-label"><i class="fas fa-chalkboard-teacher form-icon"></i>Giảng Viên:</label>
            <select class="form-select" name="instructorId" required>
                <option value="">-- Chọn giảng viên --</option>
                <c:forEach var="ins" items="${instructors}">
                    <option value="${ins.id}" ${ins.id == param.instructorId ? 'selected' : ''}>
                        <c:out value="${ins.firstName}"/> <c:out value="${ins.lastName}"/>
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty errors.instructorId}"><span class="error">${errors.instructorId}</span></c:if>
        </div>
        <div class="form-group form-section">
            <label class="form-label"><i class="fas fa-image form-icon"></i>Hình Ảnh Khóa Học:</label>
            <input type="file" class="form-control" name="image" accept="image/*" required>
            <c:if test="${not empty errors.image}"><span class="error">${errors.image}</span></c:if>
        </div>
        <div class="form-group text-center">
            <button type="submit" class="btn btn-create me-2"><i class="fas fa-save me-2"></i>Tạo Khóa Học</button>
            <a href="view-all" class="btn btn-cancel"><i class="fas fa-times me-2"></i>Hủy Bỏ</a>
        </div>
        <c:if test="${not empty errors.global}"><div class="error text-center mt-2">${errors.global}</div></c:if>
    </form>
</div>
</body>
</html>
