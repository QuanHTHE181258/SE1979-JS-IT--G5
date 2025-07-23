<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Quiz - ${quiz.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px;
        }
        .review-container {
            max-width: 900px;
            margin: 0 auto;
        }
        .quiz-header {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .question-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .answer-option {
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #dee2e6;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .answer-option.correct-answer {
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .answer-option.incorrect-answer {
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        .answer-option.selected-answer {
            border-width: 2px;
            border-style: solid;
        }
        .answer-icon {
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            color: white;
        }
        .answer-icon.correct {
            background-color: #28a745;
        }
        .answer-icon.incorrect {
            background-color: #dc3545;
        }
        .back-to-results {
            display: inline-block;
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .back-to-results:hover {
            background-color: #5a6268;
            color: white;
        }
        .score-summary {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .score-summary h2 {
            margin: 0;
            font-size: 2.5rem;
        }
        .completion-time {
            font-size: 0.9rem;
            color: rgba(255,255,255,0.8);
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="review-container">
    <!-- Back button -->
    <a href="javascript:history.back()" class="back-to-results mb-4 d-inline-block">
        <i class="fas fa-arrow-left me-2"></i>Back to Results
    </a>

    <!-- Quiz Header -->
    <div class="quiz-header">
        <h2 class="mb-0">${quiz.title}</h2>
        <p class="text-muted mb-0">Review Mode</p>
    </div>

    <!-- Score Summary -->
    <div class="score-summary">
        <h3 class="mb-2">Your Score</h3>
        <h2><fmt:formatNumber value="${attempt.score}" pattern="#,##0.0"/>%</h2>
        <div class="completion-time">
            Completed in <fmt:formatNumber value="${completionTimeMinutes}" maxFractionDigits="1"/> minutes
        </div>
    </div>

    <!-- Questions Review -->
    <c:forEach var="qa" items="${questionAttempts}" varStatus="status">
        <div class="question-card">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="mb-0">Question ${status.index + 1}</h5>
                <span class="badge ${qa.isCorrect ? 'bg-success' : 'bg-danger'}">
                        ${qa.isCorrect ? 'Correct' : 'Incorrect'}
                </span>
            </div>

            <p class="question-text mb-4">${qa.questionID.questionText}</p>

            <div class="answers">
                <c:forEach var="answer" items="${qa.questionID.answers}">
                    <div class="answer-option
                            ${answer.isCorrect ? 'correct-answer' : ''}
                            ${answer.id == qa.answer.id ? 'selected-answer' : ''}">

                        <c:choose>
                            <c:when test="${answer.id == qa.answer.id && answer.isCorrect}">
                                <div class="answer-icon correct">
                                    <i class="fas fa-check"></i>
                                </div>
                            </c:when>
                            <c:when test="${answer.id == qa.answer.id && !answer.isCorrect}">
                                <div class="answer-icon incorrect">
                                    <i class="fas fa-times"></i>
                                </div>
                            </c:when>
                            <c:when test="${answer.isCorrect}">
                                <div class="answer-icon correct">
                                    <i class="fas fa-check"></i>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="answer-icon" style="background-color: #e9ecef;">
                                    <i class="fas fa-circle"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <span class="answer-text">${answer.answerText}</span>

                        <c:if test="${answer.id == qa.answer.id}">
                            <span class="ms-auto badge bg-secondary">Your answer</span>
                        </c:if>
                        <c:if test="${answer.isCorrect}">
                            <span class="ms-auto badge bg-success">Correct answer</span>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:forEach>

    <!-- Action Buttons -->
    <div class="text-center mt-4 mb-5">
        <a href="learning?lessonId=${lessonId}" class="btn btn-primary me-2">
            <i class="fas fa-graduation-cap me-2"></i>Continue Learning
        </a>
        <a href="take-quiz?action=start&lessonId=${lessonId}" class="btn btn-outline-primary">
            <i class="fas fa-redo me-2"></i>Retake Quiz
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
