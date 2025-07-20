<%-- 
    Document   : error
    Created on : Apr 24, 2025, 3:12:10 PM
    Author     : regio
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lỗi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card border-danger">
                    <div class="card-header bg-danger text-white">
                        <h4 class="mb-0">Đã xảy ra lỗi</h4>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-danger">
                            ${errorMessage}
                        </div>
                        <div class="mt-3">
                            <button onclick="history.back()" class="btn btn-secondary me-2">
                                <i class="bi bi-arrow-left"></i> Quay lại
                            </button>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                                <i class="bi bi-house"></i> Về trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
