<%--
  Created by IntelliJ IDEA.
  User: hoang
  Date: 7/21/2025
  Time: 2:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <title>Quiz</title>
  <style>
    body {
      margin: 0;
      font-family: "Work Sans", sans-serif;
      background-color: #f9f9f9;
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 30px;
    }

    .quiz-container {
      background: white;
      border-radius: 15px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      padding: 30px;
      max-width: 600px;
      width: 100%;
    }

    .quiz-title {
      font-size: 24px;
      font-weight: bold;
      color: #5c3ec5;
      margin-bottom: 20px;
      text-align: center;
    }

    .quiz-question {
      font-size: 18px;
      font-weight: 500;
      margin-bottom: 15px;
    }

    .answer-list {
      list-style: none;
      padding-left: 0;
    }

    .answer-list li {
      background-color: #f0f0f0;
      margin-bottom: 10px;
      padding: 10px 15px;
      border-radius: 8px;
      transition: background 0.3s;
    }

    .answer-list li:hover {
      background-color: #ddd;
      cursor: pointer;
    }

    .no-quiz {
      font-size: 18px;
      color: #999;
    }
  </style>
</head>
<body>

<c:choose>
  <c:when test="${not empty quizList}">
    <c:forEach var="quiz" items="${quizList}" varStatus="loop">
      <c:if test="${loop.index == 0 || quiz.quizID != quizList[loop.index - 1].quizID}">
        <div class="quiz-container">
          <div class="quiz-title">${quiz.title}</div>
          <div class="quiz-question">Câu hỏi: ${quiz.questionText}</div>
          <ul class="answer-list">
            <c:forEach var="answerQuiz" items="${quizList}" begin="${loop.index}" end="${quizList.size() - 1}">
              <c:if test="${answerQuiz.quizID == quiz.quizID}">
                <li>${answerQuiz.answer}</li>
              </c:if>
            </c:forEach>
          </ul>
        </div>
      </c:if>
    </c:forEach>
  </c:when>
  <c:otherwise>
    <p class="no-quiz">Không tìm thấy quiz nào.</p>
  </c:otherwise>
</c:choose>

</body>
</html>

