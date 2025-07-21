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
        .container { max-width: 900px; margin: 30px auto; }
        .question-block { background: #f8f9fa; border-radius: 10px; padding: 20px; margin-bottom: 20px; }
        .answer-block { margin-bottom: 10px; }
        .form-inline { display: flex; gap: 10px; align-items: center; }
        .form-inline input[type="text"] { flex: 1; }
        .btn-sm { font-size: 0.9rem; }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mb-4">Edit Quiz</h2>
    <form method="post" action="edit-quiz">
        <input type="hidden" name="action" value="updateQuiz" />
        <input type="hidden" name="quizId" value="${quiz.id}" />
        <div class="mb-3">
            <label class="form-label">Quiz Title</label>
            <input type="text" class="form-control" name="title" value="${quiz.title}" required />
        </div>
        <button type="submit" class="btn btn-primary mb-3">Update Quiz Info</button>
        <button type="submit" class="btn btn-danger mb-3 ms-2" name="action" value="deleteQuiz" onclick="return confirm('Are you sure you want to delete this quiz?');">Delete Quiz</button>
    </form>

    <h4 class="mt-4">Questions</h4>
    <c:forEach var="question" items="${quiz.questions}">
        <div class="question-block">
            <form method="post" action="edit-quiz" class="mb-2">
                <input type="hidden" name="action" value="updateQuestion" />
                <input type="hidden" name="quizId" value="${quiz.id}" />
                <input type="hidden" name="questionId" value="${question.id}" />
                <div class="form-inline mb-2">
                    <label class="form-label me-2">Q:</label>
                    <input type="text" class="form-control" name="questionText" value="${question.questionText}" required />
                    <button type="submit" class="btn btn-success btn-sm">Save</button>
                    <button type="submit" class="btn btn-danger btn-sm ms-2" name="action" value="deleteQuestion" onclick="return confirm('Delete this question?');">Delete</button>
                </div>
            </form>
            <div class="ms-4">
                <c:forEach var="answer" items="${question.answers}">
                    <form method="post" action="edit-quiz" class="answer-block form-inline">
                        <input type="hidden" name="action" value="updateAnswer" />
                        <input type="hidden" name="quizId" value="${quiz.id}" />
                        <input type="hidden" name="answerId" value="${answer.id}" />
                        <input type="text" class="form-control" name="answerText" value="${answer.answerText}" required />
                        <label class="form-check-label ms-2">
                            <input type="checkbox" class="form-check-input" name="isCorrect" <c:if test="${answer.isCorrect}">checked</c:if> /> Correct
                        </label>
                        <button type="submit" class="btn btn-success btn-sm ms-2">Save</button>
                        <button type="submit" class="btn btn-danger btn-sm ms-2" name="action" value="deleteAnswer" onclick="return confirm('Delete this answer?');">Delete</button>
                    </form>
                </c:forEach>
                <!-- Add new answer -->
                <form method="post" action="edit-quiz" class="form-inline mt-2">
                    <input type="hidden" name="action" value="addAnswer" />
                    <input type="hidden" name="quizId" value="${quiz.id}" />
                    <input type="hidden" name="questionId" value="${question.id}" />
                    <input type="text" class="form-control" name="newAnswerText" placeholder="New answer text" required />
                    <label class="form-check-label ms-2">
                        <input type="checkbox" class="form-check-input" name="isCorrect" /> Correct
                    </label>
                    <button type="submit" class="btn btn-primary btn-sm ms-2">Add Answer</button>
                </form>
            </div>
        </div>
    </c:forEach>
    <!-- Add new question -->
    <form method="post" action="edit-quiz" class="mt-4">
        <input type="hidden" name="action" value="addQuestion" />
        <input type="hidden" name="quizId" value="${quiz.id}" />
        <div class="form-inline">
            <input type="text" class="form-control" name="newQuestionText" placeholder="New question text" required />
            <button type="submit" class="btn btn-primary btn-sm ms-2">Add Question</button>
        </div>
    </form>
</div>
</body>
</html>
