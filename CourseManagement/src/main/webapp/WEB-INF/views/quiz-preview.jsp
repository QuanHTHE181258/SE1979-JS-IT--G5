<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/21/2025
  Time: 2:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quiz Preview</title>
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
        .quiz-container {
            background: var(--bg-secondary);
            border-radius: 20px;
            box-shadow: var(--shadow-light);
            border: 2px solid var(--border-light);
            padding: 30px;
            margin-bottom: 30px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            transition: var(--transition-medium);
        }
        .quiz-container:hover {
            border-color: var(--primary-500);
            box-shadow: 0 8px 24px rgba(102, 126, 234, 0.15);
            transform: translateY(-2px);
        }
        .quiz-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-500);
            margin-bottom: 10px;
        }
        .quiz-question {
            font-size: 1.1rem;
            color: var(--text-primary);
            margin-bottom: 15px;
        }
        .answer-list {
            list-style: none;
            padding: 0;
            margin-bottom: 0;
        }
        .answer-list li {
            background: var(--bg-primary);
            border-radius: 8px;
            padding: 10px 18px;
            margin-bottom: 8px;
            color: var(--text-secondary);
            font-size: 15px;
            border: 1px solid var(--border-light);
            transition: var(--transition-medium);
        }
        .answer-list li:hover {
            border-color: var(--primary-500);
            background: var(--primary-50);
            color: var(--primary-500);
        }
        .no-quiz {
            text-align: center;
            font-size: 18px;
            color: #999;
            margin-top: 40px;
        }
        .quiz-header {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--primary-500);
            text-align: center;
            margin-bottom: 2.5rem;
            letter-spacing: 1px;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-fill-color: transparent;
            padding: 10px 0;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <h1 class="quiz-header">Quiz List</h1>
    <c:choose>
        <c:when test="${not empty quizList}">
            <c:set var="currentQuizID" value="" />
            <c:forEach var="quiz" items="${quizList}" varStatus="loop">
                <c:if test="${quiz.quizID != currentQuizID}">
                    <c:set var="currentQuizID" value="${quiz.quizID}" />
                    <div class="quiz-container">
                        <div class="quiz-title">${quiz.title}</div>
                        <c:set var="questionTexts" value="" />
                        <c:forEach var="question" items="${quizList}">
                            <c:if test="${question.quizID == quiz.quizID}">
                                <c:if test="${fn:contains(questionTexts, question.questionText) == false}">
                                    <c:set var="questionTexts" value="${questionTexts}${question.questionText};" />
                                    <div class="quiz-question">Câu hỏi: ${question.questionText}</div>
                                    <ul class="answer-list">
                                        <c:forEach var="answerQuiz" items="${quizList}">
                                            <c:if test="${answerQuiz.quizID == question.quizID && answerQuiz.questionText == question.questionText}">
                                                <li>${answerQuiz.answer}</li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:if>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p class="no-quiz">Không tìm thấy quiz nào.</p>
        </c:otherwise>
    </c:choose>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
