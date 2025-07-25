<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Course Manager</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .wrapper {
            display: flex;
        }
        #sidebar {
            min-width: 250px;
            max-width: 250px;
            min-height: 100vh;
        }
        #content {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="card shadow">
            <div class="card-header py-3">
                <h2 class="m-0 font-weight-bold text-center">New Course Manager Account</h2>
            </div>
            <div class="card-body">
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success" role="alert">
                        ${successMessage}
                    </div>
                </c:if>

                <div class="form-container">
                    <h2>Create New Course Manager</h2>
                    <c:if test="${not empty errorMessage}">
                        <p style="color:red;">${errorMessage}</p>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/admin/courses/new" method="post" style="max-width:600px; margin:auto; background:#fff; padding:32px; border-radius:8px; box-shadow:0 2px 8px rgba(44,44,84,0.08);">
                      <div style="margin-bottom:16px;">
                        <label for="username" style="display:block; font-weight:600; margin-bottom:8px;">Username:</label>
                        <input type="text" id="username" name="username" required style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                      </div>
                      <div style="margin-bottom:16px;">
                        <label for="email" style="display:block; font-weight:600; margin-bottom:8px;">Email:</label>
                        <input type="email" id="email" name="email" required style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                      </div>
                      <div style="margin-bottom:16px;">
                        <label for="password" style="display:block; font-weight:600; margin-bottom:8px;">Password:</label>
                        <input type="password" id="password" name="password" required style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                      </div>
                      <div style="margin-bottom:16px;">
                        <label for="firstName" style="display:block; font-weight:600; margin-bottom:8px;">First Name:</label>
                        <input type="text" id="firstName" name="firstName" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                      </div>
                      <div style="margin-bottom:16px;">
                        <label for="lastName" style="display:block; font-weight:600; margin-bottom:8px;">Last Name:</label>
                        <input type="text" id="lastName" name="lastName" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                      </div>
                      <div style="margin-bottom:16px;">
                        <label for="phone" style="display:block; font-weight:600; margin-bottom:8px;">Phone:</label>
                        <input type="text" id="phone" name="phone" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                      </div>
                      <div style="margin-bottom:16px;">
                        <label for="role" style="display:block; font-weight:600; margin-bottom:8px;">Role:</label>
                        <select id="role" name="roleName" style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                          <option value="CourseManager" selected>Course Manager</option>
                        </select>
                      </div>
                      <div style="text-align:right;">
                        <a href="${pageContext.request.contextPath}/admin/courses" class="btn btn-secondary" style="background-color:#6c757d; color:white; padding:10px 15px; border-radius:4px; text-decoration:none; margin-right:10px;">Cancel</a>
                        <button type="submit" class="btn btn-primary" style="background-color:#007bff; color:white; padding:10px 15px; border-radius:4px; border:none;">Create Account</button>
                      </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
