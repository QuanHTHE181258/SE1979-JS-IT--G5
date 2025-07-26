<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/19/2025
  Time: 4:02 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lesson Detail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --primary-500: #667eea;
            --primary-600: #5a69d4;
            --primary-50: #f3f1ff;
            --bg-primary: #ffffff;
            --bg-secondary: #f8f9fa;
            --text-primary: #2c3e50;
            --text-secondary: #6c757d;
            --text-white: #ffffff;
            --border-light: #e9ecef;
            --shadow-light: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --transition-medium: all 0.3s ease-in-out;
        }
        body {
            background: var(--bg-primary);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .lesson-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .lesson-card {
            background: var(--bg-primary);
            border-radius: 20px;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--border-light);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
            margin: auto;
        }
        .lesson-header {
            background: var(--primary-gradient);
            color: var(--text-white);
            padding: 40px 30px 20px 30px;
            text-align: center;
        }
        .lesson-header h2 {
            font-weight: 300;
            font-size: 2rem;
            margin-bottom: 10px;
        }
        .lesson-header p {
            opacity: 0.9;
            font-size: 1rem;
        }
        .lesson-body {
            padding: 40px;
        }
        .lesson-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-500);
            margin-bottom: 10px;
        }
        .lesson-meta {
            font-size: 15px;
            color: var(--text-secondary);
            margin-bottom: 20px;
        }
        .lesson-content {
            border-top: 1px solid var(--border-light);
            padding-top: 20px;
            font-size: 16px;
            color: var(--text-primary);
        }
        .back-btn {
            background: var(--primary-gradient);
            color: var(--text-white);
            border: none;
            border-radius: 10px;
            padding: 8px 20px;
            font-weight: 600;
            font-size: 15px;
            margin-bottom: 20px;
            transition: var(--transition-medium);
            text-decoration: none;
            display: inline-block;
        }
        .back-btn:hover {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: var(--text-white);
            box-shadow: 0 10px 25px rgba(250, 112, 154, 0.3);
        }
        .quiz-link {
            display: inline-block;
            margin-top: 25px;
            background: var(--primary-gradient);
            color: var(--text-white);
            border: none;
            border-radius: 10px;
            padding: 10px 24px;
            font-weight: 600;
            font-size: 16px;
            text-decoration: none;
            transition: var(--transition-medium);
        }
        .quiz-link:hover {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: var(--text-white);
            box-shadow: 0 10px 25px rgba(250, 112, 154, 0.3);
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="lesson-container">
    <div class="lesson-card">
        <div class="lesson-header">
            <a href="javascript:history.back()" class="back-btn"><i class="fas fa-arrow-left me-2"></i>Back</a>
            <h2>Lesson Detail</h2>
            <p>Preview lesson content and information</p>
        </div>
        <div class="lesson-body">
            <div class="lesson-title">${lesson.title}</div>
            <div class="lesson-meta">
                <span class="ms-3"><i class="fas fa-calendar-alt me-1"></i>Created: ${lesson.createdAt}</span>
                <c:if test="${lesson.isFreePreview}">
                    <span class="ms-3 badge bg-success">Free Preview</span>
                </c:if>
                <c:if test="${not empty lesson.status}">
                    <span class="ms-3 badge bg-info">Status: ${lesson.status}</span>
                </c:if>
            </div>
            <div class="lesson-content">
                ${lesson.content}
            </div>
            <a href="quizPreview?id=${lesson.lessonID}" class="quiz-link">
                <i class="fas fa-question-circle me-2"></i>Take Quiz
            </a>
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
