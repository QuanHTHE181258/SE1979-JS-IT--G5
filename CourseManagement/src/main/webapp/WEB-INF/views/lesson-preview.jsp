<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/19/2025
  Time: 4:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Lesson Detail</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f8f9fa; }
        .lesson-container { max-width: 1000px; margin: auto; background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .lesson-title { font-size: 28px; color: #2c3e50; margin-bottom: 10px; }
        .lesson-meta { font-size: 14px; color: #888; margin-bottom: 20px; }
        .lesson-content { border-top: 1px solid #ddd; padding-top: 20px; }
    </style>
</head>
<body>

<div class="lesson-container">
    <h1 class="lesson-title">${lesson.title}</h1>
    <div class="lesson-meta">
        Created at: <fmt:formatDate value="${lesson.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /> |
        Status: ${lesson.status} |
        Free Preview: <c:choose>
        <c:when test="${lesson.isFreePreview}">Yes</c:when>
        <c:otherwise>No</c:otherwise>
    </c:choose>
    </div>

    <div class="lesson-content">
        <c:out value="${lesson.content}" escapeXml="false"/>
    </div>
    <a href="quizPreview?id=${lesson.lessonID}">Lesson quizzes</a>
</div>

</body>
</html>

