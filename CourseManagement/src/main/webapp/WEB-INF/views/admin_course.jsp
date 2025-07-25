<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Course Management - Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6fb;
        }

        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }

        .content-box {
            background: #fff;
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .table th,
        .table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        .table th {
            background: #f8f9fa;
            font-weight: 600;
        }

        .btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            background: #4a90e2;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background: #357abd;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Create Course Manager Account</h6>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card h-100">
                                        <div class="card-body text-center">
                                            <i class="fas fa-book-reader fa-3x text-success mb-3"></i>
                                            <h5 class="card-title">Course Manager</h5>
                                            <p class="card-text text-muted">Create an account for managing courses in the system</p>
                                            <a href="${pageContext.request.contextPath}/admin/courses/new?role=COURSE_MANAGER" class="btn btn-success">
                                                <i class="fas fa-book-reader"></i> Create Course Manager
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card shadow mt-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Course List</h6>
                        </div>
                        <div class="card-body">
                            <table style="width:100%; border-collapse:collapse; font-size:1rem;">
                                <thead>
                                    <tr style="background:#f5f5fa; color:#2c2c54;">
                                        <th style="padding:14px 8px; text-align:left; font-weight:700;">COURSE NAME</th>
                                        <th style="padding:14px 8px; text-align:left; font-weight:700;">INSTRUCTOR</th>
                                        <th style="padding:14px 8px; text-align:left; font-weight:700;">CATEGORY</th>
                                        <th style="padding:14px 8px; text-align:left; font-weight:700;">STATUS</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${courses}" var="course">
                                        <tr style="border-bottom:1px solid #e5e7eb;">
                                            <td style="padding:12px 8px;">${course.name}</td>
                                            <td style="padding:12px 8px;">${course.instructor}</td>
                                            <td style="padding:12px 8px;">${course.category}</td>
                                            <td style="padding:12px 8px;">${course.status}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div style="text-align:center; margin-top:20px;">
                                <a href="${pageContext.request.contextPath}/admin/course-management" class="btn btn-info" style="background:#17a2b8; color:#fff; padding:10px 20px; border:none; border-radius:4px; font-weight:600; text-decoration:none;">
                                    <i class="fas fa-book"></i> Go to Course Management
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
