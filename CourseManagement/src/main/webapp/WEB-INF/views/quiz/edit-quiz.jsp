<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 7/21/2025
  Time: 10:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Edit Quiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px 0;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .page-header {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .quiz-info-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .questions-section {
            margin-top: 40px;
        }

        .question-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: relative;
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .answers-section {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-top: 15px;
        }

        .answer-card {
            background: white;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            border: 1px solid #dee2e6;
        }

        .new-answer-form {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px dashed #dee2e6;
        }

        .add-question-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-top: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .form-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .btn {
            padding: 8px 16px;
            font-weight: 500;
        }

        .question-number {
            font-weight: 500;
            color: #6c757d;
            margin-right: 10px;
        }

        .form-control {
            border: 1px solid #dee2e6;
            padding: 10px 15px;
        }

        .form-check-label {
            margin-left: 8px;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <h2 class="mb-0">Edit Quiz</h2>
    </div>

    <!-- Quiz Info Section -->
    <div class="quiz-info-card">
        <form method="post" action="edit-quiz" class="mb-3">
            <input type="hidden" name="action" value="updateQuiz" />
            <input type="hidden" name="quizId" value="${quiz.id}" />
            <div class="mb-3">
                <label class="form-label">Quiz Title</label>
                <input type="text" class="form-control" name="title" value="${quiz.title}" required />
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Save Changes</button>
                <!-- Separate delete form -->
                <form method="post" action="edit-quiz" style="display: inline;">
                    <input type="hidden" name="action" value="deleteQuiz" />
                    <input type="hidden" name="quizId" value="${quiz.id}" />
                    <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this quiz? This action cannot be undone.');">
                        Delete Quiz
                    </button>
                </form>
            </div>
        </form>
    </div>

    <!-- Questions Section -->
    <div class="questions-section">
        <h4 class="mb-4">Questions</h4>

        <c:forEach var="question" items="${quiz.questions}" varStatus="status">
            <div class="question-card">
                <div class="question-header">
                    <span class="question-number">Question ${status.index + 1}</span>
                    <div class="form-actions">
                        <form method="post" action="edit-quiz" class="d-inline">
                            <input type="hidden" name="action" value="deleteQuestion" />
                            <input type="hidden" name="quizId" value="${quiz.id}" />
                            <input type="hidden" name="questionId" value="${question.id}" />
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Delete this question?');">
                                <i class="bi bi-trash"></i> Delete
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Question Text -->
                <form method="post" action="edit-quiz" class="mb-4">
                    <input type="hidden" name="action" value="updateQuestion" />
                    <input type="hidden" name="quizId" value="${quiz.id}" />
                    <input type="hidden" name="questionId" value="${question.id}" />
                    <div class="input-group">
                        <input type="text" class="form-control" name="questionText" value="${question.questionText}" required />
                        <button type="submit" class="btn btn-success">Save</button>
                    </div>
                </form>

                <!-- Answers Section -->
                <div class="answers-section">
                    <h6 class="mb-3">Answers</h6>
                    <c:forEach var="answer" items="${question.answers}">
                        <div class="answer-card">
                            <form method="post" action="edit-quiz" class="d-flex align-items-center gap-2">
                                <input type="hidden" name="action" value="updateAnswer" />
                                <input type="hidden" name="quizId" value="${quiz.id}" />
                                <input type="hidden" name="answerId" value="${answer.id}" />
                                <input type="text" class="form-control" name="answerText" value="${answer.answerText}" required />
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" name="isCorrect" ${answer.isCorrect ? 'checked' : ''} />
                                    <label class="form-check-label">Correct</label>
                                </div>
                                <button type="submit" class="btn btn-success btn-sm">Save</button>
                                <form method="post" action="edit-quiz" class="d-inline">
                                    <input type="hidden" name="action" value="deleteAnswer" />
                                    <input type="hidden" name="quizId" value="${quiz.id}" />
                                    <input type="hidden" name="answerId" value="${answer.id}" />
                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Delete this answer?');">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </form>
                        </div>
                    </c:forEach>

                    <!-- Add New Answer Form -->
                    <div class="new-answer-form">
                        <form method="post" action="edit-quiz" class="d-flex gap-2">
                            <input type="hidden" name="action" value="addAnswer" />
                            <input type="hidden" name="quizId" value="${quiz.id}" />
                            <input type="hidden" name="questionId" value="${question.id}" />
                            <input type="text" class="form-control" name="newAnswerText" placeholder="New answer text" required />
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="isCorrect" />
                                <label class="form-check-label">Correct</label>
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm">Add Answer</button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Add New Question Card -->
        <div class="add-question-card">
            <form method="post" action="edit-quiz">
                <input type="hidden" name="action" value="addQuestion" />
                <input type="hidden" name="quizId" value="${quiz.id}" />
                <div class="input-group">
                    <input type="text" class="form-control" name="newQuestionText" placeholder="Type new question here..." required />
                    <button type="submit" class="btn btn-primary">Add Question</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
</body>
</html>