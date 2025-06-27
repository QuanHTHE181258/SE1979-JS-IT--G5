<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quiz Attempt Details</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2>Quiz Attempt Details</h2>
            <a href="home" class="btn btn-outline-secondary">⬅ Back to Homepage </a>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Question</th>
                        <th>Option</th>
                        <th>Is Correct</th>
                        <th>Your Answer</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="questionOption" items="${QuizDetail}">
                        <tr>
                            <td>${questionOption.questionText}</td>
                            <td>${questionOption.optionText}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${questionOption.isCorrect}">Yes</c:when>
                                    <c:otherwise>No</c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${questionOption.userSelectedOptionID == questionOption.optionID}">
                                        <strong>Selected</strong>
                                    </c:when>
                                    <c:otherwise>
                                        Not Selected
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>

