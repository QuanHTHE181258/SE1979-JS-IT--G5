<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Student Performance Tracking</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; }
        th { background: #f4f4f4; }
    </style>
</head>
<body>
    <h2>Student Performance Tracking</h2>
    <form method="get">
        <label>Chọn khóa học:</label>
        <select name="courseId" onchange="this.form.submit()">
            <option value="">-- Chọn --</option>
            <c:forEach var="cid" items="${courses}">
                <option value="${cid}" <c:if test="${cid == selectedCourseId}">selected</c:if>>Khóa học #${cid}</option>
            </c:forEach>
        </select>
    </form>
    <c:if test="${not empty students}">
        <table>
            <tr>
                <th>Học viên</th>
                <th>Email</th>
                <th>Ngày đăng ký</th>
                <th>Tiến độ (%)</th>
                <th>Điểm</th>
                <th>Trạng thái</th>
                <th>Ngày hoàn thành</th>
                <th>Chứng chỉ</th>
            </tr>
            <c:forEach var="student" items="${students}">
                <tr>
                    <td>${student.username}</td>
                    <td>${student.email}</td>
                    <td>${student.enrollmentDate}</td>
                    <td>${student.progressPercentage}</td>
                    <td>${student.grade}</td>
                    <td>${student.status}</td>
                    <td>${student.completionDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${student.certificateIssued}">✔</c:when>
                            <c:otherwise>✘</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</body>
</html> 