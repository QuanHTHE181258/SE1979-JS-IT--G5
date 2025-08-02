<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>

<html>
<head>
    <title>Tạo giáo viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/views/_admin_sidebar.jsp" />
<div class="container mt-5 mb-5">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Tạo tài khoản giáo viên</h4>
        </div>
        <div class="card-body">

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/admin/teachers/create">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" required />
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Mật khẩu</label>
                        <input type="password" name="password" class="form-control" required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" name="phone" class="form-control" />
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Họ</label>
                        <input type="text" name="firstName" class="form-control" required />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tên</label>
                        <input type="text" name="lastName" class="form-control" required />
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Ngày sinh</label>
                    <input type="date" name="dateOfBirth" class="form-control" required />
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Tạo giáo viên</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
