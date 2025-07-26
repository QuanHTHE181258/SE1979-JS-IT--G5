<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quiz Attempt History</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Quiz Attempt History</h2>

    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover">
            <thead class="table-dark">
            <tr>
                <th>Attempt ID</th>
                <th>Quiz ID</th>
                <th>Quiz Title</th>
                <th>Lesson ID</th>
                <th>Lesson Title</th>
                <th>Attempt Date</th>
                <th>Score</th>
                <!--<th>Detail</th>-->
            </tr>
            </thead>
            <tbody>
            <c:forEach var="quiz" items="${listQuiz}">
                <tr>
                    <td>${quiz.attemptId}</td> <!-- Ensure quiz.attemptId is correct -->
                    <td>${quiz.quizId}</td>
                    <td>${quiz.quizTitle}</td>
                    <td>${quiz.lessonId}</td>
                    <td>${quiz.lessonTitle}</td>
                    <td>${quiz.attemptDate}</td>
                    <td>${quiz.score}</td>
                    <!--<td><a href="LessonController?action=quizDetail&attemptId=${quiz.attemptId}">Quiz Detail</a></td>  Ensure quiz.attemptId -->
                </tr>
            </c:forEach>
            <c:if test="${empty listQuiz}">
                <tr>
                    <td colspan="8" class="text-center text-muted">Không có lịch sử làm quiz nào.</td> <!-- Fixed colspan to match number of columns -->
                </tr>
            </c:if>
            </tbody>

        </table>
    </div>
    <a href="CourseController?action=myCourse" class="btn btn-outline-secondary">
        ⬅ Back to My Course
    </a>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
