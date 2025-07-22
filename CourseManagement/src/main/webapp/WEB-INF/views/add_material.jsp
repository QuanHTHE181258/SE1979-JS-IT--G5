<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Material</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .add-material-container {
            max-width: 500px;
            margin: 40px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(60,60,100,0.10);
            padding: 32px 32px 24px 32px;
        }
        .add-material-title {
            color: #6a5acd;
            font-weight: bold;
            text-align: center;
            margin-bottom: 24px;
            font-size: 2rem;
        }
        .form-label {
            font-weight: 600;
            color: #383a6d;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #a3a0d6;
            margin-bottom: 18px;
            padding: 10px 14px;
            font-size: 1rem;
        }
        .btn-primary {
            background: linear-gradient(135deg, #6e5fa8 0%, #5f6a8a 100%);
            border: none;
            color: #fff;
            font-weight: 600;
            border-radius: 8px;
            padding: 10px 24px;
            margin-right: 10px;
        }
        .btn-secondary {
            background: #e9ecef;
            color: #383a6d;
            border: none;
            border-radius: 8px;
            padding: 10px 24px;
        }
        .form-actions {
            text-align: center;
        }
        .alert {
            margin-bottom: 18px;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <jsp:include page="_admin_sidebar.jsp" />
    <div id="content">
        <div class="add-material-container">
            <div class="add-material-title">
                <i class="fas fa-file-upload"></i> Add Material
            </div>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>
            <form action="${pageContext.request.contextPath}/add-material" method="post" enctype="multipart/form-data">
                <input type="hidden" name="lessonId" value="${lesson.id}" />
                <label for="title" class="form-label">Material Title</label>
                <input type="text" id="title" name="title" class="form-control" required placeholder="Enter material title..." />

                <label for="file" class="form-label">Upload File</label>
                <input type="file" id="file" name="file" class="form-control" required />

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Add Material</button>
                    <a href="${pageContext.request.contextPath}/lesson-details?id=${lesson.id}" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html> 