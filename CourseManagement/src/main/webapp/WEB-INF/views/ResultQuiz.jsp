<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Quiz Results</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2>Quiz Results</h2>
    <p><b>Lesson:</b> ${lesson.title}</p>

    <c:choose>
        <c:when test="${not empty attemptId}">
            <p><b>You have completed the quiz.</b></p>
            <%-- Get Quiz Attempt --%>
            <jsp:useBean id="quizDAO" class="project.demo.coursemanagement.dao.impl.QuizDAO" scope="request"/>
            <c:set var="attempt" value="${quizDAO.getQuizAttempt(attemptId)}" scope="request"/>
            <c:set var="quiz" value="${quizDAO.getQuizByLessonId(lesson.lessonId)}" scope="request"/>
            <c:set var="questions" value="${quizDAO.getQuestionsByQuizId(quiz.quizId)}" scope="request"/>
            <c:set var="userAnswers" value="${quizDAO.getUserAnswers(attemptId)}" scope="request"/>

            <p><b>Correct answers:</b> ${attempt.score} / ${totalQuestion}</p>

            <c:choose>
                <c:when test="${(attempt.score * 1.0) / totalQuestion >= 0.7}">
                    <p style="color: green;"><b>Passed</b></p>
                </c:when>
                <c:otherwise>
                    <p style="color: red;"><b>Failed (you need to answer >= 70% of the questions correctly)</b></p>
                </c:otherwise>
            </c:choose>

            <c:forEach var="question" items="${questions}">
                <div class="card mb-3">
                    <div class="card-body">
                        <h5 class="card-title">${question.text}</h5>
                        <c:set var="userAnswer" value="${null}"/>
                        <c:forEach var="ua" items="${userAnswers}">
                            <c:if test="${ua.questionId == question.questionId}">
                                <c:set var="userAnswer" value="${ua}"/>
                            </c:if>
                        </c:forEach>

                        <c:set var="correctOptionId" value="0"/>
                        <c:forEach var="option" items="${quizDAO.getAnswerOptionsByQuestionId(question.questionId)}">
                            <c:if test="${option.isCorrect}">
                                <c:set var="correctOptionId" value="${option.optionId}"/>
                            </c:if>
                        </c:forEach>
                        <p><b>Your answer:</b>
                            <c:choose>
                                <c:when test="${userAnswer != null}">
                                    <c:set var="selectedOption" value="${quizDAO.getAnswerOptionById(userAnswer.optionId)}" scope="request"/>
                                    ${selectedOption.text}
                                </c:when>
                                <c:otherwise>
                                    You did not answer this question.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <p><b>Correct answer:</b>
                            <c:set var="correctOption" value="${quizDAO.getAnswerOptionById(correctOptionId)}" scope="request"/>
                                ${correctOption.text}</p>
                        <c:choose>
                            <c:when test="${userAnswer != null && correctOptionId == selectedOption.optionId}">
                                <p style="color:green;"><b>You answered correctly!</b></p>
                            </c:when>
                            <c:otherwise>
                                <p style="color:red;"><b>You answered incorrectly!</b></p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
            <a href="LessonController?action=detail&courseId=${lesson.courseId}&lessonId=${lesson.lessonId}" class="btn btn-secondary">Back to lesson</a>
            <a href="LessonController?action=detail&courseId=${lesson.courseId}&lessonId=${lesson.lessonId+1}" class="btn btn-secondary">Next lesson</a>
        </c:when>
        <c:otherwise>
            <p><b>No information found for this quiz attempt.</b></p>
            <a href="LessonController?courseId=${lesson.courseId}" class="btn btn-secondary">Back to lesson list</a>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
