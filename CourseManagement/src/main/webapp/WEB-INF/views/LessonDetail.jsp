<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Lesson Details</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            .question-card {
                border-left: 5px solid #007bff;
            }
            .timer-box {
                font-size: 1.2rem;
            }
        </style>
    </head>
    <body>

        <div class="container my-5">
            <div class="card mb-4">
                <div class="card-body">
                    <h2 class="card-title">${lesson.title}</h2>
                    <p><strong>Content:</strong> ${lesson.content}</p>
<%--                    <p><strong>Video:</strong> <a href="${lesson.vidURL}" target="_blank">${lesson.vidURL}</a></p>--%>
                    <p><strong>Created At:</strong> ${lesson.createdAt}</p>
                </div>
            </div>

            <c:if test="${totalQuestion > 0}">
                <c:if test="${param.showQuiz != 'true'}">
                    <a href="LessonController?action=detail&courseId=${lesson.courseID}&lessonId=${lesson.lessonId}&showQuiz=true"
                       class="btn btn-success mb-4">Take Quiz</a>
                </c:if>

                <c:if test="${param.showQuiz == 'true'}">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h3 class="card-title">${quiz.title}</h3>
                            <div class="alert alert-warning timer-box">
                                <strong>Time Remaining:</strong> <span id="timer"></span>
                            </div>

                            <form action="LessonController" method="post">
                                <input type="hidden" name="action" value="submitQuiz"/>
                                <input type="hidden" name="quizId" value="${quiz.quizId}"/>
                                <input type="hidden" name="lessonId" value="${lesson.lessonId}"/>
                                <input type="hidden" name="courseId" value="${lesson.courseID}"/>

                                <c:choose>
                                    <c:when test="${not empty quiz.questions}">
                                        <c:forEach var="question" items="${quiz.questions}">
                                            <div class="card mb-3 question-card shadow-sm">
                                                <div class="card-body">
                                                    <h5 class="card-title">${question.text}</h5>
                                                    <c:forEach var="option" items="${question.answerOptions}">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio"
                                                                   name="question_${question.questionId}"
                                                                   id="option_${option.optionId}" value="${option.optionId}">
                                                            <label class="form-check-label"
                                                                   for="option_${option.optionId}">${option.text}</label>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p>No questions available for this quiz.</p>
                                    </c:otherwise>
                                </c:choose>

                                <button type="submit" class="btn btn-primary mt-3">Submit Quiz</button>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:if>

            <a href="LessonController?courseId=${lesson.courseID}" class="btn btn-secondary">Back to Lesson List</a>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            var durationMinutes = ${durationMinutes}; // from server
            var durationSeconds = durationMinutes * 60;

            var timerElement = document.getElementById('timer');
            var formElement = document.querySelector('form[action="LessonController"]');

            function updateTimer() {
                var minutes = Math.floor(durationSeconds / 60);
                var seconds = durationSeconds % 60;
                timerElement.textContent = minutes + "m " + (seconds < 10 ? "0" : "") + seconds + "s";

                if (durationSeconds <= 0) {
                    clearInterval(countdownInterval);
                    formElement.submit(); // Auto submit when time is up
                }
                durationSeconds--;
            }

            var countdownInterval = setInterval(updateTimer, 1000);
            updateTimer(); // Initial display
        </script>

    </body>
</html>
