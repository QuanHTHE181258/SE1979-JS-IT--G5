<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quiz Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8fafc; }
        .container { max-width: 1000px; margin: 40px auto; background: #fff; border-radius: 16px; box-shadow: 0 8px 32px 0 rgba(31,38,135,0.10); padding: 2.5rem 2rem; }
        .title { font-size: 2rem; font-weight: 700; color: #185a9d; margin-bottom: 2rem; text-align: center; }
        .question-card { background: #f8f9fa; border-radius: 8px; padding: 1rem; margin-bottom: 1rem; }
        .attempt-row:hover { background-color: #f8f9fa; }
        .nav-tabs .nav-link.active { color: #185a9d; font-weight: 600; }
    </style>
</head>
<body>
<div class="container">
    <div class="title">
        <i class="fas fa-question-circle me-2"></i>${quiz.title}
    </div>

    <nav>
        <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
            <button class="nav-link active" id="questions-tab" data-bs-toggle="tab" data-bs-target="#questions" type="button">
                Questions <span class="badge bg-secondary ms-1">${questions.size()}</span>
            </button>
            <button class="nav-link" id="attempts-tab" data-bs-toggle="tab" data-bs-target="#attempts" type="button">
                Attempts <span class="badge bg-secondary ms-1">${attempts.size()}</span>
            </button>
        </div>
    </nav>

    <div class="tab-content" id="nav-tabContent">
        <!-- Questions Tab -->
        <div class="tab-pane fade show active" id="questions">
            <div class="mb-4">
                <h4>Quiz Questions</h4>
                <c:forEach var="question" items="${questions}" varStatus="status">
                    <div class="question-card">
                        <div class="d-flex justify-content-between align-items-start">
                            <h5 class="mb-3">Question ${status.index + 1}</h5>
                        </div>
                        <p class="mb-3">${question.questionText}</p>

                        <!-- Display answers -->
                        <div class="answers ms-4">
                            <h6 class="mb-2">Answers:</h6>
                            <c:forEach var="answer" items="${questionAnswers[question.id]}">
                                <div class="answer-item mb-2">
                                    <i class="fas ${answer.isCorrect ? 'fa-check text-success' : 'fa-times text-danger'} me-2"></i>
                                    ${answer.answerText}
                                    <c:if test="${answer.isCorrect}">
                                        <span class="badge bg-success ms-2">Correct Answer</span>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty questions}">
                    <div class="alert alert-info">
                        No questions have been added to this quiz yet.
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Attempts Tab -->
        <div class="tab-pane fade" id="attempts">
            <div class="mb-4">
                <h4>Quiz Attempts</h4>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Attempt ID</th>
                                <th>User ID</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Score</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="attempt" items="${attempts}">
                                <tr class="attempt-row">
                                    <td>${attempt.id}</td>
                                    <td>${attempt.user.id}</td>
                                    <td>${attempt.startTime}</td>
                                    <td>${attempt.endTime}</td>
                                    <td>
                                        <span class="badge bg-success">${attempt.score}%</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${empty attempts}">
                    <div class="alert alert-info">
                        No attempts have been made for this quiz yet.
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-between mt-4">
        <a href="lesson-details?id=${quiz.lessonID.id}" class="btn btn-secondary">
            <i class="fas fa-arrow-left me-1"></i>Back to Lesson
        </a>
        <a href="edit-quiz?id=${quiz.id}" class="btn btn-primary">
            <i class="fas fa-edit me-1"></i>Edit Quiz
        </a>
    </div>
</div>

<!-- Bootstrap and FontAwesome -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>
